//
//  CharacterEquipmentViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import Foundation

class CharacterInventoryViewModel: ObservableObject {
    @Published var foundryActor: ActorDataModel
    var itemAttackListener: ItemAttackListener?
    var itemDamageListener: ItemDamageListener?
    var itemConsumeListener: ItemConsumeListener?
    var itemDisplayListener: ItemDisplayListener?
    var itemToolListener: ItemToolListener?

    init(foundryActor: ActorDataModel) {
        self.foundryActor = foundryActor
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemConsumeListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemToolListener = FoundrySocketIOManager.sharedInstance.getListener()
        } catch {}
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

    func getCurrency() -> String {
        let currency = foundryActor.actor.actorData.currency
        return "Currency: \(currency.cp) Copper, \(currency.sp) Silver, \(currency.ep) Electrum, \(currency.gp) Gold, \(currency.pp) Platinum"
    }

    func isConsumable(inventoryItemSummary: InventoryItemSummary) -> Bool {
        inventoryItemSummary.type == "consumable"
    }

    func rollItemAttack(inventoryItemSummary: InventoryItemSummary, advantage: Bool, disadvantage: Bool) {
        if let listener = itemAttackListener {
            let itemAttackRoll = ItemAttackRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    if let itemAttackRollResult = attackRollResult {
                        print(itemAttackRollResult)
                    }
                }
            }
        }
    }

    func rollItemDamage(inventoryItemSummary: InventoryItemSummary, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener {
            let itemDamageRoll = ItemDamageRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    if let itemDamageRollResult = damageRollResult {
                        print(itemDamageRollResult)
                    }
                }
            }
        }
    }

    func rollItemConsume(inventoryItemSummary: InventoryItemSummary, consume: Bool) {
        if let listener = itemConsumeListener {
            let itemConsumeRoll = ItemConsumeRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, consume: consume, result: 0)
            DispatchQueue.main.async {
                listener.rollItemConsume(itemConsumeRoll: itemConsumeRoll) { consumeRollResult in
                    if let itemConsumeRollResult = consumeRollResult {
                        print(itemConsumeRollResult)
                    }
                }
            }
        }
    }

    func rollItemToolRoll(inventoryItemSummary: InventoryItemSummary, advantage: Bool, disadvantage: Bool) {
        if let listener = itemToolListener {
            let itemToolRoll = ItemToolRollModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemTool(itemToolRoll: itemToolRoll) { toolRollResult in
                    if let itemToolRollResult = toolRollResult {
                        print(itemToolRollResult)
                    }
                }
            }
        }
    }

    func displayItem(inventoryItemSummary: InventoryItemSummary) {
        if let listener = itemDisplayListener {
            let displayItem = ItemDisplayModel(actorId: foundryActor.actor.id, itemId: inventoryItemSummary.id)
            DispatchQueue.main.async {
                listener.displayItemCard(displayItem: displayItem)
            }
        }
    }

    func getConsumeText(inventoryItemSummary: InventoryItemSummary) -> String {
        if let usageRemaining = inventoryItemSummary.useRemaining, let useMax = inventoryItemSummary.useMax {
            return "This item has \(usageRemaining) of \(useMax) uses remaining. Consuming will remove one use."
        }
        return "This item has no usage data"
    }

    private func getWeapons() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.weapon)
    }

    private func getEquipment() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.equipment)
    }

    private func getConsumables() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.consumable)
    }

    private func getTools() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.tool)
    }

    private func getContainers() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.backpack)
    }

    private func getLoot() -> [InventoryItemSummary] {
        getItemSummary(itemData: foundryActor.actor.actorItems.inventory.loot)
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
                    price: item.data.price
                ))
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

    static func == (lhs: InventoryItemSummary, rhs: InventoryItemSummary) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
