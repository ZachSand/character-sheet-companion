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
    var subscription = Set<AnyCancellable>()
    var currencyListener: ActorCurrencyListener?

    init() {
        do {
            try currencyListener = FoundrySocketIOManager.sharedInstance.getListener()
            currencyListener?.currencyPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.currency = model
                })
                .store(in: &subscription)
        } catch {}
    }
}
