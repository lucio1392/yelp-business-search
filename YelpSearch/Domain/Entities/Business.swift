//
//  Business.swift
//  YelpSearch
//
//  Created by Lucio on 28/07/2022.
//

import Foundation

struct Business: Codable {
    var id: String?
    var name: String?
    var imageUrl: String?
    var phoneNumber: String?
    var rating: Double?
    var categories: [Category]?
    var hours: [Hour]?
    var location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating, categories, hours, location
        case imageUrl = "image_url"
        case phoneNumber = "display_phone"
    }
}

struct Hour: Codable {
    var open: [OpenHour]?
}


    
