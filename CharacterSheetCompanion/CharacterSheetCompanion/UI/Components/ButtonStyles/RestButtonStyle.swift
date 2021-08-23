//
//  RestButtonStyle.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/23/21.
//

import SwiftUI

struct RestButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "bed.double")
                .resizable()
                .frame(width: 15, height: 15, alignment: .leading)
            configuration.label
        }
        .padding(.all, 10)
        .shadow(color: .white, radius: 10, x: -10, y: -10)
        .shadow(color: Color(red: 164 / 255, green: 174 / 255, blue: 192 / 255).opacity(0.4), radius: 10, x: 10, y: 10)
        .background(Color.green.cornerRadius(10))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
