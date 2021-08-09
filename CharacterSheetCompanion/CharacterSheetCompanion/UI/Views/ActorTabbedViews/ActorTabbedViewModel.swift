//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorTabbedViewModel: ObservableObject {
    @Published var dataLoadComplete: Bool?
    var actorDataListener: ActorDataListener?
    var actor: ActorModel

    init(actor: ActorModel) {
        self.actor = actor
        do {
            try actorDataListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        fetchActorData(actorId: actor.id)
    }

    func fetchActorData(actorId: String) {
        if let listener = actorDataListener {
            DispatchQueue.main.async {
                listener.getActorData(actorId: actorId) { _ in
                    self.dataLoadComplete = true
                }
            }
        }
    }
}
