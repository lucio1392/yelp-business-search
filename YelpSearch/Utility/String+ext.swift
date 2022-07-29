//
//  String+ext.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import Foundation

extension String {
    func toDateFormat(with dateFormat: String = "HHmm", stringFormat: String = "HH:mm") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        dateFormatter.dateFormat = stringFormat
        
        return dateFormatter.string(from: date)
    }
}


