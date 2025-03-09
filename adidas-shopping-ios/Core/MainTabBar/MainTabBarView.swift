//
//  MainTabBarView.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import SwiftUI

enum TabItems: Int, CaseIterable {
    case home = 0
    case favourites
    case cart
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favourites:
            return "Favourites"
        case .cart:
            return "Cart"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .favourites:
            return "heart.fill"
        case .cart:
            return "cart.fill"
        }
    }
}

struct MainTabBarView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State var selectedTab = 0
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            ZStack(alignment: .bottom, content: {
                
                TabView() {
                    HomeView()
                        .tabItem {
                            Label("\(TabItems.home.title)", systemImage: "\(TabItems.home.iconName)")
                        }
                    FavouritesView()
                        .tabItem {
                            Label("\(TabItems.favourites.title)", systemImage: "\(TabItems.favourites.iconName)")
                        }
                    CartView()
                        .tabItem {
                            Label("\(TabItems.cart.title)", systemImage: "\(TabItems.cart.iconName)")
                        }
                    
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
                }
                
            }
        } //: NavigationStack
    }
}

#Preview {
    MainTabBarView()
}
