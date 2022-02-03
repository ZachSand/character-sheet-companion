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

    private var subscription = Set<AnyCancellable>()
    private var inventoryListener = SocketManagerWrapper.sharedInstance.actorListenerWrapper.actorInventoryListener

    init() {
        inventoryListener.modelPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { model in
                self.inventory = model
            })
            .store(in: &subscription)
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
