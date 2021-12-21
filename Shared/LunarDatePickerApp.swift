//
//  LunarDatePickerApp.swift
//  Shared
//
//  Created by CHEN GUAN-JHEN on 2021/12/21.
//

import SwiftUI

@main
struct LunarDatePickerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "zh-CN"))
        }
    }
}
