//
//  CampaignModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import Foundation

// Define the Campaign model
struct Campaign: Identifiable {
    var id = UUID()
    var title: String
    var discountDetails: String
    var rules: CampaignCalculation
}

// Define the Campaign Calculation model
enum DiscountType {
    case fixedAmount, percentage, percentageOfCategory, points, special
}

struct CampaignCalculation {
    var discountType: DiscountType
    var amount: Double? // For fixed amount or percentage
    var category: String? // For percentage discount by item category
    var pointsRequired: Int? // For discount by points
    // seasonal - special offer - unit of currency
    var threshold: Double?  // X THB, the threshold for applying discount
    var discountAmount: Double? // Y THB, the discount amount to subtract
}

// Define the Category model for Coupon, On Top, and Seasonal
struct Category {
    var name: String
    var campaigns: [Campaign]
}

