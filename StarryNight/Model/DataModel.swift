//
//  DataModel.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 05/05/24.
//

import Foundation

struct NewsApi: Codable {
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String
    let title: String
    let url: String
}

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct PopoverModel: Identifiable {
    var id: String { message }
    let message: String
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

func formatInteger(_ number: Double) -> String {
    let integerPart = Int(number.rounded())
    return "\(integerPart)"
}
