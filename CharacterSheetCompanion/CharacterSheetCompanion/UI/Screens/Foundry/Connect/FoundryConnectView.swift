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
            FoundryHeading()
            FoundrySubheading()
            FoundryImage()
            FoundryCompanionIdTextField()
            FoundryConnectButton()
            Spacer()
            FoundryHelpText()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
    
    fileprivate func FoundryHeading() -> some View {
        return Text("Character Sheet Companion")
            .font(.title)
            .foregroundColor(Color.black)
            .padding([.top, .bottom], 10)
            .shadow(radius: 10.0, x: 20, y: 10)
    }
    
    fileprivate func FoundrySubheading() -> some View {
        return Text("Foundry VTT")
            .font(.title2)
            .foregroundColor(Color.black)
            .shadow(radius: 10.0, x: 20, y: 10)
    }
    
    fileprivate func FoundryImage() -> some View {
        return Image("foundryvtt-logo")
            .resizable()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .shadow(radius: 10)
            .padding(.bottom, 50)
    }
    
    fileprivate func FoundryCompanionIdTextField() -> some View {
        return TextField(
            "Character Sheet Companion ID", text: $foundryConnectionVM.id)
            .padding()
            //.background(Color.themeTextField)
            .cornerRadius(20.0)
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding([.leading, .trailing], 27.5)
            .disableAutocorrection(true)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .font(Font.system(size: 15, design: .default))
    }
    
    fileprivate func FoundryConnectButton() -> some View {
        return Button(action: {
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
    }
    
    fileprivate func FoundryHelpText() -> HStack<Button<Text>> {
        return HStack(spacing: 0) {
            Button(action: {}) {
                Text("Need Help?")
                    .foregroundColor(.black)
            }
        }
    }
}

#if DEBUG
struct FoundryConnectView_Previews: PreviewProvider {
    @State static var isConnected = false

    static var previews: some View {
        FoundryConnectView(connectSuccess: $isConnected)
    }
}
#endif
