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

    private var initiativeListener = SocketManagerWrapper.sharedInstance.rollListenerWrapper.initiativeRollListener
    private var attributesListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorAttributesListener
    private var baseDataListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorBaseDataListener
    private var classesListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorClassesListener
    private var subscription = Set<AnyCancellable>()

    init() {
        attributesListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.attributes = model
            })
            .store(in: &subscription)

        baseDataListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.baseData = model
            })
            .store(in: &subscription)

        classesListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.classes = model?.classes
            })
            .store(in: &subscription)
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
        if let actor = SocketManagerWrapper.sharedInstance.actor {
            initiativeListener.request(model: InitiativeRollModel(actorId: actor.id, result: 0))
        }
    }
}
