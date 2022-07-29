//
//  BusinessSearchResponse.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import Foundation

struct BusinessSearchResponse: Codable {
    var businesses: [Business] = []
    var total: Int    
}
