//
//  SpellItemAttackSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct SpellItemAttackSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterSpellVM: CharacterSpellViewModel

    @State var spellConsumeSelection = ""
    @State var spellSummary: SpellSummary
    @State private var advantage = false
    @State private var disadvantage = false
    @State private var consumeSpellSlot = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)
            if spellSummary.level > 0 {
                if let dialogs = characterSpellVM.spellDialogMapping[spellSummary.id] {
                    Picker(selection: $spellConsumeSelection, label: Text("Spell Consume Options"), content: {
                        ForEach(dialogs, id: \.self) { dialog in
                            Text(dialog.label)
                        }
                    })
                }
                Toggle("Consume Spell Slot", isOn: $consumeSpellSlot)
            }

            Button("Roll Attack for " + spellSummary.name) {
                characterSpellVM.rollItemAttack(spellSummary: spellSummary, advantage: advantage, disadvantage: disadvantage, consumeSpellSlot: consumeSpellSlot)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .buttonStyle(ItemAttackButtonStyle())
        }
    }
}
