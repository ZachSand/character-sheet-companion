//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State private var selection: Set<ActorSpellModel> = []

    var body: some View {
        VStack {
            if let spellSlots = characterSpellVM.spellSlots {
                List {
                    ForEach(spellSlots) { spellSlot in
                        Section(header: HStack {
                            Text(spellSlot.spellLevelLabel)
                            if spellSlot.maxSpellSlots > 0 {
                                Spacer()
                                Text("\(spellSlot.currentSpellSlots)/\(spellSlot.maxSpellSlots)")
                            }
                        }) {
                            ForEach(spellSlot.spells) { spell in
                                SpellView(
                                    characterSpellVM: characterSpellVM,
                                    spell: spell, isExpanded:
                                    self.selection.contains(spell)
                                )
                                .onTapGesture {
                                    self.selectDeselect(spell)
                                }
                            }
                        }
                    }
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

#if DEBUG
    struct CharacterSpellView_Previews: PreviewProvider {
        static let characterSpellVM: CharacterSpellViewModel = {
            let characterSpellVM = CharacterSpellViewModel()
            characterSpellVM.spellSlots = ActorSpellSlotModel.mockedData
            return characterSpellVM
        }()

        static var previews: some View {
            CharacterSpellView(characterSpellVM: characterSpellVM)
        }
    }
#endif
