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

    var itemAttackListener: RollItemAttackListener?
    var itemDamageListener: RollItemDamageListener?
    var itemConsumeListener: RollItemConsumeListener?
    var itemDisplayListener: DisplayItemListener?
    var itemToolListener: RollToolListener?
    var inventoryListener: ActorInventoryListener?

    init() {
        do {
            try itemAttackListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDamageListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemConsumeListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemDisplayListener = FoundrySocketIOManager.sharedInstance.getListener()
            try itemToolListener = FoundrySocketIOManager.sharedInstance.getListener()

            try inventoryListener = FoundrySocketIOManager.sharedInstance.getListener()
            inventoryListener?.inventoryPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { model in
                    self.inventory = model
                })
                .store(in: &subscription)
        } catch {}
    }

    func getCurrency() -> String {
        if let actorInventory = inventory {
            let currency = actorInventory.currency
            return "\(currency.copper) Copper, \(currency.silver) Silver, \(currency.electrum) Electrum, \(currency.gold) Gold, \(currency.platinum) Platinum"
        }
        return ""
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

    func rollItemAttack(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemAttackListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemAttackRoll = ItemAttackRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemAttack(attackRoll: itemAttackRoll) { attackRollResult in
                    print(attackRollResult)
                }
            }
        }
    }

    func rollItemDamage(inventoryItem: ActorInventoryItemModel, critical: Bool, versatile: Bool) {
        if let listener = itemDamageListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemDamageRoll = ItemDamageRollModel(actorId: actor.id, itemId: inventoryItem.id, critical: critical, versatile: versatile, result: 0)
            DispatchQueue.main.async {
                listener.rollItemDamage(damageRoll: itemDamageRoll) { damageRollResult in
                    print(damageRollResult)
                }
            }
        }
    }

    func rollItemConsume(inventoryItem: ActorInventoryItemModel, consume: Bool) {
        if let listener = itemConsumeListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemConsumeRoll = ItemConsumeRollModel(actorId: actor.id, itemId: inventoryItem.id, consume: consume, result: 0)
            DispatchQueue.main.async {
                listener.rollItemConsume(itemConsumeRoll: itemConsumeRoll) { consumeRollResult in
                    print(consumeRollResult)
                }
            }
        }
    }

    func rollItemToolRoll(inventoryItem: ActorInventoryItemModel, advantage: Bool, disadvantage: Bool) {
        if let listener = itemToolListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let itemToolRoll = ItemToolRollModel(actorId: actor.id, itemId: inventoryItem.id, advantage: advantage, disadvantage: disadvantage, result: 0)
            DispatchQueue.main.async {
                listener.rollItemTool(itemToolRoll: itemToolRoll) { toolRollResult in
                    print(toolRollResult)
                }
            }
        }
    }

    func displayItem(inventoryItem: ActorInventoryItemModel) {
        if let listener = itemDisplayListener, let actor = FoundrySocketIOManager.sharedInstance.actor {
            let displayItem = ItemDisplayModel(actorId: actor.id, itemId: inventoryItem.id)
            DispatchQueue.main.async {
                listener.displayItemCard(displayItem: displayItem)
            }
        }
    }

    func getConsumeText(inventoryItem: ActorInventoryItemModel) -> String {
        "This item has \(inventoryItem.numUsagesRemaining) of \(inventoryItem.maxUsages) uses remaining. Consuming will remove one use."
    }
}

struct InventorySection: Identifiable, Hashable {
    var id: String
    var inventoryItems: [ActorInventoryItemModel]
}
