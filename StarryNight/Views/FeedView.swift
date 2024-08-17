//
//  FeedView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct FeedView: View {
    @State private var posts: [String] = [
        "Just installed solar panels on my roof! ☀️ #RenewableEnergy",
        "Biked to work today instead of driving! 🚲 #ReduceCarbonFootprint",
        "Started composting food waste to reduce landfill! ♻️ #SustainableLiving",
        "Visited a local farmer's market and bought organic produce! 🥦 #SupportLocal",
        "Planted a tree in my backyard for a greener tomorrow! 🌳 #EcoFriendly"
    ]
    @State private var newPostText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(posts, id: \.self) { post in
                    Text(post)
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                }
            }
            
            HStack {
                TextField("Write a new post...", text: $newPostText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    posts.append(newPostText)
                    newPostText = ""
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
    
    private func addPost() {
        guard !newPostText.isEmpty else { return }
        posts.append(newPostText)
        newPostText = ""
    }
}


#Preview {
    FeedView()
}
