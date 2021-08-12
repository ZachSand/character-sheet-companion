//
//  CharacterOverviewViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Combine
import Foundation

class CharacterOverviewViewModel: ObservableObject {
    @Published var actorOverview: ActorOverviewModel?

    var initiativeListener: RollInitiativeListener?
    var overviewListener: ActorOverviewListener?
    var subscription = Set<AnyCancellable>()

    init() {
        do {
            try initiativeListener = FoundrySocketIOManager.sharedInstance.getListener()
            try overviewListener = FoundrySocketIOManager.sharedInstance.getListener()
            overviewListener?.overviewPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.actorOverview = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func getCharacterArmorClass() -> String {
        if let overview = actorOverview {
            return "AC " + String(overview.armorClass)
        }
        return ""
    }

    func getCharacterName() -> String {
        if let overview = actorOverview {
            return overview.name
        }
        return ""
    }

    func getHealth() -> String {
        if let overview = actorOverview {
            return "HP " + String(overview.currentHealth) + "/" + String(overview.maxHealth)
        }
        return ""
    }

    func getProficiencyBonus() -> String {
        if let overview = actorOverview {
            let profBonus = overview.proficiencyBonus
            if profBonus > 0 {
                return "PROF +" + String(profBonus)
            }
            return "PROF " + String(profBonus)
        }
        return ""
    }

    func getInitiativeBonus() -> String {
        if let overview = actorOverview {
            let initBonus = overview.initiativeBonus
            if initBonus > 0 {
                return "INIT +" + String(initBonus)
            }
            return "INIT " + String(initBonus)
        }
        return ""
    }

    func getClassInfo() -> String {
        if let overview = actorOverview {
            return overview.mainClass + " \(overview.overallLevel)"
        }
        return ""
    }

    func rollInitiative() {
        if let listener = initiativeListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let rollModel = InitiativeRollModel(actorId: actor.id, result: 0)
            DispatchQueue.main.async {
                listener.rollInitiative(initiativeRoll: rollModel) { initiativeRollResult in
                    print(initiativeRollResult)
                }
            }
        }
    }
}
