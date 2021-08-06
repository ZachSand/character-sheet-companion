//
//  CharacterBiographyViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Foundation

class CharacterBiographyViewModel: ObservableObject {
    var foundryActor: ActorModel

    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
    }

    func getAppearance() -> String {
        return foundryActor.actor.actorData.details.appearance
    }

    func getPersonalityTraits() -> String {
        return foundryActor.actor.actorData.details.trait
    }

    func getIdeals() -> String {
        return foundryActor.actor.actorData.details.ideal
    }

    func getBonds() -> String {
        return foundryActor.actor.actorData.details.bond
    }

    func getFlaws() -> String {
        return foundryActor.actor.actorData.details.flaw
    }

    func getBiography() -> String {
        return foundryActor.actor.actorData.details.biography.value
    }
}
