//
//  ActorTabbedViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import Foundation

class ActorTabbedViewModel: ObservableObject {
    @Published var isActorDataReady = false
    private var actorListenerWrapper: ActorListenerWrapper

    init() {
        actorListenerWrapper = ActorListenerWrapper()
        actorListenerWrapper.isActorDataReady { dataIsReady in
            self.isActorDataReady = dataIsReady
        }
        actorListenerWrapper.requestActorData()
    }
}
