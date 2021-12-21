//
//  LunarDatePicker.swift
//  LunarDatePicker
//
//  Created by CHEN GUAN-JHEN on 2021/12/21.
//

import SwiftUI
import Combine


struct Day {
   let year, month, day: Int
}

extension Date {
   
    var day: Day {
        let year = Calendar(identifier: .republicOfChina)
        let locale = Locale(identifier: "zh-CN")
        
        let formatter = DateFormatter()
        formatter.calendar = year
        formatter.dateStyle = .full
        formatter.locale = locale
        let string = formatter.string(from: self)
        let dateInt = string.captureGroups(with: "(\\d*)[^年](\\d*)[^月](\\d*)[^日]".regex).compactMap(Int.init)
        return Day(year: dateInt[0],
                   month: dateInt[1] - 1,
                   day: dateInt[2] - 3)
    }
}


struct LunarDatePickerViewModel {
    var date: Date
    
    var day  : Int   { date.day.day   }
    var month: Int   { date.day.month }
    var year : Int   { date.day.year  }
    
    
    func convert(year: Int, month: Int, day: Int) -> Date {
        let chineseCalendar = Calendar(identifier: .chinese)
        //        let year = Calendar(identifier: .republicOfChina)
        let correctYear = 72
        let component = DateComponents(calendar: chineseCalendar,
                                       timeZone: .init(secondsFromGMT: 8),
                                       year: year - correctYear,
                                       month: month, day: day)
        return component.date ?? Date()
    }
    
    

    init(date: Date) {
        self.date = date
    }
    
    func convertString(year: Int, month: Int, day: Int) -> String {
        convertToSolar(from: convert(year: year, month: month, day: day))
    }
    
    func convertToSolar(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "zh-CN")
        return "國曆:" + formatter.string(from: date)
    }
    
    func converttaiwanLunarString(year: Int, month: Int, day: Int) -> String {
        taiwanLunarDateFullString(from: convert(year: year, month: month, day: day))
    }
    
    mutating func setDate(year: Int? = nil, month: Int? = nil, day: Int? = nil) {
        let dayStruct = date.day
        let year = year ?? dayStruct.year
        let month = month ?? dayStruct.month
        let day = day ?? dayStruct.day
        date = convert(year: year, month: month, day: day)
    }
    
    func taiwanLunarDateFullString(from date: Date) -> String {
        let chineseCalendar = Calendar(identifier: .chinese)
        let year = Calendar(identifier: .republicOfChina)
        let locale = Locale(identifier: "zh-CN")
        
        let formatter = DateFormatter()
        formatter.calendar = year
        formatter.dateStyle = .full
        formatter.locale = locale
        let yearString = formatter.string(from: date).captureGroups(with: "([^年]*)".regex).first ?? ""
        formatter.calendar = chineseCalendar
        let dateString = formatter.string(from: date).captureGroups(with: "年([^日星期]*)".regex).first ?? ""
        return yearString + dateString
    }
}

struct LunarDatePicker: View {

    @Binding var viewModel: LunarDatePickerViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("農曆")
                Picker("選擇一個年", selection: Binding(get: { viewModel.year },
                                                      set: { viewModel.setDate(year: $0)})
                ) {
                    ForEach(1...Date().day.year, id: \.self) { index in
                        Text("民國 " + String(index) + " 年")
                            .tag(index)
                    }
                }
                
                Picker("選擇一個月", selection: Binding(get: { viewModel.month },
                                                      set: { viewModel.setDate(month: $0)})
                ) {
                    ForEach(1...12, id: \.self) { index in
                        Text(String(index) + " 月")
                            .tag(index)
                    }
                }
                
                Picker("選擇一個日",  selection: Binding(get: { viewModel.day },
                                                       set: { viewModel.setDate(day: $0)})
                ) {
                    ForEach(1...31, id: \.self) { index in
                        Text(String(index) + " 日")
                            .tag(index)
                    }
                }
            }
        }
    }
}

struct LunarDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        LunarDatePicker(viewModel: .constant(.init(date: Date())))
    }
}
