//
//  CartViewModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation
import SwiftUI

final class CartViewModel: ObservableObject {
    
    @Published var cartItems: [CartModel] = []
    @Published var orderTotal: Double = 0
    
    func addToCart(item: CartModel) {
        if !isAlreadyInCart(item: item) {
            self.cartItems.append(item)
        }
    }
    
    // check if item already exist in the cart
    func isAlreadyInCart(item: CartModel) -> Bool {
        return self.cartItems.contains(where: {$0.id == item.id})
    }
        
    func calculateTotalOrder() {
        orderTotal = 0
        
        for item in cartItems {
            orderTotal += (item.products?.price ?? 0) * Double(item.count)
        }
    }
}
