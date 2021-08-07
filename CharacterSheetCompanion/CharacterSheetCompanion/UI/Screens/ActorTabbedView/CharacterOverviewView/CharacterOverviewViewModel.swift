//
//  CharacterOverviewViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Foundation

class CharacterOverviewViewModel: ObservableObject {
    @Published var actorOverview: ActorOverviewModel
    var initiativeListener: InitiativeListener?

    let MAX_CHARACTER_NAME_SIZE = 25

    init(actorOverview: ActorOverviewModel) {
        self.actorOverview = actorOverview
        do {
            try initiativeListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func getCharacterArmorClass() -> String {
        "AC " + String(actorOverview.armorClass)
    }

    func getCharacterName() -> String {
        actorOverview.name
    }

    func getHealth() -> String {
        "HP " + String(actorOverview.currentHealth) + "/" + String(actorOverview.maxHealth)
    }

    func getProficiencyBonus() -> String {
        let profBonus = actorOverview.proficiencyBonus
        if profBonus > 0 {
            return "PROF +" + String(profBonus)
        }
        return "PROF " + String(profBonus)
    }

    func getInitiativeBonus() -> String {
        let initBonus = actorOverview.initiativeBonus
        if initBonus > 0 {
            return "INIT +" + String(initBonus)
        }
        return "INIT " + String(initBonus)
    }

    func getClassInfo() -> String {
        actorOverview.mainClass + " \(actorOverview.overallLevel)"
    }

    func rollInitiative() {
        if let listener = initiativeListener {
            let rollModel = InitiativeRollModel(actorId: actorOverview.id, result: 0)
            DispatchQueue.main.async {
                listener.rollInitiative(initiativeRoll: rollModel) { initiativeRollResult in
                    if let rollResult = initiativeRollResult {
                        print(rollResult)
                    }
                }
            }
        }
    }
}
