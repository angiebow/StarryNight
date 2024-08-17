//
//  GasBillView.swift
//  carbonPrint
//
//  Created by Pelangi Masita Wati on 13/05/24.
//

import SwiftUI

struct GasBillView: View {
    @State private var gas: Double = 0
    @AppStorage("gasBill") var gasstor = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Enter gas bill", value: $gas, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .onChange(of: gas) { gasBill in
                                self.gasstor = gasBill
                            }
                            .onAppear {
                                self.gas = gasstor
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
            .navigationTitle("Gas Bill")
        }
        .toolbar{
            
        }
    }
}

#Preview {
    GasBillView()
}
