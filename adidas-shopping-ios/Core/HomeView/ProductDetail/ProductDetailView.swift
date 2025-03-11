//
//  ProductDetailView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var cartViewModel: CartViewModel
    @ObservedObject private var viewModel = ProductDetailVM()
    
    
    var product: Product
    
    init(product: Product) {
        self.product = product
        self.viewModel.product = product
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Image("adidas-product-\(product.id)")
                        .resizable()
                        .scaledToFit()
                    
                    Text(product.model)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    HStack {
                        Text(product.gender)
                        Text(product.category)
                    }
                    .font(.system(size: 12, weight: .regular))
                    .padding(.top, -12)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("฿ \(String.formattedPrice(from: product.price))")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                        if !(product.isInStock ?? true) {
                            Text("Out of Stock")
                                .foregroundStyle(Color.red)
                        }
                    }
                    .padding()
                
                    Text(product.title)
                        .font(.system(size: 22, weight: .semibold))
                        .padding()
                    Text(product.description)
                        .font(.system(size: 12, weight: .regular))
                        .padding()
                        .padding(.bottom, 200)
                } //: VStack
                
            }
            
            if (product.isInStock ?? true) {
                VStack {
                    Spacer()
                    Button(action: {
                        viewModel.addToCartTapped { addedItem in
                            cartViewModel.addToCart(item: addedItem)
                            coordinator.pop()
                            coordinator.selectedTab = 2
                        }
                    }) {
                        HStack {
                            Text("Add to Bag")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)  // White text color
                                .padding()  // Add padding inside the button
                            Spacer()
                            Image(systemName: "arrow.forward")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                    }
                    .background(Color.black)  // Black background color
                    .padding()
                    .clipShape(Rectangle())  // Square shape (Rectangle)
                    
                }
            }
        } //: ZStack
    }
}

#Preview {
    ProductDetailView(product: .sampleProduct)
}
