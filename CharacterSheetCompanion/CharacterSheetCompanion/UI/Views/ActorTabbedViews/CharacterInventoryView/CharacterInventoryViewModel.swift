//
//  CharacterEquipmentViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Combine
import Foundation

class CharacterInventoryViewModel: ObservableObject {
    @Published var inventory: ActorInventoryModel?
    var subscription = Set<AnyCancellable>()
    var inventoryListener: ActorInventoryListener?

    init() {
        do {
            try inventoryListener = FoundrySocketIOManager.sharedInstance.getListener()
            inventoryListener?.inventoryPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.inventory = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func getInventorySections() -> [InventorySection] {
        if let actorInventory = inventory {
            return [
                InventorySection(id: "Weapons", inventoryItems: actorInventory.weapons),
                InventorySection(id: "Equipment", inventoryItems: actorInventory.equipment),
                InventorySection(id: "Consumables", inventoryItems: actorInventory.consumables),
                InventorySection(id: "Tools", inventoryItems: actorInventory.tools),
                InventorySection(id: "Containers", inventoryItems: actorInventory.containers),
                InventorySection(id: "Loot", inventoryItems: actorInventory.loot),
            ]
        }
        return []
    }
}

struct InventorySection: Identifiable, Hashable {
    var id: String
    var inventoryItems: [ActorInventoryItemModel]
}
