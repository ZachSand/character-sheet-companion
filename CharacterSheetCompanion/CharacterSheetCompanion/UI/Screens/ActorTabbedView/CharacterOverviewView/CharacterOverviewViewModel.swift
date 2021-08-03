//
//  CharacterOverviewViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/21/21.
//

import Foundation

class CharacterOverviewViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    var initiativeListener: InitiativeListener?
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor;
        do {
            try initiativeListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {
            
        }
    }
    
    func getAC() -> String {
        return "AC " + String(foundryActor.actor.actorData.attributes.ac.value)
    }
    
    func getHealth() -> String {
        let healthData = foundryActor.actor.actorData.attributes.hp
        return "HP " + String(healthData.value) + "/" + String(healthData.max)
    }
    
    func getProficiencyBonus() -> String {
        let profBonus = foundryActor.actor.actorData.attributes.prof
        if(profBonus > 0) {
            return "PROF +" + String(profBonus)
        }
        return "PROF " + String(profBonus)
    }
    
    func getInitiativeBonus() -> String {
        let initBonus = foundryActor.actor.actorData.attributes.attributesInit.mod
        if(initBonus > 0) {
            return "INIT +" + String(initBonus)
        }
        return "INIT " + String(initBonus)
    }
    
    func getClassInfo() -> String {
        var classInfo = ""
        for data in foundryActor.actor.actorData.classes {
            classInfo += data.name + " " + String(data.levels)
            classInfo += "/"
        }
        classInfo.removeLast()
        return classInfo
    }
    
    func rollInitiative() {
        if let listener = initiativeListener {
            let rollModel = InitiativeRollModel(actorId: foundryActor.actor.id, result: 0)
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
