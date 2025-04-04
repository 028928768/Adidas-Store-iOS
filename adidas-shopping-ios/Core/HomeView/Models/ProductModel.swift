//
//  Product.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let model: String
    let price: Double
    let rating: Int
    let gender: String
    let size: String
    let category: String
    let isInStock: Bool?
    let title: String
    let description: String
    
    static let sampleProduct: Product = .init(id: 1, model: "ADIZERO ADIOS PRO 4", price: 8000.00, rating: 4, gender: "Men", size: "8 UK", category: "Performance", isInStock: true, title: "LIGHTWEIGHT DISTANCE RUNNING SHOES DESIGNED TO BREAK RECORDS", description: "Proven to be the world's most winning shoe, the Adizero Adios Pro line is the pinnacle of Adizero Racing shoes. The Adios Pro 4 is made for fast runners who want to experience faster, with enhanced features designed to optimize running efficiency. Our carbon-infused ENERGYRODS 2.0 provide a seamless transition from heel to toe for a snappy, efficient stride. In the midsole, a new rocker point offers improved running economy. A double layer of our best-in-class ultralight LIGHTSTRIKE PRO ensures cushioning for every quick stride you take, helping you maintain energy over the long term. The shoe rides on an outsole built with Continental™ rubber for a no-slip transition during toe-off, as well as LIGHTTRAXION, designed to reduce weight without sacrificing grip.")
    
}
