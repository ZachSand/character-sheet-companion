//
//  ActorPickerView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import SwiftUI

struct ActorPickerView: View {
    @Binding var selectedActor: SetupActorModel?
    @Binding var selectedUser: SetupUserModel?

    var body: some View {
        VStack {
            if let user = selectedUser, let actors = user.actors {
                Picker(selection: $selectedActor, label: Text("Select Foundry Actor")) {
                    ForEach(actors) { actor in
                        Text(actor.name).tag(actor as SetupActorModel?)
                    }
                }.onAppear {
                    if actors.count > 0 {
                        selectedActor = actors[0]
                    }
                }
            } else {
                Text("No Actors for User")
            }
        }
    }
}

#if DEBUG
    struct ActorPickerView_Previews: PreviewProvider {
        @State static var selectedActor: SetupActorModel? = SetupActorModel.mockedData[0]
        @State static var selectedUser: SetupUserModel? = SetupUserModel.mockedData[0]

        static var previews: some View {
            ActorPickerView(selectedActor: $selectedActor, selectedUser: $selectedUser)
        }
    }
#endif
