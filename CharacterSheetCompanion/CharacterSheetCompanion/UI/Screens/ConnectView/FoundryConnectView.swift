//
//  FoundryVTTConnectView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/6/21.
//

import SwiftUI

struct FoundryConnectView: View {
    @ObservedObject var foundryConnectVM: FoundryConnectViewModel

    init() {
        foundryConnectVM = FoundryConnectViewModel()
    }

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.bottom, 50)

            TextField(
                "Character Sheet Companion ID", text: $foundryConnectVM.characterCompanionId
            )
            .padding()
            .background(Color.themeTextField)
            .cornerRadius(20.0)
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding([.leading, .trailing], 27.5)
            .disableAutocorrection(true)
            .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
            .font(Font.system(size: 15, design: .default))

            Button {
                foundryConnectVM.connect()
                if foundryConnectVM.connectSuccess {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: WorldUserActorView())
                        window.makeKeyAndVisible()
                    }
                }
            } label: {
                Text("Connect")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 30)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .opacity(foundryConnectVM.isIdValid() ? 1 : 0.6)
            }.disabled(!foundryConnectVM.isIdValid())

            Spacer()

            Button {} label: {
                Text("Need Help?").font(.callout)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

extension Color {
    static var themeTextField: Color {
        Color(red: 220.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, opacity: 1.0)
    }
}
