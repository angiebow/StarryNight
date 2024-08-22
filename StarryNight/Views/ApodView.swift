//
//  NASAView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct NASAView: View {
    @StateObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            StarryNightBackground()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
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
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let news = viewModel.news {
                            AsyncImage(url: URL(string: news.url)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                            } placeholder: {
                                VStack {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.3))
                                        .frame(maxHeight: 300)
                                        .cornerRadius(12)
                                        .overlay(
                                            VStack {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                                    .scaleEffect(1.5)
                                                Text("Loading Picture...")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            }
                                        )
                                }
                            }
                            .frame(maxHeight: 400)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(news.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("Date: \(news.date)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(news.explanation)
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
                        } else {
                            ProgressView()
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    NASAView()
}
