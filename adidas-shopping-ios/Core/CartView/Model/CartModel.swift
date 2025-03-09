//
//  CartModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation


class CartModel: ObservableObject {
    
    var id: Int = 0
    var products: [Product] = []
    @Published var count: Int = 0
    @Published var totalPrice: Double = 0
    
}
