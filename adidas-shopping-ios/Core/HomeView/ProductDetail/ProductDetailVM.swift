//
//  ProductDetailVM.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

final class ProductDetailVM: ObservableObject {
    
    var product: Product? = nil
    
    init(product: Product? = nil) {
        self.product = product
    }
        
    func addToCartTapped(completion: @escaping (CartModel) -> Void) {

        guard let product = product else { return }
        // compose item forCartModel
        let cartModel = CartModel()
        cartModel.id = product.id
        cartModel.products = product
        cartModel.count = 1
        completion(cartModel)
    }
}
