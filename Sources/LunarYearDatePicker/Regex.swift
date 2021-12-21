//
//  Regex.swift
//  LunarYearDatePicker
//
//  Created by CHEN GUAN-JHEN on 2021/12/21.
//

import Foundation
struct Regex {
    let pattern: String
}

extension String {
    var regex: Regex { .init(pattern: self) }
    func captureGroups(with regexP: Regex,
                       options: NSRegularExpression.Options = [.caseInsensitive, .anchorsMatchLines])  ->  [String]  {
        
        guard let regex = try? NSRegularExpression(pattern: regexP.pattern, options: options) else { return [] }
        let matches = regex.matches(in: self, range: NSRange(startIndex..., in: self))
        var result = [String]()
        for match in matches {
            var groups: [String] = []
            for rangeIndex in 1 ..< match.numberOfRanges {
                groups.append((self as NSString).substring(with: match.range(at: rangeIndex)))
            }
            if !groups.isEmpty {
                result.append(contentsOf: groups)
            }
        }
        return result
    }
}
