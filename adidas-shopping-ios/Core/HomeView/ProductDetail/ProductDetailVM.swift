//
//  ProductDetailVM.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

final class ProductDetailVM: ObservableObject {
    
    var product: Product? = nil
            
    func addToCartTapped(completion: @escaping (CartModel) -> Void) {
        // compose item forCartModel
        guard let product = product else { return }
        let cartModel = CartModel()
        cartModel.id = product.id
        cartModel.products = product 
        cartModel.count = 1
        completion(cartModel)
    }
}
