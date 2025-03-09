//
//  ProductsGridView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct ProductsGridView: View {
    @EnvironmentObject private var coordinator: Coordinator
    let columns = [
        GridItem(alignment: .top),
        GridItem(alignment: .top),
    ]
    var homeVM: HomeViewModel
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(homeVM.products) { product in
                ProductCell(product: product)
                    .onTapGesture {
                        coordinator.push(.productDetail(product))
                    }
            }
        }
    }
}

#Preview {
    ProductsGridView(homeVM: HomeViewModel())
        .environmentObject(Coordinator())
}
