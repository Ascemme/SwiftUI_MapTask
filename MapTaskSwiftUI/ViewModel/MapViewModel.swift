//
//  MapViewModel.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 22/10/2021.
//

import SwiftUI
import CoreLocation
import MapKit
//All map data goes here..
class MapViewModel:NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var mapView = MKMapView()
    
    //region
    @Published var region: MKCoordinateRegion!
    //Based on Location It will setUp
    //alert
    
    @Published var permitionDenided = false
    
    //map type
    @Published var mapType: MKMapType = .standard
    //update map type
    
    //searching text
    
    @Published var searchTxt = ""
    
    //search place
    @Published var places: [Place] = []
    
    
    @Published var cityName: String = "12"
    
    
    
    
    var streentName: String = ""
    var countryName: String = ""
    
    
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    //focus location
    
    func focusLocation(){
        guard let _ = region else{return}
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func weatherSerch() {
        print(mapView.centerCoordinate)
        textShowLocation()
        
    }
    // name of reverseGeocode
    func textShowLocation() -> Void{
        let locationView = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        CLGeocoder().reverseGeocodeLocation(locationView, completionHandler: {[weak self](placemarks, error) ->Void in
            guard let self = self else { return }
            if let _ = error{
                return
            }
            guard let placemarks = placemarks?.first else{
                return
            }
            self.streentName = placemarks.subThoroughfare ?? ""
            self.cityName = placemarks.thoroughfare ?? ""
            self.countryName = placemarks.country ?? ""
            
        })
        
    }
    
    
    //search places
    func searchQuery(){
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        // fetch
        
        MKLocalSearch(request: request).start{(response, _) in
            guard let result = response else{return}
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
                
            })
            
        }
    }
    
    //Pick Search Result
    func selectRlace(place: Place){
        // Showing pin On map
        
        searchTxt = ""
        guard let coordinate = place.place.location?.coordinate else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        
        pointAnnotation.title = place.place.name ?? "No Name"
        
        //removing pics
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        // Moving Map to That Location
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //cheking permition
        switch manager.authorizationStatus{
        case .denied:
            //alert
            permitionDenided.toggle()
        case .notDetermined: break
            //requesting
            
        case .authorizedWhenInUse:
            manager.requestLocation()
            
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        //error
        print("MapViewModel")
        print(error.localizedDescription)
    }
    //Getting user region..
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]){
        guard let location = location.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        
        //Updating Map
        self.mapView.setRegion(self.region, animated: true)
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    
}
