//
//  CheckBoxView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import SwiftUI

struct CheckBoxView: View {
    var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
    }
}
