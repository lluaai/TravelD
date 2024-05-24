//
//  RecommendationViewModel.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 09.04.2024.
//

import Foundation

class RecommendationViewModel {
    var purchase: [RecommendationItem] = []
    var totalBalance: Int = 1000
    var totalExpenses: Int = 0

    func addPurchase(description: String, amount: Int) {
        let newPurchase = RecommendationItem(description: description, amount: amount)
        purchase.append(newPurchase)
        // When a purchase is added, we need to deduct its amount from the total balance and add it to the total expenses.
        totalBalance -= amount
        totalExpenses += amount
    }
}

