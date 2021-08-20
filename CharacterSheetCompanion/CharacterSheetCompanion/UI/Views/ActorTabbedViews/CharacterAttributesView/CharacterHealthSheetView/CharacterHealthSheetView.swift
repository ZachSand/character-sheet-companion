//
//  CharacterHealthSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/19/21.
//

import SwiftUI

struct CharacterHealthSheetView: View {
    var characterHealthSheetVM: CharacterHealthSheetViewModel
    @Binding var attributes: ActorAttributesModel?
    @State private var healthModificationAmount = 0

    var body: some View {
        VStack {
            if let attributes = self.attributes {
                Text("Health").font(.largeTitle)
                Spacer()
                
                if let attributes = self.attributes {
                    if attributes.currentHealth == 0 {
                        DeathSaveView(deathSaveViewModel: DeathSaveViewModel(), attributes: $attributes)
                        Spacer()
                    }
                }
                
                Text("Current Health: \(attributes.currentHealth) / \(attributes.maxHealth)").font(.title)
                Spacer()
                HStack {
                    Text("Health")
                    Picker(selection: $healthModificationAmount, label: Text("Choose Health Change")) {
                        ForEach(0 ... 100, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Spacer()

                HStack {
                    Button("Healing") {
                        characterHealthSheetVM.applyDamage(healthChange: -healthModificationAmount)
                    }.buttonStyle(HealButtonStyle())

                    Button("Damage") {
                        characterHealthSheetVM.applyDamage(healthChange: healthModificationAmount)
                    }.buttonStyle(ItemDamageButtonStyle())
                }
            } else {
                Text("No Health data found for actor")
            }
        }
    }
}

#if DEBUG
    struct CharacterHealthSheetView_Previews: PreviewProvider {
        @State static var attributes: ActorAttributesModel? = ActorAttributesModel.mockedData

        static var previews: some View {
            CharacterHealthSheetView(characterHealthSheetVM: CharacterHealthSheetViewModel(), attributes: $attributes)
        }
    }
#endif
