//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorDetailSummaryViewModel: ObservableObject {
    @Published var foundryActor: FoundryActor?
    var userActor: FoundryUserActor
    
    init(userActor: FoundryUserActor) {
        self.userActor = userActor;
        fetchActorData(actorId: self.userActor.actorId)
    }
    
    func fetchActorData(actorId: String) {
        DispatchQueue.main.async {
            FoundrySocketIOManager.sharedInstance.getActorData(actorId: actorId) { actor in
                self.foundryActor = actor;
            }
        }
    }
}
