//
//  SplashViewModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

@MainActor
final class SplashViewModel: ObservableObject {
    
    @Published var isActive = false
    func manageSplashAction() {
        self.isActive = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            guard let self else { return }
            self.isActive = true
            // end animation
        })
    }
}
