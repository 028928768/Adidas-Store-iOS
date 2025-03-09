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
            
            Image("adidas-product-1")
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
                Text("£135.00")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("4")
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 6)
            
            VStack(alignment: .leading) {
                Text("Name: Adizero Adios Pro 4")
                Text("Type: Make Performance")
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
