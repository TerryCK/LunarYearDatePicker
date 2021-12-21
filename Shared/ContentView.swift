//
//  ContentView.swift
//  Shared
//
//  Created by CHEN GUAN-JHEN on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            LunarDatePicker($date)
                .pickerStyle(MenuPickerStyle())
            
            DatePicker("國曆出生",
                       selection: $date,
                       displayedComponents: [.date])
                
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
