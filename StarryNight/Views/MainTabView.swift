//
//  ContentView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 29/04/24.
//

import SwiftUI
import SwiftData
import Charts

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                FootprintView()
            }
            .tabItem {
                Image(systemName: "carbon.dioxide.cloud")
                Text("My CO2")
            }
            
            NavigationView {
                CommunityView()
            }
            .tabItem {
                Image(systemName: "globe.asia.australia")
                Text("Community")
            }
        }
        .accentColor(.blue)
    }
}

#Preview {
    MainTabView()
}
