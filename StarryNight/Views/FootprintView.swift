//
//  FootprintView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct FootprintView: View {
    var body: some View {
        NavigationSplitViewFoot(message: "0", totalStor: 0, footprint: 0)
            .navigationTitle("My CO2")
    }
}

#Preview {
    FootprintView()
}
