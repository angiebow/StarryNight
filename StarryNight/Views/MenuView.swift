//
//  MenuView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct MenuView: View {
    @State private var popApod: PopoverModel?
    @State private var popNeow: PopoverModel?
    @State private var popCme: PopoverModel?
    
    var body: some View {
        VStack{
            
            Section(){
                HStack{
                    Text("Astronomy Picture of the Day")
                    Spacer()
                    Button(action:{
                        popApod = PopoverModel(message: "Okay")
                    }) {
                        Image(systemName: "arrow.right.square")
                            .font(.system(size: 30))
                    }
                    .popover(item: $popApod) {_ in
                        NASAView()
                    }
                }
                .padding()
                .border(Color.black, width: 1)
            }
            .padding()
            
            Section(){
                HStack{
                    Text("Near Earth Object")
                    Spacer()
                    Button(action:{
                        popNeow = PopoverModel(message: "Okay")
                    }) {
                        Image(systemName: "arrow.right.square")
                            .font(.system(size: 30))
                    }
                    .popover(item: $popNeow) {_ in
                        NeowInputView()
                    }
                }
                .padding()
                .border(Color.black, width: 1)
            }
            .padding()
            
            Section(){
                HStack{
                    Text("Coronal Mass Ejection")
                    Spacer()
                    Button(action:{
                        popCme = PopoverModel(message: "Okay")
                    }) {
                        Image(systemName: "arrow.right.square")
                            .font(.system(size: 30))
                    }
                    .popover(item: $popCme) {_ in
                        CMEView()
                    }
                }
                .padding()
                .border(Color.black, width: 1)
            }
            .padding()

            
            Spacer()
        }
    }
}

#Preview {
    MenuView()
}
