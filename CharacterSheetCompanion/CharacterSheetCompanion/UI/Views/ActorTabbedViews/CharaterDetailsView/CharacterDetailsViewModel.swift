//
//  CharacterBiographyViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Combine
import Foundation

class CharacterDetailsViewModel: ObservableObject {
    @Published var details: ActorDetailsModel?

    var subscription = Set<AnyCancellable>()
    var detailsListener: ActorDetailsListener?

    init() {
        do {
            try detailsListener = FoundrySocketIOManager.sharedInstance.getListener()
            detailsListener?.detailsPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.details = model
                })
                .store(in: &subscription)
        } catch {
            preconditionFailure("Unable to get ability listeners: ")
        }
    }
}
