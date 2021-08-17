//
//  SpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/13/21.
//

import SwiftUI

struct SpellListView: View {
    @ObservedObject var spellListVM: SpellListViewModel
    @State private var selection: Set<ActorSpellModel> = []

    var body: some View {
        if let spells = spellListVM.spells {
            ForEach(spells.filter { spell in
                spell.spellLevel == spellListVM.spellLevel
            }) { spell in
                SpellRowView(
                    spell: spell,
                    isExpanded: self.selection.contains(spell)
                )
                .onTapGesture {
                    self.selectDeselect(spell)
                }
            }
        }
    }

    private func selectDeselect(_ spell: ActorSpellModel) {
        if selection.contains(spell) {
            selection.remove(spell)
        } else {
            selection.insert(spell)
        }
    }
}
