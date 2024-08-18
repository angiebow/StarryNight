//
//  CmeInput.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct CMEView: View {
    @State private var cmeData: [WelcomeElement] = []
    @State private var errorMessage: IdentifiableErrorCme?
    
    @State private var startDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -30, to: Date())!)
    }()
    
    @State private var endDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }()
    
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
                            fetchCMEData()
                        }) {
                            Text("Fetch CME Data")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                List(cmeData, id: \.activityID) { cme in
                    VStack(alignment: .leading) {
                        Text(cme.activityID)
                            .font(.headline)
                        Text("Start Time: \(cme.startTime)")
                        Text("Source Location: \(cme.sourceLocation)")
                        Text("Instruments: \(cme.instruments.map { $0.displayName }.joined(separator: ", "))")
                    }
                }
            }
            .navigationTitle("CME Data")
            .alert(item: $errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func fetchCMEData() {
        CmeAPICaller.shared.fetchCMEData(startDate: startDate, endDate: endDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.cmeData = data
                case .failure(let error):
                    self.errorMessage = IdentifiableErrorCme(message: error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    CMEView()
}
