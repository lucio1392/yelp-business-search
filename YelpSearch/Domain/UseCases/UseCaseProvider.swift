//
//  UseCaseProvider.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation

final class UseCaseProvider {
    
    private static let networkProvider = NetworkProvider()
    
    static func makeBusinessUseCase() -> BusinessUseCase {
        return BusinessRepository(networkProvider)
    }
}
