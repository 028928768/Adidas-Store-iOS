//
//  CartView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct CartView: View {
    let carts = CartModel()
    var body: some View {
        List(carts.products, id: \.self) { item in
            VStack {
                Text(item.model)
                Text(item.size)
            }
            
        }
    }
}

#Preview {
    CartView()
}
