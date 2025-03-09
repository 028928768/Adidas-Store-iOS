//
//  HomeView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundStyle(Color.red)
                            .padding()
                    } else {
                        // product grid
                        ProductsGridView(homeVM: viewModel)
                    }
                    
                }
            } //: MainVStack
            
        }
        .onAppear {
            viewModel.loadProducts()
        }
    }
}

#Preview {
    HomeView()
}
