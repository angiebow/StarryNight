//
//  ResultView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct ResultView: View {
    
    @Environment(\.modelContext) private var context
    
    var footprint: Double
    @State private var totalStor: Double
    
    init(footprint: Double) {
        self.footprint = footprint
        self._totalStor = State(initialValue: UserDefaults.standard.double(forKey: "totalFootprint"))
        self.messagestr = ""
    }
    
    init(messagestr: String, totalStor: Double, footprint: Double) {
        self.messagestr = messagestr
        self.totalStor = totalStor
        self.footprint = footprint
    }
    
    @State private var showSecondView = false
    
    var message: Double {
        return footprint
    }
    
    var messagestr: String
    
    var scaledFootprint: Double {
        // Ensure the footprint is within the range
        let scaledValue = min(max(footprint, 0), 22000)
        return scaledValue
    }
    
    var body: some View {
        VStack {
            Text("Your Carbon Footprint is")
                .font(.headline)
                .padding(.bottom, 10)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 20))
                Circle()
                    .trim(from: 0.0, to: CGFloat(scaledFootprint / 22000))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(footprint)) lbs")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: 200, height: 200)
            .padding()
            
            if footprint < 6000 {
                Text("You have a very low carbon footprint. Well done!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            } else if footprint >= 6000 && footprint < 16000 {
                Text("You have a low carbon footprint. Keep up the good work!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            } else if footprint >= 16000 && footprint <= 22000 {
                Text("You have a medium carbon footprint.")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            } else {
                Text("Your carbon footprint is high. Consider taking steps to reduce it.")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
            
                if footprint < 6000 {
                    ForEach(0..<veryLowSuggestions.count, id: \.self) { index in
                        Text(veryLowSuggestions[index])
                    }
                } else if footprint >= 6000 && footprint < 16000 {
                    ForEach(0..<lowSuggestions.count, id: \.self) { index in
                        Text(lowSuggestions[index])
                    }
                } else if footprint >= 16000 && footprint <= 22000 {
                    ForEach(0..<mediumSuggestions.count, id: \.self) { index in
                        Text(mediumSuggestions[index])
                    }
                } else {
                    ForEach(0..<highSuggestions.count, id: \.self) { index in
                        Text(highSuggestions[index])
                    }
                }
            
            
        }
        .padding()
        .navigationTitle("Result")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    addItem(footprint: Int(footprint))
                }
                .background(
                    NavigationLink(
                        destination: NavigationSplitViewFoot(message: "\(self.message)", totalStor: self.totalStor, footprint: self.footprint)) {
                            EmptyView()
                        }
                        .hidden()
                )
            }
        }
    }
    
    func addItem(footprint: Int) {
        let item = DataItem(name: "\(footprint)")
        context.insert(item)
    }
    
    let veryLowSuggestions = [
        "- Opt for eco-friendly transportation options such as walking, biking, or using public transport.",
        "- Continue practicing waste reduction and recycling habits.",
        "- Explore renewable energy options for your home."
    ]
    
    let lowSuggestions = [
        "- Look for additional ways to reduce energy usage, such as improving insulation or installing a smart thermostat.",
        "- Evaluate transportation habits and consider carpooling or car-sharing options.",
        "- Encourage others to adopt sustainable practices by sharing your experiences and tips.",
        "- Invest in carbon offset programs to compensate for unavoidable emissions."
    ]
    
    let mediumSuggestions = [
        "- Assess energy usage patterns and make significant changes to reduce consumption.",
        "- Explore alternative transportation methods like electric vehicles or carpooling.",
        "- Minimize waste generation and increase recycling efforts.",
        "- Support environmental initiatives and advocate for sustainable practices in your community."
    ]
    
    let highSuggestions = [
        "- Consider significant changes in lifestyle to reduce energy consumption.",
        "- Opt for more sustainable transportation methods such as public transit or cycling.",
        "- Minimize air travel and choose alternative modes of transportation for long distances.",
        "- Reduce consumption of animal products and adopt a plant-based diet to lower emissions associated with food production.",
        "- Invest in renewable energy sources for your home and support policies that promote renewable energy adoption."
    ]
}
