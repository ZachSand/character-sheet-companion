//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel

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
                            SpellListView(spellListVM: SpellListViewModel(spellLevel: spellSlot.spellLevel))
                        }
                    }
                }
            } else {
                Text("No spells found for actor")
            }
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
