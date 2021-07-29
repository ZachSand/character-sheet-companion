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
    
    func isConsumable(inventoryItemSummary: InventoryItemSummary) -> Bool {
        return inventoryItemSummary.type == "consumable"
    }
    
    func rollItemAttack(inventoryItemSummary: InventoryItemSummary, advantage: Bool, disadvantage: Bool) {
        let itemAttackRoll = ItemAttackRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, advantage: advantage, disadvantage: disadvantage, result: 0)
        FoundrySocketIOManager.sharedInstance.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
            DispatchQueue.main.async {
                if let itemAttackRollResult = attackRollResult {
                    print(itemAttackRollResult)
                }
            }
        }
    }
    
    func rollItemDamage(inventoryItemSummary: InventoryItemSummary, critical: Bool, versatile: Bool) {
        let itemDamageRoll = ItemDamageRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, critical: critical, versatile: versatile, result: 0)
        FoundrySocketIOManager.sharedInstance.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
            DispatchQueue.main.async {
                if let itemDamageRollResult = damageRollResult {
                    print(itemDamageRollResult)
                }
            }
        }
    }
    
    func rollItemConsume(inventoryItemSummary: InventoryItemSummary, consume: Bool) {
        let itemConsumeRoll = ItemConsumeRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, consume: consume, result: 0)
        FoundrySocketIOManager.sharedInstance.rollItemConsume(itemConsumeRoll: itemConsumeRoll) { consumeRollResult in
            DispatchQueue.main.async {
                if let itemConsumeRollResult = consumeRollResult {
                    print(itemConsumeRollResult)
                }
            }
        }
    }
    
    func rollItemToolRoll(inventoryItemSummary: InventoryItemSummary, advantage: Bool, disadvantage: Bool) {
        let itemToolRoll = ItemToolRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, advantage: advantage, disadvantage: disadvantage, result: 0)
        FoundrySocketIOManager.sharedInstance.rollItemTool(itemToolRoll: itemToolRoll) { toolRollResult in
            DispatchQueue.main.async {
                if let itemToolRollResult = toolRollResult {
                    print(itemToolRollResult)
                }
            }
        }
    }
    
    func displayItem(inventoryItemSummary: InventoryItemSummary) {
        let displayItem = ItemDisplayModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id)
        FoundrySocketIOManager.sharedInstance.displayItemCard(displayItem: displayItem)
    }
    
    func getConsumeText(inventoryItemSummary: InventoryItemSummary) -> String {
        if let usageRemaining = inventoryItemSummary.useRemaining, let useMax = inventoryItemSummary.useMax {
            return "This item has \(usageRemaining) of \(useMax) uses remaining. Consuming will remove one use."
        }
        return "This item has no usage data"
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
            var hasDamage = false
            if let damage = item.data.damage {
                hasDamage = damage.parts.count > 0
            }
            itemSummaries.append(
                InventoryItemSummary(
                    id: item.id,
                    img: item.img,
                    name: item.name,
                    description: item.data.dataDescription.value,
                    type: item.type,
                    hasDamage: hasDamage,
                    actionType: item.data.actionType,
                    useRemaining: item.data.uses?.value,
                    useMax: item.data.uses?.max,
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
    var type: String
    var hasDamage: Bool
    
    var actionType: String?
    var useRemaining: Int?
    var useMax: IntegerOrStringOrNull?
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