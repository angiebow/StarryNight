//
//  calcView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 11/05/24.
//

import SwiftUI

struct calcView: View {
    @State private var showResult = false
    
    @State private var gasBill: Double = 0
    @AppStorage("gasBill") var gas = 0.0
    
    @Environment(\.modelContext) private var context
    
    @State private var totalFootprint: Double = 0
    @AppStorage("totalFootprint") var totalStor = 0.0
    
    @State private var electricBill: Double = 0
    @AppStorage("electricBill") var electric = 0.0
    
    @State private var oilBill: Double = 0
    @AppStorage("oilBill") var oil = 0.0
    
    @State private var flightsLess: Double = 0
    @AppStorage("flightsLess") var less = 0.0
    
    @State private var flightsMore: Double = 0
    @AppStorage("flightsMore") var more = 0.0
    
    @State private var carTravel: Double = 0
    @AppStorage("carTravel") var car = 0.0
    
    @State private var recycleNews: Bool = false
    @AppStorage("recycleNews") var news = 0.0
    
    @State private var recycleTin: Bool = false
    
    @State private var text = ""
    @AppStorage("NUMBER_KEY") var savedText = ""
    
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monthly Gas Bill")) {
                    HStack {
                        TextField("Enter gas bill", value: $gasBill, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: gasBill) { gasBill in
                                self.gas = gasBill
                            }
                            .onAppear {
                                self.gasBill = gas
                            }
                        Text("$")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Monthly Electric Bill")) {
                    HStack {
                        TextField("Enter electric bill", value: $electricBill, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: electricBill) { electricBill in
                                self.electric = electricBill
                            }
                            .onAppear {
                                self.electricBill = electric
                            }
                        Text("$")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Monthly Oil Bill")) {
                    HStack {
                        TextField("Enter oil bill", value: $oilBill, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: oilBill) { oilBill in
                                self.oil = oilBill
                            }
                            .onAppear {
                                self.oilBill = oil
                            }
                        Text("$")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Annual Flights <4 Hours")) {
                    TextField("Enter flights", value: $flightsLess, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .onChange(of: flightsLess) { flightLess in
                            self.less = flightLess
                        }
                        .onAppear {
                            self.flightsLess = less
                        }
                }
                
                Section(header: Text("Annual Flights >4 Hours")) {
                    TextField("Enter flights", value: $flightsMore, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .onChange(of: flightsMore) { flightsMore in
                            self.more = flightsMore
                        }
                        .onAppear {
                            self.flightsMore = more
                        }
                }
                
                Section(header: Text("Car Travel")) {
                    HStack {
                        TextField("Enter car travel", value: $carTravel, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: carTravel) { carTravel in
                                self.car = carTravel
                            }
                            .onAppear {
                                self.carTravel = car
                            }
                        
                        Text("mile")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Recycle")) {
                    Toggle("Newspaper", isOn: $recycleNews)
                }
                
                Section(header: Text("Recycle")) {
                    Toggle("Aluminum & Tin", isOn: $recycleTin)
                }
            }
            .navigationTitle("Calculator")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showAlert = true
                        presentationMode.wrappedValue.dismiss()
                    }
//                    .alert(isPresented: $showAlert) {
//                        Alert(title: Text("Are you sure?"), message: Text("You will lose the progress"), primaryButton: .default(Text("Yes")) {
//                            presentationMode.wrappedValue.dismiss()
//                        }, secondaryButton: .cancel())
//                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Result") {
                        calculateFootprint()
                        showResult = true
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: ResultView(footprint: totalFootprint),
                    isActive: $showResult,
                    label: { EmptyView() }
                )
                .onAppear {
                    savedText = "\(totalFootprint)"
                }
            )
        }
        
    }
    
    private func calculateFootprint() {
        let electricFootprint = electricBill * 105
        let oilBillFootprint = oilBill * 113
        let flightFootprintLess = flightsLess * 1100
        let flightFootprintMore = flightsMore * 4400
        let carFootprint = carTravel * 0.79
        let recycleFootprintN = recycleNews ? 0 : 184
        let recycleFootprintT = recycleTin ? 0 : 166
        
        totalFootprint = electricFootprint + oilBillFootprint + flightFootprintLess + flightFootprintMore + carFootprint + Double(recycleFootprintN) + Double(recycleFootprintT)
    }
}

#Preview {
    calcView()
}
