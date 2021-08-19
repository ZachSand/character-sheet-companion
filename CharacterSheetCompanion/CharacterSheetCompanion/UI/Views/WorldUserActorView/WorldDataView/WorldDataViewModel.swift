//
//  WorldDataViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import Foundation

class WorldDataViewModel: ObservableObject {
    @Published var worldData: WorldDataModel?

    private var worldDataListener: SetupWorldDataListener?

    init() {
        do {
            try worldDataListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
        fetchWorldData()
    }

    func fetchWorldData() {
        if let listener = worldDataListener {
            DispatchQueue.main.async {
                listener.getWorldData { worldDataModel in
                    self.worldData = worldDataModel
                }
            }
        }
    }
}
