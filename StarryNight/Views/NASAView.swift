//
//  NASAView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct NASAView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let news = viewModel.news {
                    AsyncImage(url: URL(string: news.url)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxHeight: 300)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(news.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("Date: \(news.date)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(news.explanation)
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    NASAView()
}
