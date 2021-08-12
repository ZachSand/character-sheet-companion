//
//  CharacterBiographyViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Combine
import Foundation

class CharacterBiographyViewModel: ObservableObject {
    @Published var biography: ActorBiographyModel?

    var subscription = Set<AnyCancellable>()
    var biographyListener: ActorBiographyListener?

    init() {
        do {
            try biographyListener = FoundrySocketIOManager.sharedInstance.getListener()
            biographyListener?.biographyPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.biography = model
                })
                .store(in: &subscription)
        } catch {
            preconditionFailure("Unable to get ability listeners: ")
        }
    }
}
