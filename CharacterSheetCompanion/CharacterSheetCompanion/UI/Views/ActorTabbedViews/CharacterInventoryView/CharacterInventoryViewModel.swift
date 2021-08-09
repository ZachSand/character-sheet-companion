//
//  CharacterEquipmentViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterInventoryViewModel: ObservableObject {
    @Published var inventory: InventoryModel

    var itemAttackListener: ItemAttackListener?
    var itemDamageListener: ItemDamageListener?
    var itemConsumeListener: ItemConsumeListener?
    var itemDisplayListener: ItemDisplayListener?
    var itemToolListener: ItemToolListener?

    init(inventory: InventoryModel) {
        self.inventory = inventory
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemConsumeListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemToolListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
    }

    func getCurrency() -> String {
        let currency = inventory.currency
        return "\(currency.copper) Copper, \(currency.silver) Silver, \(currency.electrum) Electrum, \(currency.gold) Gold, \(currency.platinum) Platinum"
    }

    func getInventorySections() -> [InventorySection] {
        [InventorySection(id: "Weapons", inventoryItems: inventory.weapons),
         InventorySection(id: "Equipment", inventoryItems: inventory.equipment),
         InventorySection(id: "Consumables", inventoryItems: inventory.consumables),
         InventorySection(id: "Tools", inventoryItems: inventory.tools),
         InventorySection(id: "Containers", inventoryItems: inventory.containers),
         InventorySection(id: "Loot", inventoryItems: inventory.loot)]
    }

    func rollItemAttack(inventoryItem: InventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemAttackListener {
            let itemAttackRoll = ItemAttackRollModel(actorId: "", itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    if let itemAttackRollResult = attackRollResult {
                        print(itemAttackRollResult)
                    }
                }
            }
        }
    }

    func rollItemDamage(inventoryItem: InventoryItemModel, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener {
            let itemDamageRoll = ItemDamageRollModel(actorId: "", itemId: inventoryItem.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    if let itemDamageRollResult = damageRollResult {
                        print(itemDamageRollResult)
                    }
                }
            }
        }
    }

    func rollItemConsume(inventoryItem: InventoryItemModel, consume: Bool) {
        if let listener = itemConsumeListener {
            let itemConsumeRoll = ItemConsumeRollModel(actorId: "", itemId: inventoryItem.id, consume: consume, result: 0)
            DispatchQueue.main.async {
                listener.rollItemConsume(itemConsumeRoll: itemConsumeRoll) { consumeRollResult in
                    if let itemConsumeRollResult = consumeRollResult {
                        print(itemConsumeRollResult)
                    }
                }
            }
        }
    }

    func rollItemToolRoll(inventoryItem: InventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemToolListener {
            let itemToolRoll = ItemToolRollModel(actorId: "", itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemTool(itemToolRoll: itemToolRoll) { toolRollResult in
                    if let itemToolRollResult = toolRollResult {
                        print(itemToolRollResult)
                    }
                }
            }
        }
    }

    func displayItem(inventoryItem: InventoryItemModel) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: "", itemId: inventoryItem.id)
            DispatchQueue.main.async {
                listener.displayItemCard(displayItem: displayItem)
            }
        }
    }

    func getConsumeText(inventoryItem: InventoryItemModel) -> String {
        if let usageRemaining = inventoryItem.numUsagesRemaining, let useMax = inventoryItem.maxUsages {
            return "This item has \(usageRemaining) of \(useMax) uses remaining. Consuming will remove one use."
        }
        return "This item has no usage data"
    }
}

struct InventorySection: Identifiable, Hashable {
    var id: String
    var inventoryItems: [InventoryItemModel]
}
