//
//  ApiCall.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 05/05/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var news: NewsApi?
    @Published var url = "https://api.nasa.gov/planetary/apod?api_key=Xh7duhMXbKtTMDVV8vicbLBVCELWKZfsY0vCstGr"

    func fetchData() {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let news = try JSONDecoder().decode(NewsApi.self, from: data)
                DispatchQueue.main.async {
                    self?.news = news
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
