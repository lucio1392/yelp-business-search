//
//  BusinessSearchNavigator.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import Foundation
import UIKit

protocol BusinessSearchNavigatorType {
    func toBusinessDetail(_ business: Business)
    func toBusinessSearch()
}

final class BusinessSearchNavigator: BusinessSearchNavigatorType {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let businessUsecase: BusinessUseCase
    
    init(_ storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
        self.businessUsecase = UseCaseProvider.makeBusinessUseCase()
    }
    
    func toBusinessSearch() {
        let businessSearchVC = storyBoard.instantiateViewController(ofType: SearchViewController.self)
        let businessSearchViewModel = SearchViewModel(businessUsecase,
                                                      navigator: self)
        businessSearchVC.viewModel = businessSearchViewModel
        
        navigationController.pushViewController(businessSearchVC, animated: false)
    }
    
    func toBusinessDetail(_ business: Business) {
        let detailBusinessVC = storyBoard.instantiateViewController(ofType: DetailViewController.self)
        let detailViewModel = DetailViewModel(business,
                                              businessUseCase: UseCaseProvider.makeBusinessUseCase())
        detailBusinessVC.viewModel = detailViewModel
        navigationController.pushViewController(detailBusinessVC, animated: true)
    }
}
