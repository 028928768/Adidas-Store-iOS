//
//  CheckoutViewModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import Foundation

final class CheckoutViewModel: ObservableObject {
    @Published var selectedShippingMethod: String = "Adidas Store"
    @Published var isPresentedPromoView = false
    var shippingMethods = ["Adidas Store", "Flash Express", "Kerry Express"]
    
    
}
