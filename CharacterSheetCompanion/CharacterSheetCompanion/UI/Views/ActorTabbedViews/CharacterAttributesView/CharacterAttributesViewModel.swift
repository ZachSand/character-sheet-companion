//
//  CharacterOverviewViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Combine
import Foundation

class CharacterAttributesViewModel: ObservableObject {
    @Published var attributes: ActorAttributesModel?
    @Published var baseData: ActorBaseDataModel?
    @Published var classes: [ActorClassModel]?

    var initiativeListener: RollInitiativeListener?
    var attributesListener: ActorAttributesListener?
    var baseDataListener: ActorBaseDataListener?
    var classesListener: ActorClassesListener?
    var subscription = Set<AnyCancellable>()

    init() {
        do {
            try initiativeListener = FoundrySocketIOManager.sharedInstance.getListener()

            try attributesListener = FoundrySocketIOManager.sharedInstance.getListener()
            attributesListener?.attributesPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.attributes = model
                })
                .store(in: &subscription)

            try baseDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            baseDataListener?.baseDataPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.baseData = model
                })
                .store(in: &subscription)

            try baseDataListener = FoundrySocketIOManager.sharedInstance.getListener()
            classesListener?.classesPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.classes = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func getClassInfo() -> String {
        if let classes = classes {
            return classes[0].id + " \(classes[0].levels)"
        }
        return ""
    }

    func getCharacterArmorClass() -> String {
        if let overview = attributes {
            return "AC " + String(overview.armorClass)
        }
        return ""
    }

    func getCharacterName() -> String {
        if let baseData = self.baseData {
            return baseData.name
        }
        return ""
    }

    func getHealth() -> String {
        if let overview = attributes {
            return "HP " + String(overview.currentHealth) + "/" + String(overview.maxHealth)
        }
        return ""
    }

    func getProficiencyBonus() -> String {
        if let overview = attributes {
            let profBonus = overview.proficiencyBonus
            if profBonus > 0 {
                return "PROF +" + String(profBonus)
            }
            return "PROF " + String(profBonus)
        }
        return ""
    }

    func getInitiativeBonus() -> String {
        if let overview = attributes {
            let initBonus = overview.initiativeBonus
            if initBonus > 0 {
                return "INIT +" + String(initBonus)
            }
            return "INIT " + String(initBonus)
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
