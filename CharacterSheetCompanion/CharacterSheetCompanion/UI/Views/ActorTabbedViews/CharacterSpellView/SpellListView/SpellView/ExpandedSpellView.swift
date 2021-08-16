//
//  ExpandedSpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct ExpandedSpellView: View {
    @ObservedObject var spellListVM: SpellListViewModel
    var spell: ActorSpellModel

    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false

    var body: some View {
        VStack {
            Button("Display in VTT") {
                spellListVM.displayItem(spell: spell)
            }
            .buttonStyle(ItemDisplayButtonStyle())

            if spell.hasAttack {
                Button("Cast Spell") {
                    showingAttackSheet.toggle()
                }.sheet(isPresented: $showingAttackSheet, content: {
                    SpellItemAttackSheetView(spellListVM: spellListVM, spell: spell)
                })
                    .buttonStyle(ItemAttackButtonStyle())
            }

            if spell.hasDamage {
                Button("Roll Damage") {
                    showingDamageSheet.toggle()
                }.sheet(isPresented: $showingDamageSheet, content: {
                    SpellItemDamageSheetView(spellListVM: spellListVM, spell: spell)
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
            ExpandedSpellView(
                spellListVM: SpellListViewModel(spellLevel: 0),
                spell: ActorSpellModel.mockedData[0]
            )
        }
    }
#endif
