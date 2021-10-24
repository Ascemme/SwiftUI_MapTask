//
//  Place.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 22/10/2021.
//

import SwiftUI
import MapKit


struct Place: Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark


}

