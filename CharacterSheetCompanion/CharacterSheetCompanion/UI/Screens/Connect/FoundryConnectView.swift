//
//  FoundryVTTConnectView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/6/21.
//

import SwiftUI

struct FoundryConnectView : View {
    @ObservedObject var foundryConnectionVM = FoundryConnectViewModel()
    @Binding var connectSuccess: Bool
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding(.bottom, 50)
            
            TextField(
                "Character Sheet Companion ID", text: $foundryConnectionVM.id)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding([.leading, .trailing], 27.5)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .font(Font.system(size: 15, design: .default))
            
            Button(action: {
                FoundrySocketIOManager.sharedInstance.roomId = foundryConnectionVM.id
                FoundrySocketIOManager.sharedInstance.socketConnect { connectionStatus in
                    DispatchQueue.main.async {
                        connectSuccess = connectionStatus
                    }
                }
            }) {
                Text("Connect")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 30)
                    .background(Color.green)
                    .cornerRadius(15.0)
                    .opacity(foundryConnectionVM.isIdValid() ? 1 : 0.6)
            }.disabled(!foundryConnectionVM.isIdValid())
            
            Spacer()
            
            Button(action: {
                
            }) {
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
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
