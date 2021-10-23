//
//  Home.swift
//  mapTest
//
//  Created by Temur on 22/10/2021.
//

import SwiftUI
import CoreLocation



struct Home: View {
    
    @State var locationManager = CLLocationManager()
    @StateObject var mapData = MapViewModel()
    @State  var cityName = ""
    
    //Location manager
    var body: some View {
        ZStack{
            // map
            MapView()
            // using it as enviroment object so that if can be used ints subViews
                .environmentObject(mapData)
            
            
            VStack{
                VStack{
                
                    HStack{
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $mapData.searchTxt)
                            .colorScheme(.light)
                        
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    //display results
                    if !mapData.places.isEmpty && mapData.searchTxt != ""{
                        ScrollView{
                            VStack(spacing: 15){
                                ForEach(mapData.places){place in
                                    Text(place.place.name ?? "")
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            mapData
                                                .selectRlace(place: place)
                                        }
                                    
                                }
                                Divider()
                            }
                        }
                        .background(Color.white)
                    }
                    
                    Text("Your location is in \(mapData.countryName)")
                    
                    
                }
                .padding()
                
                
                
                Spacer()
                
                HStack{
                
                    Spacer()
                    
                    VStack{
                        Button(action: mapData.focusLocation , label: {
                            Image(systemName: mapData.mapType == .standard ? "location" : "location.circle.fill")
                                .font(.title2)
                                .padding(10)
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                        Button(action: mapData.weatherSerch, label: {
                            Image(systemName: mapData.mapType == .standard ? "cloud.sun" : "cloud.sun.fill")
                                .font(.title2)
                                .padding(10)
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                        
                        Button(action: mapData.updateMapType, label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding(10)
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                    }
                    .padding()
                }
                
            }
        }
        .onAppear(perform: {
            //SetingManager delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permitionDenided, content: {
            Alert(title: Text("Permition Denied"), message: Text("PleaseEnable Permition in app settings"), dismissButton: .default(Text("Goto Setting"), action: {
                //Rediretion User to settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: {
            value in
            //searching places
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                if value == mapData.searchTxt{
                    //search
                    self.mapData.searchQuery()
                }
            }
            
        })
    }}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

