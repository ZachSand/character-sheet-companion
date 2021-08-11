//
//  ExpandedSpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct ExpandedSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    var spell: ActorSpellModel

    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false

    var body: some View {
        VStack {
            Button("Display in VTT") {
                characterSpellVM.displayItem(spell: spell)
            }
            .buttonStyle(ItemDisplayButtonStyle())

            if spell.hasAttack {
                Button("Cast Spell") {
                    showingAttackSheet.toggle()
                }.sheet(isPresented: $showingAttackSheet, content: {
                    SpellItemAttackSheetView(characterSpellVM: characterSpellVM, spell: spell)
                })
                    .buttonStyle(ItemAttackButtonStyle())
            }

            if spell.hasDamage {
                Button("Roll Damage") {
                    showingDamageSheet.toggle()
                }.sheet(isPresented: $showingDamageSheet, content: {
                    SpellItemDamageSheetView(characterSpellVM: characterSpellVM, spell: spell)
                })
                    .buttonStyle(ItemDamageButtonStyle())
            }

            Divider()
            Text(spell.description).font(.footnote)
        }
    }
}

#if DEBUG
    struct ExpandedSpellView_Previews: PreviewProvider {
        static var previews: some View {
            ExpandedSpellView(characterSpellVM: CharacterSpellViewModel(spellSlots: ActorSpellSlotModel.mockedData), spell: ActorSpellModel.mockedData[0])
        }
    }
#endif
