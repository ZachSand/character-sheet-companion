//
//  CharacterEquipmentViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterInventoryViewModel: ObservableObject {
    @Published var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor
    }
    
    func getInventorySummary() -> [ItemSummary] {
        var inventorySummary: [ItemSummary] = []
        inventorySummary.append(ItemSummary(id: "Weapons", items: getWeapons()))
        inventorySummary.append(ItemSummary(id: "Equipment", items: getEquipment()))
        inventorySummary.append(ItemSummary(id: "Consumables", items: getConsumables()))
        inventorySummary.append(ItemSummary(id: "Tools", items: getTools()))
        inventorySummary.append(ItemSummary(id: "Containers", items: getContainers()))
        inventorySummary.append(ItemSummary(id: "Loot", items: getLoot()))
        return inventorySummary
    }
    
    private func getWeapons() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.weapon)
    }
    
    private func getEquipment() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.equipment)
    }
    
    private func getConsumables() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.consumable)
    }
    
    private func getTools() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.tool)
    }
    
    private func getContainers() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.backpack)
    }
    
    private func getLoot() -> [ItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.loot)
    }
    
    private func getItemSummary(itemData: [ActorItem]) -> [ItemSummary] {
        var itemSummary: [ItemSummary] = []
        for item in itemData {
            itemSummary.append(
                ItemSummary(id: item.name, img: "imghere", name: item.name, quantity: item.data.quantity, cost: item.data.price, details:
                                ItemDetails(description: item.data.dataDescription.value, weight: item.data.weight)))
        }
        return itemSummary
    }
}

struct ItemSummary: Identifiable {
    // top level
    var id: String
    
    // List level
    var items: [ItemSummary]?
    var img: String?
    var name: String?
    var quantity: Int?
    var cost: StringOrDouble?
    
    // Detail view
    var details: ItemDetails?
    
}

struct ItemDetails {
    var description: String
    var weight: StringOrDouble?
}
