//
//  ContentMessageView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ContentMessageView<Header: View, Footer: View>: View {
    let header: Header
    let footer: Footer
    var contentMessage: String
    var isCurrentUser: Bool

    var body: some View {
        VStack {
            header.fixedSize()
            Text(contentMessage)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.top], 5)
            HStack {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .leading)
                footer.fixedSize()
            }
        }
        .padding(10)
        .foregroundColor(isCurrentUser ? Color.white : Color.black)
        .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)))
        .cornerRadius(10)
        .scaledToFit()
    }
}
