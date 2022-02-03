//
//  CharacterTraitsView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/19/21.
//

import SwiftUI

struct CharacterTraitsView: View {
    @ObservedObject var characterTraitsVM: CharacterTraitsViewModel

    var body: some View {
        ScrollView {
            VStack {
                if let traits = characterTraitsVM.traits {
                    CharacterTraitView(traits: [traits.size], sectionHeader: "Size")
                    CharacterTraitView(traits: characterTraitsVM.getSenses(), sectionHeader: "Senses")
                    CharacterTraitView(traits: traits.languages, sectionHeader: "Languages")
                    CharacterTraitView(traits: traits.armorProficiencies, sectionHeader: "Armor Proficiencies")
                    CharacterTraitView(traits: traits.armorProficiencies, sectionHeader: "Weapon Proficiencies")
                    CharacterTraitView(traits: traits.toolProficiencies, sectionHeader: "Tool Proficiencies")
                    CharacterTraitView(traits: traits.conditionImmunities, sectionHeader: "Condition Immunities")
                    CharacterTraitView(traits: traits.damageImmunities, sectionHeader: "Damage Immunities")
                    CharacterTraitView(traits: traits.damageResistances, sectionHeader: "Damage Resistances")
                    CharacterTraitView(traits: traits.damageVulnerabilities, sectionHeader: "Damage Vulnerabilities")
                } else {
                    Text("No traits found for actor")
                }
            }
        }
    }
}

#if DEBUG
    struct CharacterTraitsView_Previews: PreviewProvider {
        static let characterTraitsVM: CharacterTraitsViewModel = {
            let characterTraitsVM = CharacterTraitsViewModel()
            characterTraitsVM.traits = ActorTraitsModel.mockedData
            return characterTraitsVM
        }()

        static var previews: some View {
            CharacterTraitsView(characterTraitsVM: characterTraitsVM)
        }
    }
#endif
