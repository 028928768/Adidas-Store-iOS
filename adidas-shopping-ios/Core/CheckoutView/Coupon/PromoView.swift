//
//  PromoView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import SwiftUI

struct PromoView: View {
    @Binding var isPresented: Bool
    var checkoutVM: CheckoutViewModel
    var body: some View {
        ZStack {
            VStack {
                Group {
                    HStack {
                        Spacer()
                        Text("PROMO CODES")
                        
                        Spacer()
                        Button(action: {
                            isPresented.toggle()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                 
                    }
                } //: header
                .padding()
                
                Spacer()
                
                List {
                    // Loop through each category and display it
                    ForEach(checkoutVM.categories, id: \.name) { category in
                        Section(header: Text(category.name).font(.headline)) {
                            // Loop through the campaigns in each category
                            ForEach(category.campaigns) { campaign in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(campaign.title)
                                            .fontWeight(.bold)
                                        Text(campaign.discountDetails)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text(checkoutVM.calculateDiscount(for: campaign))
                                        .foregroundColor(.green)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
            } //: Main VStack
        }
    }
}

#Preview {
    PromoView(isPresented: .constant(true), checkoutVM: CheckoutViewModel())
}
