//
//  CharacterShortRestSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/23/21.
//

import SwiftUI

struct CharacterShortRestSheetView: View {
    @Binding var classes: [ActorClassModel]?
    @Binding var attributes: ActorAttributesModel?

    @State private var selectedClass: ActorClassModel?
    var characterShortRestVM: CharacterShortRestSheetViewModel

    var body: some View {
        VStack {
            Text("Rest").font(.largeTitle)
            if let attributes = self.attributes {
                Text("Current Health: \(attributes.currentHealth) / \(attributes.maxHealth)").font(.title)
            }
            Spacer()
            if let classes = self.classes {
                Picker(selection: $selectedClass, label: Text("Select Foundry Actor")) {
                    ForEach(classes) { actorClass in
                        Text("\(actorClass.hitDice) (\(actorClass.levels - actorClass.hitDiceUsed) available from \(actorClass.id))").tag(actorClass as ActorClassModel?)
                    }
                }
                .onAppear {
                    if classes.count > 0 {
                        selectedClass = classes[0]
                    }
                }

                if let selectedActorClass = selectedClass {
                    Button("Roll Hit Die") {
                        characterShortRestVM.rollHitDie(actorClass: selectedActorClass)
                    }
                    .buttonStyle(HealButtonStyle())
                    .disabled(selectedActorClass.levels - selectedActorClass.hitDiceUsed == 0)
                    .opacity(selectedActorClass.levels - selectedActorClass.hitDiceUsed == 0 ? 0.5 : 1)
                }

                Spacer()

                Divider()

                Text("Take a short rest? On a short rest you may spend remaining Hit Dice and recover primary or secondary resources.")

                Button("Take Short Rest") {
                    characterShortRestVM.shortRest()
                }

                Divider()

                Text("Take a long rest? On a long rest you will recover hit points, half your maximum hit dice, class resources, limited use item charges, and spell slots.")

                Button("Take Long Rest") {
                    characterShortRestVM.longRest()
                }
                Spacer()
            } else {
                Text("No class data found for actor")
            }
        }
        .padding()
        .buttonStyle(RestButtonStyle())
    }
}

#if DEBUG
    struct CharacterShortRestSheetView_Previews: PreviewProvider {
        @State static var classes: [ActorClassModel]? = ActorClassModel.mockedData
        @State static var attributes: ActorAttributesModel? = ActorAttributesModel.mockedData

        static var previews: some View {
            CharacterShortRestSheetView(classes: $classes, attributes: $attributes, characterShortRestVM: CharacterShortRestSheetViewModel())
        }
    }
#endif
