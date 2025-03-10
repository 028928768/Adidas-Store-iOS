//
//  ProductCell.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct ProductCell: View {
    var product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Image("adidas-product-\(product.id)")
                .resizable()
                .scaledToFit()
                .clipped()
                .overlay {
                    VStack{
                        HStack {
                            Spacer()
                            Button {
                                // - MARK: - button action - favourite tapped
                            } label: {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .font(.system(size: 24))
                                    .padding(6)
                            }
                        }
                        .padding(6)
                        Spacer()
                    }
                }
            
            HStack {
                Text("฿ \(String(format: "%.2f",  product.price))")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("\(product.rating)")
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 6)
            
            VStack(alignment: .leading) {
                Text(product.model)
                Text("\(product.gender) \(product.category)")
            }
            .padding(.horizontal, 6)
            .font(.system(size: 12, weight: .regular))
        } //: VStack
        .padding(.top, 16)
    }
}

#Preview {
    ProductCell(product: .sampleProduct)
}
