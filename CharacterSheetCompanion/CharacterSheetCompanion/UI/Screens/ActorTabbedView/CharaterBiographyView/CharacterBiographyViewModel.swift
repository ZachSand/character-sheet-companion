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
        foundryActor.actor.actorData.details.appearance
    }

    func getPersonalityTraits() -> String {
        foundryActor.actor.actorData.details.trait
    }

    func getIdeals() -> String {
        foundryActor.actor.actorData.details.ideal
    }

    func getBonds() -> String {
        foundryActor.actor.actorData.details.bond
    }

    func getFlaws() -> String {
        foundryActor.actor.actorData.details.flaw
    }

    func getBiography() -> String {
        foundryActor.actor.actorData.details.biography.value
    }
}
