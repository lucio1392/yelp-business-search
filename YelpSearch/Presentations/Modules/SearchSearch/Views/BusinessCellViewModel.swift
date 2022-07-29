//
//  BusinessCellViewModel.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import Foundation

final class BusinessCellViewModel {
    
    let imageUrl: URL?
    let name: String?
    let rating: String
    let phoneNumber: String?
    let business: Business
    
    init(_ business: Business) {
        self.imageUrl = URL(string: business.imageUrl ?? "")
        self.name = business.name?.uppercased()
        self.phoneNumber = business.phoneNumber
        self.rating = "\(business.rating ?? 0.0)"
        self.business = business
    }
    
}
