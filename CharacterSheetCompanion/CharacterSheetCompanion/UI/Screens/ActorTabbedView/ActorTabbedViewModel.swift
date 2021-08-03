//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorTabbedViewModel: ObservableObject {
    @Published var foundryActor: ActorModel?
    var actorDataListener: ActorListener?
    var userActor: UserActorModel
    
    init(userActor: UserActorModel) {
        self.userActor = userActor;
        do {
            try actorDataListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {
            
        }
        fetchActorData(actorId: self.userActor.actorId)
    }
    
    func fetchActorData(actorId: String) {
        if let listener = actorDataListener {
            DispatchQueue.main.async {
                listener.getActorData(actorId: actorId) { actor in
                    self.foundryActor = actor;
                }
            }
        }
    }
}
