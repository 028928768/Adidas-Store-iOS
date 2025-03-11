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
            Campaign(title: "Fixed Amount Discount", discountDetails: "$20 off on your next purchase", rules: CampaignCalculation(discountType: .fixedAmount, amount: 20.0)),
            Campaign(title: "Percentage Discount", discountDetails: "15% off on all items", rules: CampaignCalculation(discountType: .percentage, amount: 15.0))
        ]),
        Category(name: "On Top", campaigns: [
            Campaign(title: "Percentage Discount by Item Category", discountDetails: "10% off on electronics", rules: CampaignCalculation(discountType: .percentage, amount: 10.0, category: "Electronics")),
            Campaign(title: "Discount by Points", discountDetails: "Use 200 points for $10 off", rules: CampaignCalculation(discountType: .points, pointsRequired: 200))
        ]),
        Category(name: "Seasonal", campaigns: [
            Campaign(title: "Winter Special", discountDetails: "Buy 1 Get 1 Free on jackets", rules: CampaignCalculation(discountType: .special, specialOffer: "Buy 1 Get 1 Free")),
            Campaign(title: "Holiday Deals", discountDetails: "Exclusive 30% off for the season", rules: CampaignCalculation(discountType: .percentage, amount: 30.0))
        ])
    ]
    
    // To calculate the dicount based on campaign rules
    func calculateDiscount(for campaign: Campaign) -> String {
        switch campaign.rules.discountType {
        case .fixedAmount:
            return "$\(campaign.rules.amount ?? 0.0) off"
        case .percentage:
            return "\(campaign.rules.amount ?? 0.0)% off"
        case .percentageOfCategory:
            return "\(campaign.rules.amount ?? 0.0)% off"
        case .points:
            return "Use \(campaign.rules.pointsRequired ?? 0) points for discount"
        case .special:
            return campaign.rules.specialOffer ?? ""
        }
    }
    
    // To apply discount calculated based on campaign rules
    func applyDiscount(for campaign: Campaign, originalPrice: Double) -> Double {
        switch campaign.rules.discountType {
        case .fixedAmount:
            return originalPrice - (campaign.rules.amount ?? 0.0)
        case .percentage:
            return originalPrice - (originalPrice * (campaign.rules.amount ?? 0.0) / 100)
        case .percentageOfCategory:
            // check if there's any matched category then apply discount
            return originalPrice
        case .points:
            // Assume each point is worth a specific amount, e.g., 0.05 per point
            let pointValue = 1.0
            return originalPrice - (Double(campaign.rules.pointsRequired ?? 0) * pointValue)
        case .special:
            // TODO: calculate subtraction
            return originalPrice / 2
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
