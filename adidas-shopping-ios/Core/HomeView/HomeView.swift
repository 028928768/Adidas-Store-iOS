//
//  HomeView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    // product grid
                    ProductsGridView()
                }
            } //: MainVStack
            
        }
    }
}

// MARK: - Views
extension HomeView {
    @ViewBuilder
    private func ProductsGridView() -> some View {
        let columns = [
            GridItem(alignment: .top),
            GridItem(alignment: .top),
        ]

        LazyVGrid(columns: columns, spacing: 0) {
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
            ProductCell()
        }
    }
}

#Preview {
    HomeView()
}
