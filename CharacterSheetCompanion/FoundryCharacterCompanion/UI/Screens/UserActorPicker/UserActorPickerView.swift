//
//  UserActorPickerViewModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import SwiftUI

struct UserActorPickerView: View {
    @ObservedObject var userActorPickerVM: UserActorPickerViewModel
    @State var selectedUser: UserModel?
    @State var selectedActor: UserActorModel?
    
    init() {
        self.userActorPickerVM = UserActorPickerViewModel()
    }
    
    var body: some View {
        VStack {
            if let worldData = userActorPickerVM.worldData {
                VStack{
                    Text("World: " + worldData.title).font(.title2)
                    Text("Version: " + worldData.version)
                    Text("World Description:" + worldData.description)
                }
            }
            
            if let users = userActorPickerVM.foundryUsers {
                VStack {
                    Picker(selection: $selectedUser, label: Text("Select Foundry User")) {
                        ForEach(users) {user in
                            Text(user.userName).tag(user as UserModel?)
                        }
                    }.scaledToFit()
                }
            } else {
                Text("No Users Found")
            }
            
            if let userActors = userActorPickerVM.foundryUserActors {
                VStack{
                    Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                        ForEach(userActors) {userActor in
                            Text(userActor.name).tag(userActor as UserActorModel?)
                        }
                    }.scaledToFit()
                }
            }
            
            Button(action: {
                if let window = UIApplication.shared.windows.first {
                    if let userActor = selectedActor {
                           window.rootViewController = UIHostingController(rootView: ActorTabbedView(userActor: userActor))
                           window.makeKeyAndVisible()
                       }
                }
            })
            {
                Text("Go to Character")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 30)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

