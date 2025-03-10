//
//  CartModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation


class CartModel: ObservableObject, Identifiable {
    var id: Int = 0
    var products: Product? = nil
    @Published var count: Int = 0
    
}

extension CartModel: Hashable {
    static func == (lhs: CartModel, rhs: CartModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.products == rhs.products
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(products)
    }
    
}
