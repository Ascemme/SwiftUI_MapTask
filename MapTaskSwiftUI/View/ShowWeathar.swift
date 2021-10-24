//
//  ShowWeathar.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 23/10/2021.
//

import SwiftUI

struct ShowWeathar: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var mapData = MapViewModel()
    @State var cityIs = Country()
    
    
    var body: some View{
        VStack{
            Text("Searching city \(cityIs.place)")
            Button("back"){
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    
}
