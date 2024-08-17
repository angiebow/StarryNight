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
    @State private var errorMessage: IdentifiableError?
    @State private var navigateToAsteroidsList: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Date Range")) {
                        TextField("Start Date (YYYY-MM-DD)", text: $startDate)
                            .keyboardType(.numbersAndPunctuation)

                        TextField("End Date (YYYY-MM-DD)", text: $endDate)
                            .keyboardType(.numbersAndPunctuation)

                        Button(action: {
                            fetchAsteroids()
                        }) {
                            Text("Fetch Asteroids")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }

                NavigationLink(
                    destination: AsteroidsListView(asteroids: asteroids),
                    isActive: $navigateToAsteroidsList
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("NEOW Date Input")
            .alert(item: $errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func fetchAsteroids() {
        APICaller.shared.fetchAsteroids(startDate: startDate, endDate: endDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let welcome):
                    self.asteroids = welcome.nearEarthObjects.values.flatMap { $0 }
                    self.navigateToAsteroidsList = true
                case .failure(let error):
                    self.errorMessage = IdentifiableError(message: error.localizedDescription)
                    self.navigateToAsteroidsList = false
                }
            }
        }
    }
}

#Preview {
    NeowInputView()
}
