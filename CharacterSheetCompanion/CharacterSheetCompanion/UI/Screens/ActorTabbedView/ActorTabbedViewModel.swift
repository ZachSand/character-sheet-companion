//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorTabbedViewModel: ObservableObject {
    @Published var foundryActor: ActorModel?
    var userActor: UserActorModel
    
    init(userActor: UserActorModel) {
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
