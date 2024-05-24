//
//  Place.swift
//  TravelGuige
//
//  Created by Арайлым Сермагамбет on 21.05.2024.
//

import UIKit
import MapKit

class Place {
    var title: String
    var coordinate: CLLocationCoordinate2D
    var photos: [UIImage]
    var information: String
    var whatsappNumber: Int?
    var instagramAccount: String?
    var contactNumber: Int?
    var carDirections: String? // Информация о том, как добраться на машине
    var busDirections: String? // Информация о том, как добраться на автобусе
    var walDirections: String? // Информация о том, как добраться на автобусе



    init(title: String, 
         coordinate: CLLocationCoordinate2D,
         photos: [UIImage],
         information: String,
         whatsappNumber: Int?,
         instagramAccount: String?,
         contactNumber: Int?,
         carDirections: String?,
         busDirections: String?,
         walDirections: String?) {
        
        self.title = title
        self.coordinate = coordinate
        self.photos = photos
        self.information = information
        self.whatsappNumber = whatsappNumber
        self.instagramAccount = instagramAccount
        self.contactNumber = contactNumber
        self.carDirections = carDirections // Информация о том, как добраться на машинеbusDirections
        self.busDirections = busDirections // Информация о том, как добраться на автобусе
        self.walDirections = walDirections
    }
    
    func openWhatsApp() {
        guard let number = whatsappNumber else { return }
        let urlStr = "https://wa.me/\(number)"
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
    
    func openInstagram() {
        guard let instagram = instagramAccount, let url = URL(string: instagram) else { return }
        UIApplication.shared.open(url)
    }
    
    func displayContactNumber() -> String? {
        guard let number = contactNumber else { return nil }
        return "\(number)"
    }
}
