//
//  SpellItemDamageSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/5/21.
//

import SwiftUI

struct SpellItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var spellListVM: SpellListViewModel
    @State var spell: ActorSpellModel
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)

            Button("Roll Damage for " + spell.name) {
                spellListVM.rollItemDamage(spell: spell, critical: critical, versatile: versatile)
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
                spellListVM: SpellListViewModel(spellLevel: 0),
                spell: ActorSpellModel.mockedData[1]
            )
        }
    }
#endif
