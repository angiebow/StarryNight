//
//  NeowView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct NeowInputView: View {
    @State private var startDate: String = "2024-08-01"
    @State private var endDate: String = "2024-08-07"
    @State private var asteroids: [NearEarthObject] = []
    @State private var errorMessage: IdentifiableErrorNeow?
    @State private var navigateToAsteroidsList: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
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
                    
                    Form {
                        Section(header: Text("Date Range")
                                    .foregroundColor(.white)) {
                            TextField("Start Date (YYYY-MM-DD)", text: $startDate)
                                .keyboardType(.numbersAndPunctuation)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(10)

                            TextField("End Date (YYYY-MM-DD)", text: $endDate)
                                .keyboardType(.numbersAndPunctuation)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(10)

                            Button(action: {
                                fetchAsteroids()
                            }) {
                                Text("Fetch Objects")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .background(Color.clear)
                    .scrollContentBackground(.hidden) 

                    NavigationLink(
                        destination: AsteroidsListView(asteroids: asteroids),
                        isActive: $navigateToAsteroidsList
                    ) {
                        EmptyView()
                    }
                }
                .padding()
                .alert(item: $errorMessage) { error in
                    Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    private func fetchAsteroids() {
        NeowAPICaller.shared.fetchAsteroids(startDate: startDate, endDate: endDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let welcome):
                    self.asteroids = welcome.nearEarthObjects.values.flatMap { $0 }
                    self.navigateToAsteroidsList = true
                case .failure(let error):
                    self.errorMessage = IdentifiableErrorNeow(message: error.localizedDescription)
                    self.navigateToAsteroidsList = false
                }
            }
        }
    }
}

#Preview {
    NeowInputView()
}
