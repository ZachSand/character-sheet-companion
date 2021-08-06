//
//  SpellItemDamageSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct SpellItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State var spellSummary: SpellSummary
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)
            
            Button("Roll Damage for " + spellSummary.name) {
                characterSpellVM.rollItemDamage(spellSummary: spellSummary, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .buttonStyle(ItemDamageButtonStyle())
            
        }
    }
}
