//
//  NetworkProvider.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation

final class NetworkProvider {
    private let baseURL: String
    
    init() {
        baseURL = "https://api.yelp.com/v3"
    }
    
    func makeBussinessSearchNetwork() -> BusinessSearchNetwork {
        let network = Network<BusinessSearchResponse>(baseURL)
        return BusinessSearchNetwork(network: network)
    }
    
    func makeBussinessDetailNetwork() -> BusinessDetailNetwork {
        let network = Network<Business>(baseURL)
        return BusinessDetailNetwork(network: network)
    }
    
}
