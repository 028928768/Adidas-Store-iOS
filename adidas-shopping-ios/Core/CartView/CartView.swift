//
//  CartView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        VStack {
            Text("Cart")
            List(viewModel.cartItems, id: \.self) { item in
                VStack {
                    Text("Cart")
                    Text(item.products?.model ?? "model")
                }
                
            }
        }
    }
}

#Preview {
    CartView()
}
