//
//  MenuView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct MenuView: View {
    @State private var popApod: Bool = false
    @State private var popNeow: Bool = false
    
    var body: some View {
        ZStack {
            StarryNightBackground()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Text("Discover")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Section {
                    VStack(spacing: 0) {
                        Image("apodPic")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Astronomy Picture of the Day")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("Explore the cosmos through daily images")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                popApod = true
                            }) {
                                Image(systemName: "arrow.right.square")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            .popover(isPresented: $popApod) {
                                NASAView()
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                    }
                    .cornerRadius(16)
                    .frame(height: 300)
                }
                .padding(.horizontal)
                
                Section {
                    VStack(spacing: 0) {
                        Image("neowPic")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Near Earth Object")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("Track asteroids approaching Earth")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                popNeow = true
                            }) {
                                Image(systemName: "arrow.right.square")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            .popover(isPresented: $popNeow) {
                                NeowInputView()
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                    }
                    .cornerRadius(16)
                    .frame(height: 300)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical, 60)
        }
    }
}

struct StarryNightBackground: View {
    let starCount = 100
    let starSize: CGFloat = 2.5
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
            
            ForEach(0..<starCount, id: \.self) { _ in
                Circle()
                    .fill(Color.white)
                    .frame(width: starSize, height: starSize)
                    .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    .opacity(Double.random(in: 0.5...1.0))
            }
        }
    }
}

#Preview {
    MenuView()
}
