//
//  MapContentView.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 21/10/2021.
//

import SwiftUI

import MapKit

struct MapContentView: View {
    
    
    @StateObject private var viewModel = MapViewModel()
    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .all,
            showsUserLocation: true)
            .accentColor(Color(.systemPink))
    }
}






struct MapContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapContentView()
    }
}
