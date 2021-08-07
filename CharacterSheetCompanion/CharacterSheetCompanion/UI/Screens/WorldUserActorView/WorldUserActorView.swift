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

    let users: [UserModel]
    let actors: [ActorModel]
    let worldData: WorldDataModel

    init(users: [UserModel], actors: [ActorModel], worldData: WorldDataModel) {
        self.users = users
        self.actors = actors
        self.worldData = worldData
        worldUserActorVM = WorldUserActorViewModel()
        selectedUser = users[0]
        selectedActor = actors[0]
    }

    var body: some View {
        VStack {
            WorldDataView(worldData: worldData)
            Divider()

            GeometryReader { geometry in
                VStack(spacing: 5) {
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

                    HStack {
                        Spacer()
                        Section(header: Text("Actor")) {
                            Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                                ForEach(actors) { actor in
                                    Text(actor.name).tag(actor as ActorModel)
                                }
                            }
                            .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                            .clipped()
                        }
                        Spacer()
                    }
                }
            }

            Button {
                if let window = UIApplication.shared.windows.first {
                    if let actor = selectedActor, let user = selectedUser {
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
        static var previews: some View {
            WorldUserActorView(
                users: UserModel.mockedData,
                actors: ActorModel.mockedData,
                worldData: WorldDataModel.mockedData
            )
        }
    }
#endif
