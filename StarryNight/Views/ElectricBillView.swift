//
//  ElectricBillView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 13/05/24.
//

import SwiftUI

struct ElectricBillView: View {
    @State private var electric: Double = 0
    @AppStorage("electricBill") var electricstor = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Enter electric bill", value: $electric, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: electric) { electricBill in
                                self.electricstor = electricBill
                            }
                            .onAppear {
                                self.electric = electricstor
                            }
                        Text("$")
                    }
                    HStack {
                        DatePicker("Date", selection: .constant(Date()), displayedComponents: .date)
                    }
                    HStack {
                        DatePicker("Time", selection: .constant(Date()), displayedComponents: .hourAndMinute)
                    }
                }
            }
            .navigationTitle("Electric Bill")
        }
        .toolbar{
            
        }
    }
}

#Preview {
    ElectricBillView()
}
