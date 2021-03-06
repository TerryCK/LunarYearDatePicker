//
//  ContentView.swift
//  Shared
//
//  Created by CHEN GUAN-JHEN on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var lunerDateViewModel = LunarDatePickerViewModel(date: Date())

    var body: some View {
        VStack(alignment: .leading) {
            LunarDatePicker(viewModel: $lunerDateViewModel)
                .pickerStyle(MenuPickerStyle())

            DatePicker("ċĉċşç",
                       selection: $lunerDateViewModel.date,
                       displayedComponents: [.date])


        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
