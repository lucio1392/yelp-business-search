//
//  BusinessDetailNetwork.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import Foundation
import RxSwift

private struct BusinessDetailRequest: Codable {}

final class BusinessDetailNetwork {
    private let network: Network<Business>
    
    init(network: Network<Business>) {
        self.network = network
    }
    
    func detailBusiness(id: String) -> Observable<Business> {
        let path = BusinessAPIPath.subPath + "/\(id)"
        return network.getItem(path, request: BusinessDetailRequest())
    }
    
}
