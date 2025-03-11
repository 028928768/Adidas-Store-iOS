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
    @Published var selectedCampaigns: [Campaign] = []
    @Published var alertMessage: String?
    @Published var isShowSelectionAlert = false
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
    
    func applyCampaigns(selectedCampaigns: [Campaign], originalPrice: Double, cartItems: [CartModel]) -> Double {
        var updatedPrice = originalPrice
        
        for campaign in selectedCampaigns {
            updatedPrice = calculateDiscountBasedOnRule(for: campaign, originalPrice: updatedPrice, cartItems: cartItems)
        }
        
        return updatedPrice
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
    
    // Function to add campaign with validation
    func addCampaign(_ campaign: Campaign, from category: Category) {
        
        // Check if campaign is already selected
        if let index = selectedCampaigns.firstIndex(where: { $0.id == campaign.id }) {
            // If the campaign is already selected, remove it (toggle off)
            selectedCampaigns.remove(at: index)
            return
        }

        // Check if user can select this campaign based on rules
        if canSelectCampaign(campaign, from: category) {
            // Remove existing campaign from the same category
            selectedCampaigns.removeAll { existing in
                categories.first(where: { $0.name == category.name })?.campaigns.contains(where: { $0.id == existing.id }) ?? false
            }
            // Add new campaign
            selectedCampaigns.append(campaign)
        }
    }
    
    // Function to check if a campaign can be selected and order is correct
    private func canSelectCampaign(_ campaign: Campaign, from category: Category) -> Bool {
        let selectedCategories = selectedCampaigns.compactMap { campaign in
            categories.first { $0.campaigns.contains(where: { $0.id == campaign.id }) }?.name
        }

        let requiredOrder = ["Coupon", "On Top", "Seasonal"]
        
        // Get the category index in required order
        guard let currentCategoryIndex = requiredOrder.firstIndex(of: category.name) else { return false }

        // Check if previous steps in the order are missing
        for i in 0..<currentCategoryIndex {
            if !selectedCategories.contains(requiredOrder[i]) {
                self.alertMessage = "You must select '\(requiredOrder[i])' before selecting '\(category.name)'."
                self.isShowSelectionAlert = true
                return false
            }
        }

        // Ensure only one campaign per category
        if selectedCategories.contains(category.name) {
            self.alertMessage = "You can only select one campaign per category."
            self.isShowSelectionAlert = true
            return false
        }

        return true
    }
    
    
    func clearCodeSelection() {
        self.selectedCampaigns.removeAll()
    }
    
}
