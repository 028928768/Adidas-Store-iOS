//
//  CheckoutViewModel.swift
//  adidas-shopping-ios
//
//  Created by Simon SIwell on 11/3/2568 BE.
//

import Foundation
import SwiftUI

final class CheckoutViewModel: ObservableObject {
    @Published var selectedShippingMethod: String = "Adidas Store"
    @Published var isPresentedPromoView = false
    @Published var selectedCampaigns: [Campaign] = []
    @Published var alertMessage: String?
    @Published var isShowSelectionAlert = false
    
    @Published var originalTotalCheckoutPrice: Double = 0.0
    @Published var checkoutTotalPrice: Double = 0.0
    
    
    @Published var appliedCampaigns: [Campaign] = []
    var shippingMethods = ["Adidas Store", "Flash Express", "Kerry Express"]
    
    // Sample Data for Campaigns with Calculation Rules
    let categories: [Category] = [
        Category(name: "Coupon", campaigns: [
            Campaign(title: "Fixed Amount Discount", discountDetails: "฿500 baht off from your purchase", rules: CampaignCalculation(discountType: .fixedAmount, amount: 500.0)),
            Campaign(title: "Percentage Discount", discountDetails: "20% off on all items", rules: CampaignCalculation(discountType: .percentage, amount: 20.0))
        ]),
        Category(name: "On Top", campaigns: [
            Campaign(title: "Percentage Discount by Item Category", discountDetails: "35% off on Performance shoes", rules: CampaignCalculation(discountType: .percentageOfCategory, amount: 35.0, category: "Performance")),
            Campaign(title: "Discount by Points", discountDetails: "Use 200 points for ฿200 baht off", rules: CampaignCalculation(discountType: .points, pointsRequired: 200))
        ]),
        Category(name: "Seasonal", campaigns: [
            Campaign(title: "Winter Special", discountDetails: "Every 1,000 baht of purchase discount 500 baht!", rules: CampaignCalculation(discountType: .special, threshold: 1000.0, discountAmount: 500.0)),
            Campaign(title: "Holiday Deals", discountDetails: "Exclusive deal discount 799 baht every 2,000 baht on this Holiday!", rules: CampaignCalculation(discountType: .special, threshold: 2000.0, discountAmount: 799.0))
        ])
    ]
    
    func applyCampaigns(selectedCampaigns: [Campaign], cartItems: [CartModel]) {
     
        var priceAfterCampaigns = self.originalTotalCheckoutPrice
        
        for campaign in selectedCampaigns {
            // add applied campaign to keep track
            self.appliedCampaigns.append(campaign)
            priceAfterCampaigns = calculateDiscountBasedOnRule(for: campaign, originalPrice: priceAfterCampaigns, cartItems: cartItems)
        }
        
        self.checkoutTotalPrice = priceAfterCampaigns
    }
    
    func revertOriginalPrice() {
        return self.checkoutTotalPrice = self.originalTotalCheckoutPrice
    }

    // To apply discount calculated based on campaign rules
    func calculateDiscountBasedOnRule(for campaign: Campaign, originalPrice: Double, cartItems: [CartModel]) -> Double {
        switch campaign.rules.discountType {
        case .fixedAmount:
            return originalPrice - (campaign.rules.amount ?? 0.0)
        case .percentage:
            return originalPrice - (originalPrice * (campaign.rules.amount ?? 0.0) / 100)
        case .percentageOfCategory:
            // Find the total price of items in the specified category
            guard let campaignCategory = campaign.rules.category else { return originalPrice }
            
            // Calculate the total price for the matching category
            let categoryTotal = cartItems.filter { $0.products?.category == campaignCategory }
                .reduce(into: 0) { into, item in
                    if let price = item.products?.price {
                        into += price // Mutate the accumulator directly
                    }
                }
            // Apply discount only to the matched category's items
            if categoryTotal > 0 {
                let discount = campaign.rules.amount ?? 0.0
                let categoryDiscount = categoryTotal * discount / 100
                return max(0, originalPrice - categoryDiscount)
            }
            
            return originalPrice // Return the original price if no matching category is found
        case .points:
            // Assume each point is worth a specific amount, e.g., $1 per point
            let pointValue = 1.0 // Define point value, could be adjusted
            let points = Double(campaign.rules.pointsRequired ?? 0)

            // Calculate the discount based on points
            let calculatedDiscount = points * pointValue

            // Cap the discount at 20% of the total price
            let maxAllowedDiscount = originalPrice * 0.20
            let discountToApply = min(calculatedDiscount, maxAllowedDiscount)

            // Apply the discount and ensure the result is not less than 0
            return max(0, originalPrice - discountToApply)
            
        case .special:
            // Special case: Every X THB, subtract Y THB
            guard let threshold = campaign.rules.threshold, let discountAmount = campaign.rules.discountAmount else {
                return originalPrice // If no valid threshold or discount amount, return the original price
            }

            // Calculate how many times the threshold fits into the total price
            let discountTimes = floor(originalPrice / threshold)

            // Subtract the discount for each threshold
            let totalDiscount = discountTimes * discountAmount

            // Ensure the discount doesn’t make the price negative
            return max(0, originalPrice - totalDiscount)
        }
    }
    
    // MARK: - Promocodes selection handling
    func addCampaign(_ campaign: Campaign, from category: Category) {
        let requiredOrder = ["Coupon", "On Top", "Seasonal"]

        // Get category index of the campaign being selected/deselected
        guard let selectedCategoryIndex = requiredOrder.firstIndex(of: category.name) else { return }

        // Get categories of currently selected campaigns
        let selectedCategories = selectedCampaigns.compactMap { campaign in
            categories.first(where: { $0.campaigns.contains(where: { $0.id == campaign.id }) })?.name
        }

        // Detect if user is deselecting (toggle behavior)
        if let existingIndex = selectedCampaigns.firstIndex(where: { $0.id == campaign.id }) {
            selectedCampaigns.remove(at: existingIndex) // Remove selected campaign

            // Remove all higher-category selections automatically
            selectedCampaigns.removeAll { existing in
                if let existingCategory = categories.first(where: { $0.campaigns.contains(where: { $0.id == existing.id }) })?.name,
                   let existingIndex = requiredOrder.firstIndex(of: existingCategory),
                   existingIndex > selectedCategoryIndex {
                    return true  // Remove all selections that are higher in order
                }
                return false
            }
            return // Exit early after removal
        }

        // Ensure selection follows the correct order
        for i in 0..<selectedCategoryIndex {
            if !selectedCategories.contains(requiredOrder[i]) {
                self.alertMessage = "You must select '\(requiredOrder[i])' before selecting '\(category.name)'."
                self.isShowSelectionAlert = true
                return
            }
        }

        // Remove all higher-category selections (if user re-selects a lower one)
        selectedCampaigns.removeAll { existing in
            if let existingCategory = categories.first(where: { $0.campaigns.contains(where: { $0.id == existing.id }) })?.name,
               let existingIndex = requiredOrder.firstIndex(of: existingCategory),
               existingIndex > selectedCategoryIndex {
                return true  // Remove all selections that are higher in order
            }
            return false
        }

        // Remove any existing campaign from the same category before adding the new one
        selectedCampaigns.removeAll { existing in
            categories.first(where: { $0.name == category.name })?.campaigns.contains(where: { $0.id == existing.id }) ?? false
        }

        // Add the new campaign
        selectedCampaigns.append(campaign)
    }

    func clearCodeSelection() {
        self.selectedCampaigns.removeAll()
    }
    
}
