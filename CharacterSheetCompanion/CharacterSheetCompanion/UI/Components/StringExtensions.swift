//
//  StringExtensions.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/7/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }

    func truncate(_ length: Int, trailing: String = "…") -> String {
        (count > length) ? prefix(max(0, length - trailing.count)) + trailing : self
    }
}
