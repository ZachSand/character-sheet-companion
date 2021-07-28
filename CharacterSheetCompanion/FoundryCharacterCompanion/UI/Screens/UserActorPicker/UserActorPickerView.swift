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
        if let users = userActorPickerVM.foundryUsers {
            selectedUser = users[0]
        }
        if let userActors = userActorPickerVM.foundryUserActors {
            selectedActor = userActors[0]
        }
    }
    
    var body: some View {
        VStack {
            if let worldData = userActorPickerVM.worldData {
                VStack{
                    Text(worldData.title).font(.title)
                    Text("World Version: " + worldData.version).font(.footnote)
                    Text(worldData.description).font(.footnote)
                }
            }
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    if let users = userActorPickerVM.foundryUsers {
                        HStack{
                            Text("User").bold()
                            Picker(selection: $selectedUser, label: Text("Select Foundry User")) {
                                ForEach(users) {user in
                                    Text(user.userName).tag(user as UserModel?)
                                }
                            }
                            .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                            .clipped()
                        }
                    } else {
                        Text("No Users Found")
                    }
                    
                    if let userActors = userActorPickerVM.foundryUserActors {
                        HStack {
                            Text("Actor").bold()
                            Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                                ForEach(userActors) {userActor in
                                    Text(userActor.name).tag(userActor as UserActorModel?)
                                }
                            }
                            .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                            .clipped()
                        }
                    }
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
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

