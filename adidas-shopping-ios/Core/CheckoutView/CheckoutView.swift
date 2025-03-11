//
//  CheckoutView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject private var viewModel = CheckoutViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        ZStack {
            
            VStack {
                Divider()
                    .padding()
                // MARK: - Products
                Group {
                if cartViewModel.cartItems.count <= 1 {
                    HStack {
                        Image("adidas-product-\(cartViewModel.cartItems[0].id)")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .clipped()
                        
                        VStack(alignment: .leading) {
                            Text(cartViewModel.cartItems[0].products?.model ?? "")
                                .font(.system(size: 16, weight: .medium))
                            Text(cartViewModel.cartItems[0].products?.size ?? "")
                                .font(.system(size: 14, weight: .light))
                        }
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(cartViewModel.cartItems, id: \.self) { item in
                                Image("adidas-product-\(item.products?.id ?? 0)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .clipped()
                            }
                        }
                        .padding()
                    }
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
                                .font(.system(size: 16, weight: .light))
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
                    
                    if viewModel.selectedCampaigns.isEmpty {
                        Button(action: {
                            viewModel.isPresentedPromoView.toggle()
                        }, label: {
                            Text("Pick discount")
                                .font(.system(size: 16, weight: .light))
                        })
                    } else {
                        Button(action: {
                            viewModel.isPresentedPromoView.toggle()
                        }, label: {
                            Image(systemName: "tag.fill")
                            Text("\(viewModel.selectedCampaigns.count) offers applied")
                                .font(.system(size: 16, weight: .light))
                        })
                        
                    }
                    
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
                    
                    Text("฿ \(String.formattedPrice(from: viewModel.checkoutTotalPrice))")
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
                                Text("PLACE ORDER")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)  // White text color
                                    .padding()  // Add padding inside the button
                                Spacer()
                                Image(systemName: "arrow.forward")
                                    .foregroundStyle(.white)
                                    .padding()
                            }
                            
                        }
                        .background(Color.black)  // Black background color
                        .clipShape(Rectangle())  // Square shape (Rectangle)
                        
                    } //: order button
                    .padding()
                }
                

            } //: Main VStack
            .sheet(isPresented: $viewModel.isPresentedPromoView) {
                PromoView(isPresented: $viewModel.isPresentedPromoView, checkoutVM: viewModel)
                    .presentationDetents([.large])
            }
            .onAppear {
                // assign order total to checkout total
                viewModel.checkoutTotalPrice = cartViewModel.orderTotal
                
                // save original checkout total price
                if viewModel.originalTotalCheckoutPrice == 0 {
                    viewModel.originalTotalCheckoutPrice = cartViewModel.orderTotal
                }
            }
        }
    }
}

#Preview {
    CheckoutView()
}
