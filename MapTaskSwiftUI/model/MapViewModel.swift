//
//  MapViewModel.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 21/10/2021.
//
import MapKit

enum MapDetails{
    static let location = LocationPermition.currentLocation
    static let mapLocation = location
    static let mapZoom = MKCoordinateSpan (latitudeDelta: 0.01, longitudeDelta:  0.01)
    
}


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.mapLocation,
                                               span: MapDetails.mapZoom)
    
    var locationManager: CLLocationManager?
    func chackIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Show an alert letting them know this is off and to go and turn it on")
        }
    }
    
    
    
    
}








