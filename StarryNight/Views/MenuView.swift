//
//  MenuView.swift
//  StarryNight
//
//  Created by Pelangi Masita Wati on 17/08/24.
//

import SwiftUI

struct MenuView: View {
    @State private var popApod: PopoverModel?
    
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
            
            Spacer()
        }
    }
}

#Preview {
    MenuView()
}
