//
//  Coordinator.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

enum Route: Hashable {
    case home
    case mainTabBar
    case productDetail(Product)
}

final class Coordinator: ObservableObject {
    
    @Published var path: [Route] = []
    
    func push(_ route: Route) {
        self.path.append(route)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popTo(_ route: Route) {
        self.path.removeAll()
        self.path.append(route)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
