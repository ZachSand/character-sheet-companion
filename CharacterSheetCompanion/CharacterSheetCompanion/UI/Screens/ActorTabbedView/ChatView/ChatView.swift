//
//  ChatView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/4/21.
//

import SwiftUI

struct ChatView: View {
    @State var typingMessage: String = ""
    @ObservedObject var chatVM: ChatViewModel
    @ObservedObject private var keyboard = KeyboardResponder()

    init(user: UserModel, foundryActor: ActorModel) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        chatVM = ChatViewModel(user: user, foundryActor: foundryActor)
    }

    var body: some View {
        VStack {
            List {
                if let messages = chatVM.chatMessages {
                    ForEach(messages) { msg in
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
