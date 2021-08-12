//
//  ChatView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var chatVM: ChatViewModel
    @ObservedObject private var keyboard = KeyboardResponder()

    @State var typingMessage: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(chatVM.chatMessages) { msg in
                    HStack(alignment: .bottom, spacing: 15) {
                        if !msg.isCurrentUser {
                            Spacer()
                        }
                        ContentMessageView(header: VStack {
                            Text(msg.speaker).font(.footnote)
                            if let flavor = msg.chatFlavor {
                                Text(flavor).font(.subheadline)
                            }
                            if let usersInWhisper = msg.whisperUsers {
                                Text("Whisper to: " + usersInWhisper.joined(separator: ","))
                                    .font(.system(size: 10))
                                    .italic()
                            }
                        },
                        footer: Text(chatVM.getDateForTime(epochTime: msg.timestamp))
                            .font(.system(size: 10)),
                        contentMessage: msg.content,
                        isCurrentUser: msg.isCurrentUser)
                    }.padding()
                }
            }
            HStack {
                TextField("Message...", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading : .bottom)
    }

    func sendMessage() {
        chatVM.sendMessage(message: typingMessage)
        typingMessage = ""
    }
}

#if DEBUG
    struct ChatViewPreviews: PreviewProvider {
        static var previews: some View {
            ChatView(chatVM: ChatViewModel(chatMessages: ChatMessageModel.mockedData))
        }
    }
#endif
