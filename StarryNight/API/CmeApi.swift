//
//  CmeApi.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import Foundation

class CmeAPICaller {
    static let shared = CmeAPICaller()
    private let apiKey = "Xh7duhMXbKtTMDVV8vicbLBVCELWKZfsY0vCstGr"
    
    private init() {}
    
    func fetchCMEData(startDate: String, endDate: String, completion: @escaping (Result<[WelcomeElement], Error>) -> Void) {
        let urlString = "https://api.nasa.gov/DONKI/CME?startDate=\(startDate)&endDate=\(endDate)&api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let cmeData = try JSONDecoder().decode([WelcomeElement].self, from: data)
                completion(.success(cmeData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
