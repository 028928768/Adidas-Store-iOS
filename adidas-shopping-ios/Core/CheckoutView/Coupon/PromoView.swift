//
//  PromoView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import SwiftUI

struct PromoView: View {
    @Binding var isPresented: Bool
    @ObservedObject var checkoutVM: CheckoutViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    HStack {
                        Spacer()
                        Text("PROMO CODES")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        Button(action: {
                            isPresented.toggle()
                            checkoutVM.clearCodeSelection()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                 
                    }
                } //: header
                .padding()
                
                Spacer()
                
                List {
                    // Loop through each category and display it
                    ForEach(checkoutVM.categories, id: \.name) { category in
                        Section(header: Text(category.name).font(.system(size: 16, weight: .medium))) {
                            // Loop through the campaigns in each category
                            ForEach(category.campaigns) { campaign in
                                HStack {
                                    Image("adidas-logo-sales")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading) {
                                        Text(campaign.discountDetails)
                                            .font(.system(size: 16, weight: .medium))
                                            .padding(.bottom, 4)
                                        
                                        Text(campaign.title)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                            .padding(.all, 2)
                                            .background(Color.black) 
                                            .shadow(radius: 5)
                                    }
                                    
                                    Spacer()
                                    
                                    // Show checkmark if campaign is selected
                                    if checkoutVM.selectedCampaigns.contains(where: { $0.id == campaign.id }) {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    
                     
                                }
                                .padding(.vertical, 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    checkoutVM.addCampaign(campaign, from: category)
                                }
                                
                            }

                        }
                    }
                }
                .listStyle(.grouped)
                
                if !checkoutVM.selectedCampaigns.isEmpty {
                    VStack {
                        Button(action: {
                            // button pressed - start calculation
                            cartViewModel.orderTotal = checkoutVM.applyCampaigns(selectedCampaigns: checkoutVM.selectedCampaigns, originalPrice: cartViewModel.orderTotal, cartItems: cartViewModel.cartItems)
                            isPresented.toggle()
                            
                        }) {
                            HStack {
                                Text("APPLY (\(checkoutVM.selectedCampaigns.count))")
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
                        
                    } //: apply button
                    .padding()
                }
            } //: Main VStack
            .alert("Selection Error", isPresented: $checkoutVM.isShowSelectionAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                if let error = checkoutVM.alertMessage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    PromoView(isPresented: .constant(true), checkoutVM: CheckoutViewModel())
}
