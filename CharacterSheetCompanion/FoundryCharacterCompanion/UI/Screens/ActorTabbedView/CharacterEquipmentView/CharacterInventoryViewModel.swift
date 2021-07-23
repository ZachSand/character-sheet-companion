//
//  CharacterEquipmentViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterInventoryViewModel: ObservableObject {
    @Published var foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
    }
    
    func getInventoryCategories() -> [InventoryCategory] {
        var inventoryCategories: [InventoryCategory] = []
        inventoryCategories.append(InventoryCategory(id: "Weapons", items: getWeapons()))
        inventoryCategories.append(InventoryCategory(id: "Equipment", items: getEquipment()))
        inventoryCategories.append(InventoryCategory(id: "Consumables", items: getConsumables()))
        inventoryCategories.append(InventoryCategory(id: "Tools", items: getTools()))
        inventoryCategories.append(InventoryCategory(id: "Containers", items: getContainers()))
        inventoryCategories.append(InventoryCategory(id: "Loot", items: getLoot()))
        return inventoryCategories
    }
    
    func hasAttack(inventoryItemSummary: InventoryItemSummary) -> Bool {
        if let actionType = inventoryItemSummary.actionType {
            return actionType == "mwak" || actionType == "rwak" || actionType == "msak" || actionType == "rsak"
        }
        return false
    }
    
    func rollItemAttack(inventoryItemSummary: InventoryItemSummary) {
        let itemAttackRoll = ItemAttackRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, advantage: false, disadvantage: false, result: 0)
        FoundrySocketIOManager.sharedInstance.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
            DispatchQueue.main.async {
                if let itemAttackRollResult = attackRollResult {
                    print(itemAttackRollResult)
                }
            }
        }
    }
    
    func displayItem(inventoryItemSummary: InventoryItemSummary) {
        let displayItem = ItemDisplayModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id)
        FoundrySocketIOManager.sharedInstance.displayItemCard(displayItem: displayItem)
    }
    
    private func getWeapons() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.weapon)
    }
    
    private func getEquipment() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.equipment)
    }
    
    private func getConsumables() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.consumable)
    }
    
    private func getTools() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.tool)
    }
    
    private func getContainers() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.backpack)
    }
    
    private func getLoot() -> [InventoryItemSummary] {
        return getItemSummary(itemData: foundryActor.actor.actorItems.inventory.loot)
    }
    
    private func getItemSummary(itemData: [ActorItem]) -> [InventoryItemSummary] {
        var itemSummaries: [InventoryItemSummary] = []
        for item in itemData {
            itemSummaries.append(
                InventoryItemSummary(
                    id: item.id,
                    img: item.img,
                    name: item.name,
                    description: item.data.dataDescription.value,
                    actionType: item.data.actionType,
                    quantity: item.data.quantity,
                    weight: item.data.weight,
                    price: item.data.price))
        }
        return itemSummaries
    }
}

struct InventoryCategory: Identifiable {
    var id: String
    var items: [InventoryItemSummary]
}

struct InventoryItemSummary: Identifiable, Hashable {
    var id: String
    var img: String
    var name: String
    var description: String
    
    var actionType: String?
    var quantity: Int?
    var weight: StringOrDouble?
    var price: StringOrDouble?
    
    static func ==(lhs: InventoryItemSummary, rhs: InventoryItemSummary) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
