//
//  TabBarViewModel.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 07.04.2024.
//

import UIKit

class TabBarViewModel {
    let items: [TabBarItem] = [
        TabBarItem(title: "Басты бет", imageName: "square.and.arrow.up", selectedImageName: "square.and.arrow.up.fill"),
        TabBarItem(title: "Для тебя", imageName: "purchased.circle.fill", selectedImageName: "purchased.circle.fill"),
        TabBarItem(title: "Сен үшін", imageName: "list.bullet.rectangle.fill", selectedImageName: "list.bullet.rectangle.fill"),
        TabBarItem(title: "Қосымша", imageName: "gearshape.circle.fill", selectedImageName: "gearshape.circle.fill")
    ]
}

