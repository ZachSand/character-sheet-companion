//
//  ItemDamageButtonStyle.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct ItemDamageButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
        Image(systemName: "heart.slash.circle")
            .resizable()
            .frame(width: 15, height: 15, alignment: .leading)
        configuration.label.foregroundColor(.black)
    }
    .padding(.all, 10)
    .shadow(color: .white, radius: 10, x: -10, y: -10)
    .shadow(color: Color(red: 164/255, green: 174/255, blue: 192/255).opacity(0.4), radius: 10, x: 10, y: 10)
    .background(Color.red.cornerRadius(10))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
