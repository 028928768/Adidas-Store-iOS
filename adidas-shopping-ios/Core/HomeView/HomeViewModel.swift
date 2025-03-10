//
//  HomeViewModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var apiService = APIServices()
    
    func loadProducts() {
        guard products.isEmpty else { return }
        isLoading = true
        apiService.fetchProducts(completion: { result in
            self.isLoading = false
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
        })
    }
}
