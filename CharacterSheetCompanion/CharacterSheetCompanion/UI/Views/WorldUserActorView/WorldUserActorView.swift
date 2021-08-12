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
    @State var selectedActor: ActorModel?

    var body: some View {
        VStack {
            if let worldData = worldUserActorVM.worldData {
                WorldDataView(worldData: worldData)
            }
            Divider()

            GeometryReader { geometry in
                VStack(spacing: 5) {
                    if let users = worldUserActorVM.users {
                        HStack {
                            Spacer()
                            Section(header: Text("User")) {
                                Picker(selection: $selectedUser, label: Text("Select Foundry User")) {
                                    ForEach(users) { user in
                                        Text(user.name).tag(user as UserModel?)
                                    }
                                }
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                            }
                            Spacer()
                        }
                    }

                    if let actors = worldUserActorVM.actors {
                        HStack {
                            Spacer()
                            Section(header: Text("Actor")) {
                                Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                                    ForEach(actors) { actor in
                                        Text(actor.name).tag(actor as ActorModel?)
                                    }
                                }
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                            }
                            Spacer()
                        }
                    }
                }
            }

            Button {
                if let window = UIApplication.shared.windows.first {
                    if let actor = selectedActor, let user = selectedUser {
                        worldUserActorVM.setActor(actor: actor)
                        worldUserActorVM.setUser(user: user)
                        window.rootViewController = UIHostingController(rootView: ActorTabbedView(actor: actor, user: user))
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

#if DEBUG
    struct WorldUserActorView_Previews: PreviewProvider {
        static let worldUserActorVM: WorldUserActorViewModel = {
            let worldUserActorVM = WorldUserActorViewModel()
            worldUserActorVM.actors = ActorModel.mockedData
            worldUserActorVM.users = UserModel.mockedData
            worldUserActorVM.worldData = WorldDataModel.mockedData
            return worldUserActorVM
        }()

        static var previews: some View {
            WorldUserActorView(worldUserActorVM: worldUserActorVM)
        }
    }
#endif
