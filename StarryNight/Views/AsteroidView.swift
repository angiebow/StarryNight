//
//  AsteroidView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct AsteroidsListView: View {
    let asteroids: [NearEarthObject]

    var body: some View {
        List(asteroids, id: \.id) { asteroid in
            VStack(alignment: .leading) {
                Text(asteroid.name)
                    .font(.headline)
                if let closeApproach = asteroid.closeApproachData.first {
                    Text("Close Approach Date: \(closeApproach.closeApproachDate)")
                    Text("Miss Distance (km): \(closeApproach.missDistance.kilometers)")
                }
            }
        }
        .navigationTitle("Asteroids")
    }
}

#Preview {
    AsteroidsListView(asteroids: [])
}
