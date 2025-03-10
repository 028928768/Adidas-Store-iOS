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
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Group {
                        HStack {
                            Text("YOUR BAG")
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                            Image("adidas-logo-notext")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.horizontal)
                    } //: Header
                    Spacer()
                    
                    if viewModel.cartItems.isEmpty {
                        
                        VStack(alignment: .leading) {
                            Text("YOUR BAG IS EMPTY")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal)
                                .padding(.bottom, 2)
                            Text("Once you add something to your baf - it will appear here. Ready to get started?")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.horizontal)
                            
                            VStack {
                                Button(action: {
                                    // button pressed
                                }) {
                                    HStack {
                                        Text("GET STARTED")
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
                                
                            } //: Shopping button
                            
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                    } else {
                        VStack {
                            List(viewModel.cartItems, id: \.self) { item in
                                VStack {
                                    Text("Cart")
                                    Text(item.products?.model ?? "model")
                                }
                                
                            }
                            
                        }
                    }
                }
            } //: Main ZStac
        } //: GeometryReader
        
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
