//
//  AsteroidView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct AsteroidsListView: View {
    let asteroids: [NearEarthObject]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            StarryNightBackground()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                if asteroids.isEmpty {
                    Text("No Asteroids Found")
                        .foregroundColor(.white)
                        .font(.headline)
                } else {
                    List(asteroids, id: \.id) { asteroid in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(asteroid.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                if let closeApproach = asteroid.closeApproachData.first {
                                    Text("Close Approach Date:")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text(closeApproach.closeApproachDate)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    
                                    Text("Miss Distance: \(closeApproach.missDistance.kilometers) km")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.black.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        .padding(.vertical, 5)
                    }
                    .listRowBackground(Color.clear)
                    .scrollContentBackground(.hidden)
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    AsteroidsListView(asteroids: [])
}
