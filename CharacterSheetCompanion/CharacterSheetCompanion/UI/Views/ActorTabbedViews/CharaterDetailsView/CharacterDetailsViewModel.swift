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

    private var subscription = Set<AnyCancellable>()
    private var detailsListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorDetailsListener

    init() {
        detailsListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.details = model
            })
            .store(in: &subscription)
    }
}
