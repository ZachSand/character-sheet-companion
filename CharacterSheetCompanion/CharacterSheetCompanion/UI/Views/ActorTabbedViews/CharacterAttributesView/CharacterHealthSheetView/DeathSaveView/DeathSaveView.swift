//
//  DeathSaveView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/20/21.
//

import SwiftUI

struct DeathSaveView: View {
    var deathSaveViewModel = DeathSaveViewModel()
    @Binding var attributes: ActorAttributesModel?

    var body: some View {
        VStack {
            Text("Death Saves")
            HStack {
                Text("Failures")
                if let attributes = self.attributes {
                    CheckBoxView(checked: attributes.deathSaves.failure >= 1)
                    CheckBoxView(checked: attributes.deathSaves.failure >= 2)
                    CheckBoxView(checked: attributes.deathSaves.failure >= 3)
                }
            }

            HStack {
                Text("Successes")
                if let attributes = self.attributes {
                    CheckBoxView(checked: attributes.deathSaves.success >= 1)
                    CheckBoxView(checked: attributes.deathSaves.success >= 2)
                    CheckBoxView(checked: attributes.deathSaves.success >= 3)
                }
            }

            Button("Roll Death Save") {
                deathSaveViewModel.rollDeathSave(advantage: false, disadvantage: false)
            }
            .disabled(attributes?.currentHealth != 0)
            .buttonStyle(DeathButtonStyle())
        }
    }
}

#if DEBUG
    struct DeathSaveView_Previews: PreviewProvider {
        @State static var attributes: ActorAttributesModel? = ActorAttributesModel.mockedData
        static var previews: some View {
            DeathSaveView(attributes: $attributes)
        }
    }
#endif
