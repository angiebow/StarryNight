//
//  NavigationSplitViewFoot.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI
import Charts
import SwiftData

struct NavigationSplitViewFoot: View {
    @State private var popGas: PopoverModel?
    @State private var popElectric: PopoverModel?
    @State private var popFlights: PopoverModel?
    @State private var popRecycle: PopoverModel?
    
    var message: String
    
    @Environment(\.modelContext) private var context
    private var totalStor: Double = 0
    
    internal init(message: String, totalStor: Double, footprint: Double) {
        self.message = message
        self.totalStor = totalStor
        self.footprint = footprint
    }
    
    var footprint: Double
    
    @Query private var items: [DataItem]
    
    @State private var gasBill: Double = 0
    @State private var electricBill: Double = 0
    @State private var flights: Double = 0
    @State private var recycle: Double = 0
    @State private var carTravel: Double = 0
    @State private var isCalculating: Bool = false
    @State private var popover: PopoverModel?
    
    var data: [ToyShape] = [
        .init(type: "March", count: 2250),
        .init(type: "April", count: 2000),
        .init(type: "May", count: 2000)
    ]
    
    var body: some View {
        Form {
            Section {
                Button("Carbon Footprint Calculator") {
                    popover = PopoverModel(message: "Custom Message")
                }
                .font(.headline)
                
                .popover(item: $popover) {_ in
                    calcView()
                }
            }
            
            Section(header: Text("Calculation History")) {
                HStack{
                    Text("Carbon Footprint (lbs)")
                        .font(.headline)
                        .padding(.vertical, 10)
                    Spacer()
                    Text("Date")
                        .font(.headline)
                        .padding(.vertical, 10)
                }
                
                List {
                    ForEach (items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(formatDate(item.date))
                        }
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            deleteItem(items[index])
                        }
                    }
                }
            }
            
            Section(){
                VStack{
                    HStack {
                        Image(systemName: "fuelpump")
                            .font(.system(size: 60))
                        Text("Gas Bill")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                            popGas = PopoverModel(message: "Gas Bill")
                        }) {
                            Image(systemName: "plus.square")
                                .font(.system(size: 30))
                        }
                        .popover(item: $popGas)  {_ in
                            GasBillView()
                        }
                    }
                    .padding(.vertical)
                    Chart {
                        BarMark(
                            x: .value("Shape Type", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                    }
                    .padding(.bottom)
                }
            }
            
            Section(){
                VStack{
                    HStack{
                        Image(systemName: "bolt")
                            .font(.system(size: 60))
                        Text("Electric Bill")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                            popElectric = PopoverModel(message: "Electric Bill")
                        }) {
                            Image(systemName: "plus.square")
                                .font(.system(size: 30))
                        }
                        .popover(item: $popElectric)  {_ in
                            ElectricBillView()
                        }
                    }
                    .padding(.vertical)
                    Chart {
                        BarMark(
                            x: .value("Shape Type", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                    }
                    .padding(.bottom)
                }
            }
            
            Section(){
                VStack{
                    HStack{
                        Image(systemName: "airplane.departure")
                            .font(.system(size: 60))
                        Text("Flights")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                            popElectric = PopoverModel(message: "Electric Bill")
                        }) {
                            Image(systemName: "plus.square")
                                .font(.system(size: 30))
                        }
                        .popover(item: $popElectric)  {_ in
                            ElectricBillView()
                        }
                    }
                    .padding(.vertical)
                    Chart {
                        BarMark(
                            x: .value("Shape Type", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                    }
                    .padding(.bottom)
                }
            }
            
            Section(){
                VStack{
                    HStack{
                        Image(systemName: "arrow.3.trianglepath")
                            .font(.system(size: 60))
                        Text("Recycle")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                            popRecycle = PopoverModel(message: "Recycle")
                        }) {
                            Image(systemName: "plus.square")
                                .font(.system(size: 30))
                        }
                        .popover(item: $popRecycle) { detail in
                            Text("\(detail.message)")
                                .padding()
                        }
                    }
                    .padding(.vertical)
                    Chart {
                        BarMark(
                            x: .value("Shape Type", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                    }
                    .padding(.bottom)
                }
            }
            
            Section(){
                VStack {
                    HStack{
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 60))
                        Text("My Footprint")
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                    .padding(.vertical)
                    Chart {
                        BarMark(
                            x: .value("Shape Type", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        BarMark(
                            x: .value("Shape Type", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    
    func saveFootprint(_ footprint: Int) {
        UserDefaults.standard.set(footprint, forKey: "SavedFootprint")
    }
    
    func deleteItem(_ item: DataItem){
        context.delete(item)
    }
}
