import Foundation
import BigInt
import Result
import TrustCore
import TrustKeystore
import JSONRPCKit
import APIKit

public struct PreviewTransaction {
    let value: BigInt
    let account: Account
    let address: EthereumAddress?
    let contract: EthereumAddress?
    let nonce: BigInt
    let data: Data
    let gasPrice: BigInt
    let gasLimit: BigInt
    let transfer: Transfer
}

final class TransactionConfigurator {

    let session: WalletSession
    let account: Account
    let transaction: UnconfirmedTransaction
    let forceFetchNonce: Bool
    let server: RPCServer
    let chainState: ChainState
    var configuration: TransactionConfiguration {
        didSet {
            configurationUpdate.value = configuration
        }
    }
    var requestEstimateGas: Bool
    let nonceProvider: NonceProvider
    var configurationUpdate: Subscribable<TransactionConfiguration> = Subscribable(nil)
    init(
        session: WalletSession,
        account: Account,
        transaction: UnconfirmedTransaction,
        server: RPCServer,
        chainState: ChainState,
        forceFetchNonce: Bool = true
    ) {
        self.session = session
        self.account = account
        self.transaction = transaction
        self.server = server
        self.chainState = chainState
        self.forceFetchNonce = forceFetchNonce
        self.requestEstimateGas = transaction.gasLimit == .none

        let data: Data = TransactionConfigurator.data(for: transaction, from: account.address)
//        let calculatedGasLimit = transaction.gasLimit ?? TransactionConfigurator.gasLimit(for: transaction.transfer.type)
//        let calculatedGasPrice = min(max(transaction.gasPrice ?? chainState.gasPrice ?? GasPriceConfiguration.default, GasPriceConfiguration.min), GasPriceConfiguration.max)

        let nonceProvider = GetNonceProvider(storage: session.transactionsStorage, server: server, address: account.address)
        self.nonceProvider = nonceProvider

        self.configuration = TransactionConfiguration(
            gasPrice: transaction.gasPrice!,
            gasLimit: transaction.gasLimit!,
            data: data,
            nonce: transaction.nonce ?? BigInt(nonceProvider.nextNonce ?? -1)
        )
    }

    private static func data(for transaction: UnconfirmedTransaction, from: Address) -> Data {
        guard let to = transaction.to else { return Data() }
        switch transaction.transfer.type {
        case .ether, .dapp:
            return transaction.data ?? Data()
        case .token:
            return ERC20Encoder.encodeTransfer(to: to, tokens: transaction.value.magnitude)
        }
    }

    private static func gasLimit(for type: TransferType) -> BigInt {
        switch type {
        case .ether:
            return GasLimitConfiguration.default
        case .token:
            return GasLimitConfiguration.tokenTransfer
        case .dapp:
            return GasLimitConfiguration.dappTransfer
        }
    }

    private static func gasPrice(for type: Transfer) -> BigInt {
        return GasPriceConfiguration.default
    }

    func load(completion: @escaping (Result<Void, AnyError>) -> Void) {
        if requestEstimateGas {
            estimateGasLimit { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let gasLimit):
                    self.refreshGasLimit(gasLimit)
                case .failure: break
                }
            }
        }
        loadNonce(completion: completion)
    }

    func estimateGasLimit(completion: @escaping (Result<BigInt, AnyError>) -> Void) {
        let request = EstimateGasRequest(
            transaction: signTransaction
        )
        Session.send(EtherServiceRequest(for: server, batch: BatchFactory().create(request))) { result in
            switch result {
            case .success(let gasLimit):
                let gasLimit: BigInt = {
                    let limit = BigInt(gasLimit.drop0x, radix: 16) ?? BigInt()
                    if limit == BigInt(21000) {
                        return limit
                    }
                    return limit + (limit * 20 / 100)
                }()
                completion(.success(gasLimit))
            case .failure(let error):
                completion(.failure(AnyError(error)))
            }
        }
    }

    func refreshGasLimit(_ gasLimit: BigInt) {
        configuration = TransactionConfiguration(
            gasPrice: configuration.gasPrice,
            gasLimit: gasLimit,
            data: configuration.data,
            nonce: configuration.nonce
        )
    }

    func refreshNonce(_ nonce: BigInt) {
        configuration = TransactionConfiguration(
            gasPrice: configuration.gasPrice,
            gasLimit: configuration.gasLimit,
            data: configuration.data,
            nonce: nonce
        )
    }

    func loadNonce(completion: @escaping (Result<Void, AnyError>) -> Void) {
        nonceProvider.getNextNonce(force: forceFetchNonce) { [weak self] result in
            switch result {
            case .success(let nonce):
                self?.refreshNonce(nonce)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
