//
//  WorldDataViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Combine
import Foundation

class WorldDataViewModel: ObservableObject {
    @Published var worldData: WorldDataModel?
    private var subscription = Set<AnyCancellable>()

    private var worldDataListener = SocketManagerWrapper.sharedInstance.setupListenerWrapper.setupWorldListener

    init() {
        worldDataListener.modelPublisher
            .sink(receiveValue: { model in
                self.worldData = model
            })
            .store(in: &subscription)
        worldDataListener.request()
    }
}
