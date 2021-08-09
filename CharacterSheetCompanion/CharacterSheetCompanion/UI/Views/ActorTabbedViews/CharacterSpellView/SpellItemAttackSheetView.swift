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
    @State var spell: SpellModel
    @State private var advantage = false
    @State private var disadvantage = false
    @State private var consumeSpellSlot = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)
            if spell.spellLevel > 0 {
                Toggle("Consume Spell Slot", isOn: $consumeSpellSlot)
            }

            Button("Roll Attack for " + spell.name) {
                characterSpellVM.rollItemAttack(spell: spell, advantage: advantage, disadvantage: disadvantage, consumeSpellSlot: consumeSpellSlot)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .buttonStyle(ItemAttackButtonStyle())
        }
    }
}

#if DEBUG
    struct SpellItemAttackSheetView_Previews: PreviewProvider {
        static var previews: some View {
            SpellItemAttackSheetView(characterSpellVM: CharacterSpellViewModel(spellSlots: SpellSlotModel.mockedData), spell: SpellModel.mockedData[1])
        }
    }
#endif
