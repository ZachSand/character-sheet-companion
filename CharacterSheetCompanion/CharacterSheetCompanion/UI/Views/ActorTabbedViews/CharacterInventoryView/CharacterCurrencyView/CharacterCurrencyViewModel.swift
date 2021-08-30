//
//  CharacterCurrencyViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/13/21.
//

import Combine
import Foundation

class CharacterCurrencyViewModel: ObservableObject {
    @Published var currency: ActorCurrencyModel?

    private var subscription = Set<AnyCancellable>()
    private var currencyListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorCurrencyListener

    init() {
        currencyListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.currency = model
            })
            .store(in: &subscription)
    }
}
