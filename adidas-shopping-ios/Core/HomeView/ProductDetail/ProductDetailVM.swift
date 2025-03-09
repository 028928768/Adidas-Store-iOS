//
//  ProductDetailVM.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

final class ProductDetailVM: ObservableObject {
    
    var product: Product? = nil
        
    func addToCartTapped(completion: @escaping () -> Void) {
        print(product?.model)
        completion()
    }
}
