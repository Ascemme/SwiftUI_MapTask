//
//  ContentView.swift
//  MapTaskSwiftUI
//
//  Created by Temur on 21/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    Image(systemName: "map")
                    Text("MAP")
                }
            HistoryView()
                .tabItem{
                    Image(systemName: "book")
                    Text("History")}
        }
        .background(Color.orange)
        .foregroundColor(Color.blue)
        
    }
    
}
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
