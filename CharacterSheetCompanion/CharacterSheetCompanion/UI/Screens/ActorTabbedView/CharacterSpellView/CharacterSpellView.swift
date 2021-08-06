//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State private var selection: Set<SpellSummary> = []
    var foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterSpellVM = CharacterSpellViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(characterSpellVM.getSpellCategories()) { spellCategory in
                    Section(header: HStack{
                        Text(spellCategory.id)
                        if let spellSlotRemaining = spellCategory.spellSlotRemaining, let maxSpellSlot = spellCategory.maxSpellSlot {
                            Spacer()
                            Text("\(spellSlotRemaining)/\(maxSpellSlot)")
                        }
                    }) {
                        ForEach(spellCategory.items) { spellSummary in
                            SpellView(characterSpellVM: characterSpellVM, spellSummary: spellSummary, isExpanded: self.selection.contains(spellSummary))
                                .onTapGesture {
                                    characterSpellVM.getSpellDialog(spellId: spellSummary.id)
                                    self.selectDeselect(spellSummary)
                                    
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func selectDeselect(_ spellSummary: SpellSummary) {
            if selection.contains(spellSummary) {
                selection.remove(spellSummary)
            } else {
                selection.insert(spellSummary)
            }
        }
}
