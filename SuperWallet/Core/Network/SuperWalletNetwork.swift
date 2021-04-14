// Copyright DApps Platform Inc. All rights reserved.

import PromiseKit
import Moya
import TrustCore
import TrustKeystore
import JSONRPCKit
import APIKit
import Result
import BigInt

import enum Result.Result

enum SuperWalletNetworkProtocolError: LocalizedError {
    case missingContractInfo
}

protocol NetworkProtocol: SuperWalletNetworkProtocol {
    func tickers(with tokenPrices: [TokenPrice]) -> Promise<[CoinTicker]>
    func chainList() -> Promise<[ChainObject]>
    func tokensList(with chainId: String, address: Address) -> Promise<[TokenObject]>
    func transactions(for address: Address, on server: RPCServer, pageNumber: Int, pageSize: Int, contract: String, completion: @escaping (_ result: ([Transaction]?, Bool)) -> Void)
    func transactionDetails(for pKHash: String, completion: @escaping ((TransactionDetail?, Bool)) -> Void)
    func search(query: String) -> Promise<[TokenObject]>
    func deviceRegistry(deviceId: String, deviceType: String, osType: String, addresses: String, completion: @escaping ((String, Bool)) -> Void)
    func buildContract(name: String, symbol: String, decimal: String, totalSupply: String, completion: @escaping ((String, Bool)) -> Void)
    func versionCheck(osType: String, deviceType: String, appVersion: Int, channelNo: String) -> Promise<VersionCheck>
    func getSourceDetail(paddr: String, address: String) -> Promise<SourceDetail>
    func getPackageList(pageNumber: Int, pageSize: Int, address: String) -> Promise<[PackageList]>
    func getProductList(pageNumber: Int, pageSize: Int, address: String, batchNum: String) -> Promise<[ProductList]>
    
    func bindTxHash(uuid: String, txhash: String, address: String, blockTime: String, completion: @escaping (Bool) -> Void)
    func listIndexUrl(chainId: String, address: String) -> Promise<[IndexUrl]>
    func isLegalForProducts(baddr: String, address: String, plist: [String], aaddr: String) -> Promise<LegalForProduct>
    func reportProductForBox(plist: [String], baddr: String, aaddr: String, address: String, completion: @escaping (Bool) -> Void)
    func isLegalForBox(bigaddr: String, address: String, blist: [String], aaddr: String) -> Promise<LegalForBox>
    func reportBigBoxPacking(bigaddr: String, address: String, blist: [String], aaddr: String, completion: @escaping (Bool) -> Void)
    func reportTraceRecord(type: String, contractAddr: String, address: String, period: Int, completion: @escaping (Bool) -> Void)
    func getListAd(pageNumber: Int, pageSize: Int) -> Promise<[ActivityModel]>
}

final class SuperWalletNetwork: NetworkProtocol {
    static let deleteMissingInternalSeconds: Double = 60.0
    static let deleyedTransactionInternalSeconds: Double = 60.0
    let provider: MoyaProvider<SuperWalletAPI>
    let wallet: WalletInfo

    private var dict: [String: [String]] {
        return SuperWalletRequestFormatter.toAddresses(from: wallet.accounts)
    }
    private var networks: [Int] {
        return SuperWalletRequestFormatter.networks(from: wallet.accounts)
    }

    init(
        provider: MoyaProvider<SuperWalletAPI>,
        wallet: WalletInfo
    ) {
        self.provider = provider
        self.wallet = wallet
    }

    private func getTickerFrom(_ rawTicker: CoinTicker) -> CoinTicker? {
        guard let contract = EthereumAddress(string: rawTicker.contract) else { return .none }
        return CoinTicker(
            price: rawTicker.price,
            percent_change_24h: rawTicker.percent_change_24h,
            contract: contract,
            tickersKey: CoinTickerKeyMaker.makeCurrencyKey()
        )
    }

