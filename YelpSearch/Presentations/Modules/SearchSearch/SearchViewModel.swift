//
//  SearchViewModel.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias BusinessSearchOptions = (keyword: String, city: String, sortedBy: Int)

protocol SearchViewModelInputsType {
    var businessSearch: PublishSubject<BusinessSearchOptions> { get }
    var loadMore: PublishSubject<Void> { get }
    var onDetailBusiness: PublishSubject<Business> { get }
}

protocol SearchViewModelOutputsType {
    var businesses: PublishSubject<[BusinessCellViewModel]> { get }
    var trackingActivity: Driver<Bool> { get }
    var error: Driver<Error> { get }
}

protocol SearchViewModelType {
    var input: SearchViewModelInputsType { get }
    var output: SearchViewModelOutputsType { get }
}

internal final class SearchViewModel: SearchViewModelType, SearchViewModelInputsType, SearchViewModelOutputsType {
    
    var input: SearchViewModelInputsType { return self }
    var output: SearchViewModelOutputsType { return self }
    
//    Inputs
    var businessSearch: PublishSubject<BusinessSearchOptions>
    var loadMore: PublishSubject<Void>
    var onDetailBusiness: PublishSubject<Business>
    
//    Outputs
    var businesses: PublishSubject<[BusinessCellViewModel]>
    var error: Driver<Error> = PublishSubject<Error>()
        .asDriverOnErrorJustComplete()
    var trackingActivity: Driver<Bool> = PublishSubject<Bool>()
        .asDriverOnErrorJustComplete()
    
    private let bussinessUseCase: BusinessUseCase
    private let navigator: BusinessSearchNavigatorType
    
    private let disposedBag = DisposeBag()
    
    init(_ businessUseCase: BusinessUseCase,
         navigator: BusinessSearchNavigatorType) {
        self.bussinessUseCase = businessUseCase
        self.navigator = navigator
        self.businessSearch = PublishSubject<BusinessSearchOptions>()
        self.businesses = PublishSubject<[BusinessCellViewModel]>()
        self.loadMore = PublishSubject<()>()
        self.onDetailBusiness = PublishSubject<Business>()
        
        
        self.onDetailBusiness
            .do(onNext: navigator.toBusinessDetail(_:))
            .subscribe()
            .disposed(by: disposedBag)
        
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
      businessSearch
             .flatMapLatest { searchOption -> Driver<[BusinessCellViewModel]> in
                     
                 let keyword = searchOption.keyword
                 let location = searchOption.city.isEmpty ? "NYC" : searchOption.city
                 let sortedBy: BusinessSearchSortedOptions = searchOption.sortedBy == 0 ? .distance : .rating
                 
                 return self.bussinessUseCase
                     .searchBusinesses(request: BusinessSearchRequest(term: keyword,
                                                                      location: location,
                                                                      offset: 0,
                                                                      sortBy: sortedBy))
                     .trackActivity(activityIndicator)
                     .trackError(errorTracker)
                     .map { $0.map { BusinessCellViewModel($0) }  }
                     .asDriverOnErrorJustComplete()
             }
            .bind(to: businesses)
            .disposed(by: disposedBag)
        
        let loadMoreRequest = self
            .loadMore
            .withLatestFrom(Observable.combineLatest(businessSearch, businesses) {
                return ($0, $1)
            })
            .flatMapLatest { businessSearchOption, businessesResult -> Observable<[BusinessCellViewModel]> in
                let offset = businessesResult.count
                let searchOptions = BusinessSearchRequest(term: businessSearchOption.keyword,
                                                          location: businessSearchOption.city.isEmpty ? "NYC" :  businessSearchOption.city,
                                                          offset: offset,
                                                          sortBy: businessSearchOption.sortedBy == 0 ? .distance : .rating
                )
                
                
                return self.bussinessUseCase
                    .searchBusinesses(request: searchOptions)
                    .map { $0.map { BusinessCellViewModel($0) }  }
            }
            .share()
        
        loadMoreRequest
            .withLatestFrom(Observable.combineLatest(businesses, loadMoreRequest) {
                $0 + $1
            })
            .bind(to: businesses)
            .disposed(by: disposedBag)
   
            
        self.trackingActivity = activityIndicator.asDriver()
        self.error = errorTracker.asDriver()
    }
}


