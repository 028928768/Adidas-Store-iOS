//
//  String + Extension.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 10/3/2568 BE.
//

import Foundation

extension String {
    static func formattedPrice(from double: Double, decimalPlaces: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPlaces
        formatter.minimumFractionDigits = decimalPlaces
        
        // Format the double into a string
        if let formattedString = formatter.string(from: NSNumber(value: double)) {
            return formattedString
        } else {
            return "N/A" // Return a default string if formatting fails
        }
    }
}