    func chainList() -> Promise<[ChainObject]> {
        return Promise { seal in
            provider.request(.getChainList(pageNumber: 1, pageSize: 20)) { result in
                switch result {
                case .success(let response):
                    do {
                        print(try! response.mapJSON())
                        let items = try response.map(ArrayResponse<ChainObject>.self).list
                        seal.fulfill(items)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    func tokensList(with chainId: String, address: Address) -> Promise<[TokenObject]> {
        return Promise { seal in
            provider.request(.getTokens(chainId: chainId, address: address.description, pageNumber: 1, pageSize: 20)) { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let items = try response.map(ArrayResponse<TokenObject>.self).list
                        seal.fulfill(items)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    func tickers(with tokenPrices: [TokenPrice]) -> Promise<[CoinTicker]> {
        return Promise { seal in
            let tokensPriceToFetch = TokensPrice(
                currency: Config.current.currency.rawValue,
                tokens: tokenPrices
            )
            provider.request(.prices(tokensPriceToFetch)) { result in
                switch result {
                case .success(let response):
                    do {
                        let rawTickers = try response.map(ArrayResponse<CoinTicker>.self).list
                        let tickers = rawTickers.compactMap { self.getTickerFrom($0) }
                        seal.fulfill(tickers)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    func transactions(for address: Address, on server: RPCServer, pageNumber: Int, pageSize: Int, contract: String, completion: @escaping (([Transaction]?, Bool)) -> Void) {
        provider.request(.getTransactions(server: server, address: address.description, contractAddr: contract, pageNumber: pageNumber, pageSize: pageSize)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonData = try response.mapJSON()
                    print(jsonData)
                    let transactions = try response.map(ArrayResponse<Transaction>.self).list
                    completion((transactions, true))
                } catch {
                    completion((nil, false))
                }
            case .failure:
                completion((nil, false))
            }
        }
    }

    func transactionDetails(for pKHash: String, completion: @escaping ((TransactionDetail?, Bool)) -> Void) {
        provider.request(.getTbTransactionByPkHash(pkHash:pKHash)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonData = try response.mapJSON()
                    print(jsonData)
                    let transaction = try response.map(TransactionDetail.self, atKeyPath: "data", using: JSONDecoder())
                    completion((transaction, true))
                } catch {
                    completion((nil, false))
                }
            case .failure:
                completion((nil, false))
            }
        }
    }

    func deviceRegistry(deviceId: String, deviceType: String, osType: String, addresses: String, completion: @escaping ((String, Bool)) -> Void) {
        provider.request(.deviceRegistry(deviceId: deviceId, deviceType: deviceType, osType: osType, addresses: addresses)) { result in
            switch result {
            case .success:
                completion(("", true))
            case .failure:
                completion(("", false))
            }
        }
    }

    func buildContract(name: String, symbol: String, decimal: String, totalSupply: String, completion: @escaping ((String, Bool)) -> Void) {
        provider.request(.buildContract(name: name, symbol: symbol, decimal: decimal, totalSupply: totalSupply)) { result in
            switch result {
            case .success(let response):
                do {
                    let buildContract = try response.map(BuildContract.self, atKeyPath: "data", using: JSONDecoder())
                    completion((buildContract.input, true))
                } catch {
                    completion(("", false))
                }
            case .failure:
                completion(("h", false))
            }

        }
    }

    func search(query: String) -> Promise<[TokenObject]> {
        return Promise { seal in
            provider.request(.search(query: query, networks: networks)) { result in
                switch result {
                case .success(let response):
                    do {
                        let tokens = try response.map(ArrayResponse<TokenObject>.self).list
                        seal.fulfill(tokens)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    func versionCheck(osType: String, deviceType: String, appVersion: Int, channelNo: String) -> Promise<VersionCheck> {
        return Promise {seal in
            provider.request(.versionCheck(osType: osType, deviceType: deviceType, appVersion: appVersion, channelNo: channelNo), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let versionCheck = try response.map(VersionCheck.self, atKeyPath: "data", using: JSONDecoder())
                        seal.fulfill(versionCheck)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func getSourceDetail(paddr: String, address: String) -> Promise<SourceDetail> {
        return Promise {seal in
            provider.request(.getSourceDetail(paddr: paddr, address: address), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let sourceDetail = try response.map(SourceDetail.self, atKeyPath: "data", using: JSONDecoder())
                        seal.fulfill(sourceDetail)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func getProductList(pageNumber: Int, pageSize: Int, address: String, batchNum: String) -> Promise<[ProductList]> {
        return Promise {seal in
            provider.request(.getProductList(pageNumber: pageNumber, pageSize: pageSize, address: address, batchNum: batchNum), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let productList = try response.map(ArrayResponse<ProductList>.self).list
                        seal.fulfill(productList)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func getPackageList(pageNumber: Int, pageSize: Int, address: String) -> Promise<[PackageList]> {
        return Promise {seal in
            provider.request(.getPackageList(pageNumber: pageNumber, pageSize: pageSize, address: address), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let packageList = try response.map(ArrayResponse<PackageList>.self).list
                        seal.fulfill(packageList)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func bindTxHash(uuid: String, txhash: String, address: String, blockTime: String, completion: @escaping (Bool) -> Void) {
        provider.request(.bindTxHash(uuid: uuid, txhash: txhash, address: address, blockTime: blockTime)) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func listIndexUrl(chainId: String, address: String) -> Promise<[IndexUrl]> {
        return Promise {seal in
            provider.request(.listIndexUrl(chainId: chainId, address: address), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let indexUrlList = try response.map(ArrayResponse<IndexUrl>.self).list
                        seal.fulfill(indexUrlList)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func isLegalForProducts(baddr: String, address: String, plist: [String], aaddr: String) -> Promise<LegalForProduct> {
        return Promise {seal in
            provider.request(.isLegalForProducts(baddr: baddr, address: address, plist: plist, aaddr: aaddr), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let legalForProduct = try response.map(LegalForProduct.self, atKeyPath: "data", using: JSONDecoder())
                        seal.fulfill(legalForProduct)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func reportProductForBox(plist: [String], baddr: String, aaddr: String, address: String, completion: @escaping (Bool) -> Void) {
        provider.request(.reportProductForBox(plist: plist, baddr: baddr, aaddr: aaddr, address: address)) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func isLegalForBox(bigaddr: String, address: String, blist: [String], aaddr: String) -> Promise<LegalForBox> {
        return Promise {seal in
            provider.request(.isLegalForBox(bigaddr: bigaddr, address: address, blist: blist, aaddr: aaddr), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let legalForBox = try response.map(LegalForBox.self, atKeyPath: "data", using: JSONDecoder())
                        seal.fulfill(legalForBox)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
    
    func reportBigBoxPacking(bigaddr: String, address: String, blist: [String], aaddr: String, completion: @escaping (Bool) -> Void) {
        provider.request(.reportBigBoxPacking(bigaddr: bigaddr, address: address, blist: blist, aaddr: aaddr)) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func reportTraceRecord(type: String, contractAddr: String, address: String, period: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.reportTraceRecord(type: type, contractAddr: contractAddr, address: address, period: period)) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func getListAd(pageNumber: Int, pageSize: Int) -> Promise<[ActivityModel]> {
        return Promise {seal in
            provider.request(.getListAd(pageNumber: pageNumber, pageSize: pageSize), completion: { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try response.mapJSON()
                        print(jsonData)
                        let activityModelList = try response.map(ArrayResponse<ActivityModel>.self).list
                        seal.fulfill(activityModelList)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            })
        }
    }
}
