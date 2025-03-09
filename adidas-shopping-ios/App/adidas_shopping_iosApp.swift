//
//  adidas_shopping_iosApp.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 8/3/2568 BE.
//

import SwiftUI

@main
struct adidas_shopping_iosApp: App {
    
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(self.coordinator)
        }
    }
}
