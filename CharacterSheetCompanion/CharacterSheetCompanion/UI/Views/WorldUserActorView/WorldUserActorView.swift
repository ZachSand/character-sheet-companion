//
//  UserActorPickerViewModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import SwiftUI

struct WorldUserActorView: View {
    @ObservedObject var worldUserActorVM: WorldUserActorViewModel
    @State private var selectedUser: UserModel?
    @State private var selectedActor: ActorModel?
    @State private var showingUserAuthSheet = false

    var body: some View {
        VStack {
            WorldDataView(worldDataVM: WorldDataViewModel())
            Divider()
            if let users = worldUserActorVM.users {
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
                                .onAppear {
                                    if users.count > 0 {
                                        selectedUser = users[0]
                                        worldUserActorVM.updateActors(selectedUser: users[0])
                                        if worldUserActorVM.actors.count > 0 {
                                            selectedActor = worldUserActorVM.actors[0]
                                        }
                                    }
                                }
                                .onChange(of: selectedUser) { tag in
                                    if let user = tag {
                                        worldUserActorVM.updateActors(selectedUser: user)
                                        if worldUserActorVM.actors.count > 0 {
                                            selectedActor = worldUserActorVM.actors[0]
                                        }
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
                                    ForEach(worldUserActorVM.actors) { actor in
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
                showingUserAuthSheet.toggle()
            } label: {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 30)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .sheet(isPresented: $showingUserAuthSheet) {
                UserAuthSheet(userAuthenticationSheetVM: UserAuthenticationViewModel(), user: $selectedUser, actor: $selectedActor)
            }
            Spacer()
        }
    }
}

#if DEBUG
    struct WorldUserActorView_Previews: PreviewProvider {
        static let worldUserActorVM: WorldUserActorViewModel = {
            let worldUserActorVM = WorldUserActorViewModel()
            worldUserActorVM.users = UserModel.mockedData
            return worldUserActorVM
        }()

        static var previews: some View {
            WorldUserActorView(worldUserActorVM: worldUserActorVM)
        }
    }
#endif
