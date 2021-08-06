//
//  ItemAttackButtonStyle.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct ItemAttackButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
        Image(systemName: "flame")
            .resizable()
            .frame(width: 20, height: 20, alignment: .leading)
        configuration.label.foregroundColor(.black)
    }
    .padding(.all, 10)
    .shadow(color: .white, radius: 10, x: -10, y: -10)
    .shadow(color: Color(red: 164/255, green: 174/255, blue: 192/255).opacity(0.4), radius: 10, x: 10, y: 10)
    .background(Color.green.cornerRadius(10))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
