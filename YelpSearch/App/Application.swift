//
//  Application.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()
    
    private init() {}
    
    func configureAppInterfaceInitial(_ window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = UINavigationController()
        
        let businessSearchNavigator = BusinessSearchNavigator(storyboard,
                                                              navigationController: navigationController)
        businessSearchNavigator.toBusinessSearch()
        window.rootViewController = navigationController
    }
}
