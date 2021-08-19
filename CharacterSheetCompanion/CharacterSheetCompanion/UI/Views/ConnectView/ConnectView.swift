//
//  FoundryVTTConnectView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/6/21.
//

import SwiftUI

struct ConnectView: View {
    @ObservedObject var connectVM: ConnectViewModel

    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.bottom, 50)

            Spacer()
            TextField(
                "Character Sheet Companion ID", text: $connectVM.characterCompanionId
            )
            .multilineTextAlignment(TextAlignment.center)
            .padding()
            .background(Color.themeTextField)
            .cornerRadius(20.0)
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding([.leading, .trailing], 27.5)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .font(Font.system(size: 15, design: .default))

            NavigationLink(
                destination: LazyView(WorldUserActorView()),
                isActive: $connectVM.connectSuccess,
                label: {
                    Button {
                        connectVM.connect()
                    } label: {
                        Text("Connect")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 30)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .opacity(connectVM.isIdValid() ? 1 : 0.6)
                    }.disabled(!connectVM.isIdValid())
                }
            )
            .disabled(!connectVM.isIdValid())

            Spacer()

            Button {} label: {
                Text("Need Help?")
                    .font(.callout)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(width: 150, height: 30)
                    .cornerRadius(30.0)
                    .background(Color(hue: 0.102, saturation: 0.949, brightness: 0.944))
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

#if DEBUG
    struct ConnectView_Previews: PreviewProvider {
        static var previews: some View {
            ConnectView(connectVM: ConnectViewModel())
        }
    }
#endif
