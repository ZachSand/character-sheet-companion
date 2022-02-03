//
//  UserActorPickerViewModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import SwiftUI

struct WorldUserActorView: View {
    @State private var selectedUser: SetupUserModel?
    @State private var selectedActor: SetupActorModel?

    var body: some View {
        VStack {
            WorldDataView(worldDataVM: WorldDataViewModel())
            Divider()
            GeometryReader { geometry in
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Section(header: Text("User")) {
                            UserPickerView(userPickerVM: UserPickerViewModel(), selectedUser: $selectedUser)
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                        }
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Section(header: Text("Actor")) {
                            ActorPickerView(selectedActor: $selectedActor, selectedUser: $selectedUser)
                                .frame(maxWidth: (geometry.size.width / 4) * 3, maxHeight: geometry.size.height / 2.5)
                                .clipped()
                        }
                        Spacer()
                    }
                }
            }

            UserActorLoginButtonView(selectedUser: $selectedUser, selectedActor: $selectedActor)
            Spacer()
        }
        .navigationTitle("User Actor Selection")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
    struct WorldUserActorView_Previews: PreviewProvider {
        static var previews: some View {
            WorldUserActorView()
        }
    }
#endif
