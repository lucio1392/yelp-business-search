//
//  SearchUseCaseType.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift

protocol BusinessUseCase {
    func searchBusinesses(request: BusinessSearchRequest) -> Observable<[Business]>
    func detailBusiness(businessId: String) -> Observable<Business>
}
