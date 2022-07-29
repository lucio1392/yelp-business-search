//
//  DetailViewModel.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailViewModelInputsType {
    
}

protocol DetailViewModelOutputsType {
    var onUpdateDetailBusiness: BehaviorSubject<Business> { get }
    var onUpdateOpenHours: PublishSubject<[String]> { get }
}

protocol DetailViewModelType {
    var input: DetailViewModelInputsType { get }
    var output: DetailViewModelOutputsType { get }
}

internal final class DetailViewModel: DetailViewModelType, DetailViewModelInputsType, DetailViewModelOutputsType {
    
    var input: DetailViewModelInputsType { return self }
    var output: DetailViewModelOutputsType { return self }
    
    var onUpdateDetailBusiness: BehaviorSubject<Business>
    var onUpdateOpenHours: PublishSubject<[String]>
    
    private let disposedBag = DisposeBag()
    private let business: Business
    private let businessUseCase: BusinessUseCase
    
    init(_ business: Business, businessUseCase: BusinessUseCase) {
        self.business = business
        self.businessUseCase = businessUseCase
        self.onUpdateOpenHours = PublishSubject<[String]>()
        self.onUpdateDetailBusiness = BehaviorSubject<Business>(value: business)
        
        if let businessId = business.id {
           businessUseCase
                .detailBusiness(businessId: businessId)
                .compactMap { $0.hours }
                .map { $0.compactMap { $0.`open` }.reduce([], +).compactMap { $0.description } }
                .bind(to: onUpdateOpenHours)
                .disposed(by: disposedBag)
        }

    }
    
}
