//
//  CartView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
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
                        
                        if !viewModel.cartItems.isEmpty {
                            HStack {
                                Text("\(viewModel.cartItems.count) items")
                                    .font(.system(size: 12, weight: .light))
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    
                    } //: Header
                    Spacer()
                    
                    if viewModel.cartItems.isEmpty {
                        
                        VStack(alignment: .leading) {
                            Text("YOUR BAG IS EMPTY")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal)
                                .padding(.bottom, 2)
                            Text("Once you add something to your bag - it will appear here. Ready to get started?")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.horizontal)
                            
                            VStack {
                                Button(action: {
                                    // button pressed
                                    coordinator.selectedTab = 0
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
                            List {
                                ForEach(viewModel.cartItems, id: \.self) { item in
                                    // MARK: - CartCell
                                    Group {
                                        VStack {
                                            HStack {
                                                Image("adidas-product-\(item.products?.id ?? 1)")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 125)
                                                    .clipped()
                                                
                                                VStack(alignment: .leading) {
                                                    HStack {
                                                        Text("฿ \(String.formattedPrice(from:  item.products?.price ?? 0))")
                                                            .font(.system(size: 14, weight: .semibold))
                                                        
                                                        Spacer()
                                                        
                                                        Text("1")
                                                            .font(.system(size: 14, weight: .semibold))
                                                            .padding(.horizontal)
                                                        
                                                    }
                                                    .padding(.bottom)
                                                    
                                                    Text(item.products?.model ?? "")
                                                        .font(.system(size: 16, weight: .medium))
                                                    
                                                    Text(item.products?.category ?? "")
                                                        .font(.system(size: 14, weight: .light))
                                                    
                                                    
                                                    Text("size: \(item.products?.size ?? "")")
                                                        .font(.system(size: 14, weight: .light))
                                                        .padding(.bottom, 6)
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                            }
                                        }
                                    } //: CartCell
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                                    .background(Color.appPrimaryLightGray)
                                } //: ForEach
                                .onDelete(perform: { indexSet in
                                    viewModel.removeFromCart(indexSet: indexSet)
                                })
                            } //: List
                            .listStyle(.plain)
                            .listRowSpacing(2)
                            
                            // MARK: - Summary
                            Group {
                                    Divider()
                                    HStack {
                                        Text("Total (Tax included): ")
                                        Spacer()
                                        
                                        Text("฿ \(String.formattedPrice(from:  viewModel.orderTotal))")
                                    }
                                    
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
                                    
                                } //: - Summary
                                .padding(.horizontal)
                                .padding(.bottom, 6)
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
