//
//  ExpandedSpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct ExpandedSpellView: View {
    var characterSpellVM: CharacterSpellViewModel
    let spellSummary: SpellSummary
    
    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false
    
    var body: some View {
        VStack {
            Button("Display in VTT") {
                characterSpellVM.displayItem(spellSummary: spellSummary)
            }
            .buttonStyle(ItemDisplayButtonStyle())
            
            if characterSpellVM.hasAttack(spellSummary: spellSummary) {
                Button("Cast Spell") {
                    showingAttackSheet.toggle()
                }.sheet(isPresented: $showingAttackSheet, content: {
                    SpellItemAttackSheetView(characterSpellVM: characterSpellVM, spellSummary: spellSummary)
                })
                .buttonStyle(ItemAttackButtonStyle())
            }
            
            if spellSummary.hasDamage {
                Button("Roll Damage") {
                    showingDamageSheet.toggle()
                }.sheet(isPresented: $showingDamageSheet, content: {
                    SpellItemDamageSheetView(characterSpellVM: characterSpellVM, spellSummary: spellSummary)
                })
                .buttonStyle(ItemDamageButtonStyle())
            }
            
            Divider()
            Text(spellSummary.description).font(.footnote)
        }
    }
}
