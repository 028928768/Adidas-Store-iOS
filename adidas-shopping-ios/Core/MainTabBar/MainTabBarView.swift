//
//  MainTabBarView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

enum TabItems: Int, CaseIterable {
    case home = 0
    case cart
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .cart:
            return "Cart"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .cart:
            return "cart.fill"
        }
    }
}

struct MainTabBarView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            ZStack(alignment: .bottom, content: {
                
                TabView(selection: $coordinator.selectedTab) {
                    HomeView()
                        .tabItem {
                            Label("\(TabItems.home.title)", systemImage: "\(TabItems.home.iconName)")
                        }
                        .tag(0)
                    CartView()
                        .tabItem {
                            Label("\(TabItems.cart.title)", systemImage: "\(TabItems.cart.iconName)")
                        }
                        .tag(1)
                    
                }
                
                .tabViewStyle(.automatic)
                
            })
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .mainTabBar:
                    MainTabBarView()
                case .productDetail(let product):
                    ProductDetailView(product: product)
                case .cart:
                    CartView()
                case .checkout:
                    CheckoutView()
                        .navigationTitle("CHECKOUT")
                }
                
            }
        } //: NavigationStack
    }
}

#Preview {
    MainTabBarView()
}
