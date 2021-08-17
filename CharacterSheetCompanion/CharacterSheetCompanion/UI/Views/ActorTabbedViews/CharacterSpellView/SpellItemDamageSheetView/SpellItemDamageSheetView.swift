//
//  SpellItemDamageSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct SpellItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var spellItemDamageSheetVM: SpellItemDamageSheetViewModel
    @State var spell: ActorSpellModel
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)

            Button("Roll Damage for " + spell.name) {
                spellItemDamageSheetVM.rollItemDamage(spell: spell, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .buttonStyle(ItemDamageButtonStyle())
        }
    }
}

#if DEBUG
    struct SpellItemDamageSheetView_Previews: PreviewProvider {
        static var previews: some View {
            SpellItemDamageSheetView(
                spellItemDamageSheetVM: SpellItemDamageSheetViewModel(),
                spell: ActorSpellModel.mockedData[1]
            )
        }
    }
#endif
