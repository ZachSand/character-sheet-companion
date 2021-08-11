//
//  ActorDetailSummaryViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

class ActorTabbedViewModel: ObservableObject {
    @Published var dataLoadComplete: Bool
    var actor: ActorModel

    init(actor: ActorModel) {
        dataLoadComplete = false
        self.actor = actor
    }
}
