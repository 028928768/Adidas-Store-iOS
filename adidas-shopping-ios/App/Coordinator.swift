//
//  Coordinator.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 9/3/2568 BE.
//

import Foundation

enum Route: Hashable {
    case home
}

final class Coordinator: ObservableObject {
    
    @Published var path: [Route] = []
    
    func push(_ route: Route) {
        self.path.append(route)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
