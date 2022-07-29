//
//  BusinessNetwork.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift

struct BusinessAPIPath {
    static let subPath = "businesses"
    static let searchBusiness = "/search"
}

final class BusinessSearchNetwork {
    private let network: Network<BusinessSearchResponse>
    
    init(network: Network<BusinessSearchResponse>) {
        self.network = network
    }
    
    func searchBusinesses(searchRequest: BusinessSearchRequest) -> Observable<[Business]> {
        let path = BusinessAPIPath.subPath + BusinessAPIPath.searchBusiness
        return network.getItem(path, request: searchRequest).map { $0.businesses }
    }
}
