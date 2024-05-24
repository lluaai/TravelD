//
//  Place.swift
//  TravelGuige
//
//  Created by Арайлым Сермагамбет on 21.05.2024.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var place: Place

    init(place: Place) {
        self.place = place
        self.coordinate = place.coordinate
        self.title = place.title
    }
}
