//
//  UserActorPickerViewModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import SwiftUI

struct WorldUserActorView: View {
    @ObservedObject var worldUserActorVM: WorldUserActorViewModel
    @State var selectedUser: UserModel?
    @State var selectedActor: UserActorModel?

    init() {
        worldUserActorVM = WorldUserActorViewModel()
        if let users = worldUserActorVM.foundryUsers {
            selectedUser = users[0]
        }
        if let userActors = worldUserActorVM.foundryUserActors {
            selectedActor = userActors[0]
        }
    }

    var body: some View {
        VStack {
            if let worldData = worldUserActorVM.worldData {
                VStack {
                    Text(worldData.title).font(.title)
                    Text("World Version: \(worldData.version)").font(.footnote)
                    Text("Foundry Version: \(worldData.coreVersion)").font(.footnote)
                    Text("Foundry System: \(worldData.system)").font(.footnote)
                }
            }

            Divider()

            GeometryReader { geometry in
                VStack(spacing: 5) {
                    if let users = worldUserActorVM.foundryUsers {
                        HStack {
                            Section(header: Text("User")) {
                                Picker(selection: $selectedUser, label: Text("Select Foundry User")) {
                                    ForEach(users) { user in
                                        Text(user.userName).tag(user as UserModel?)
                                    }
                                }
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                            }
                        }
                    } else {
                        Text("No Users Found")
                    }

                    if let userActors = worldUserActorVM.foundryUserActors {
                        HStack {
                            Section(header: Text("Actor")) {
                                Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                                    ForEach(userActors) { userActor in
                                        Text(userActor.name).tag(userActor as UserActorModel?)
                                    }
                                }
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                            }
                        }
                    }
                }
            }

            Button {
                if let window = UIApplication.shared.windows.first {
                    if let userActor = selectedActor, let user = selectedUser {
                        window.rootViewController = UIHostingController(rootView: ActorTabbedView(userActor: userActor, user: user))
                        window.makeKeyAndVisible()
                    }
                }
            } label: {
                Text("Load Character Sheet")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 30)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            Spacer()
        }
    }
}
