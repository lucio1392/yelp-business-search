//
//  BusinessRepository.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift

final class BusinessRepository: BusinessUseCase {
    
    private let networkProvider: NetworkProvider
    private let businessSearchNetwork: BusinessSearchNetwork
    private let businessDetailNetwork: BusinessDetailNetwork
    
    init(_ networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
        self.businessSearchNetwork = networkProvider.makeBussinessSearchNetwork()
        self.businessDetailNetwork = networkProvider.makeBussinessDetailNetwork()
    }
    
    func searchBusinesses(request: BusinessSearchRequest) -> Observable<[Business]> {
        return businessSearchNetwork
            .searchBusinesses(searchRequest: request)
    }
    
    func detailBusiness(businessId: String) -> Observable<Business> {
        return businessDetailNetwork
            .detailBusiness(id: businessId)
    }
    
    
}
