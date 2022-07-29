//
//  BusinessSearchRequest.swift
//  YelpSearch
//
//  Created by Lucio on 29/07/2022.
//

import Foundation

enum BusinessSearchSortedOptions: String, Codable {
    case distance
    case rating
}

struct BusinessSearchRequest: Codable {
    var term: String = ""
    var location: String
    var offset: Int = 0
    var sortBy: BusinessSearchSortedOptions
    
    enum CodingKeys: String, CodingKey {
        case term
        case location
        case offset
        case sortBy = "sort_by"
    }
}
