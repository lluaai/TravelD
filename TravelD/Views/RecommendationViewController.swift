//
//  RecommendationViewController.swift
//  TravelAI
//
//  Created by Арайлым Сермагамбет on 07.04.2024.
//
import UIKit

class RecommendationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Открываем MapViewController при загрузке RecommendationViewController
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
