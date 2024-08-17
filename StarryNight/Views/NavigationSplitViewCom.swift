//
//  NavigationSplitViewCom.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct NavigationSplitViewCom: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Navigation")) {
                Text("News").tag(0)
                Text("Feeds").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if selectedTab == 0 {
                NASAView()
            } else {
                FeedView()
            }
        }
    }
}

#Preview {
    NavigationSplitViewCom()
}
