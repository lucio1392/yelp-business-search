//
//  Location.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import Foundation

struct Location: Codable {
    var address: String?
    var city: String?
    var zipCode: String?
    var state: String?
    
    var description: String {
        return "\(address ?? "") - \(city ?? ""), \(state ?? "") \(zipCode ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case address = "address1"
        case city
        case zipCode = "zip_code"
        case state
    }
}
