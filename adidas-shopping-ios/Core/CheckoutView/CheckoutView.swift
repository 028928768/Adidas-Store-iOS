//
//  CheckoutView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject private var viewModel = CheckoutViewModel()
    
    var body: some View {
        ZStack {
            
            VStack {
                
                // MARK: - Products
                Group {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(1...10, id: \.self) { index in
                                Text("Item \(index)")
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                } //: Products
                
                Divider()
                
                // Shipping
                HStack {
                    Text("SHIPPING")
                        .font(.system(size: 16, weight: .light))
                    Spacer()
                    
                    Picker("Select shipping method", selection: $viewModel.selectedShippingMethod) {
                        ForEach(viewModel.shippingMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                Divider()
                
                // Code
                HStack {
                    Text("PROMO CODE")
                        .font(.system(size: 16, weight: .light))
                    Spacer()
                    Button(action: {
                        viewModel.isPresentedPromoView.toggle()
                    }, label: {
                        Text("Pick discount")
                            .font(.system(size: 18, weight: .light))
                    })
            
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                Divider()
                
                Spacer()
                
                // Total
                HStack {
                    Text("Total")
                        .font(.system(size: 16, weight: .light))
                    Spacer()
                    
                    Text("Price")
                        .font(.system(size: 16, weight: .semibold))
            
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                Divider()
                
                Group {
                    VStack(alignment: .leading) {
                        Text("By placing an order you agree to our")
                            .font(.system(size: 12, weight: .light))
                        
                        HStack(alignment: .center) {
                            Button(action: {}) {
                                Text("Terms and Conditions")
                                    .underline()
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            
                            Text("-")
                            
                            Button(action: {}) {
                                Text("Privacy Policy")
                                    .underline()
                                    .font(.system(size: 12, weight: .semibold))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)  // Ensures HStack aligns to leading edge
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Button(action: {
                            // button pressed
                        }) {
                            HStack {
                                Text("CHECK OUT")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)  // White text color
                                    .padding()  // Add padding inside the button
                                Spacer()
                                Image(systemName: "arrow.forward")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            
                        }
                        .background(Color.black)  // Black background color
                        .clipShape(Rectangle())  // Square shape (Rectangle)
                        
                    } //: checkout button
                    .padding()
                }
                

            } //: Main VStack
            .sheet(isPresented: $viewModel.isPresentedPromoView) {
                PromoView(isPresented: $viewModel.isPresentedPromoView)
                    .presentationDetents([.large])
            }
        }
    }
}

#Preview {
    CheckoutView()
}
