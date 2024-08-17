//
//  StarryNightApp.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI
import SwiftData

@main
struct carbonPrintApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
        .modelContainer(for: DataItem.self)
    }
}
