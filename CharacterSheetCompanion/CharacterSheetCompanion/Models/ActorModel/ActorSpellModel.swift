//
//  SpellModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorSpellModel: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var spellLevel: Int
    var hasAttack: Bool
    var hasDamage: Bool
    var isHealing: Bool
    var prepared: Bool
    var image: Data?
}

#if DEBUG
    extension ActorSpellModel {
        static let mockedData = [
            ActorSpellModel(
                id: "0",
                name: "Toll the Dead",
                description: "You point at one creature you can see within range, and the sound of a dolorous bell fills the air around it for a moment. The target must succeed on a Wisdom saving throw or take 1d8 necrotic damage. If the target is missing any of its hit points, it instead takes 1d12 necrotic damage.",
                spellLevel: 0,
                hasAttack: false,
                hasDamage: true,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "1",
                name: "Charm Person",
                description: "You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it.",
                spellLevel: 1,
                hasAttack: false,
                hasDamage: false,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "2",
                name: "Acid Arrow",
                description: "A shimmering green arrow streaks toward a target within range and bursts in a spray of acid. Make a ranged spell attack against the target. On a hit, the target takes 4d4 acid damage immediately and 2d4 acid damage at the end of its next turn. On a miss, the arrow splashes the target with acid for half as much of the initial damage and no damage at the end of its next turn.",
                spellLevel: 2,
                hasAttack: true,
                hasDamage: true,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "3",
                name: "Counterspell",
                description: "You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spell's level. On a success, the creature's spell fails and has no effect.",
                spellLevel: 2,
                hasAttack: true,
                hasDamage: false,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "4",
                name: "Polymorph",
                description: "This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points.",
                spellLevel: 4,
                hasAttack: false,
                hasDamage: false,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "5",
                name: "Cone of Cold",
                description: "A blast of cold air erupts from your hands. Each creature in a 60-foot cone must make a Constitution saving throw. A creature takes 8d8 cold damage on a failed save, or half as much damage on a successful one.",
                spellLevel: 5,
                hasAttack: false,
                hasDamage: true,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "6",
                name: "Disintegrate",
                description: "A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force.",
                spellLevel: 6,
                hasAttack: false,
                hasDamage: true,
                isHealing: false,
                prepared: true
            ),
            ActorSpellModel(
                id: "7",
                name: "Teleport",
                description: "This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can't be held or carried by an unwilling creature.",
                spellLevel: 7,
                hasAttack: false,
                hasDamage: false,
                isHealing: false,
                prepared: false
            ),
            ActorSpellModel(
                id: "8",
                name: "Teleport",
                description: "A swirling cloud of smoke shot through with white-hot embers appears in a 20-foot-radius sphere centered on a point within range. The cloud spreads around corners and is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.",
                spellLevel: 8,
                hasAttack: false,
                hasDamage: true,
                isHealing: false,
                prepared: false
            ),
            ActorSpellModel(
                id: "9",
                name: "Mass Heal",
                description: "A flood of healing energy flows from you into injured creatures around you. You restore up to 700 hit points, divided as you choose among any number of creatures that you can see within range. Creatures healed by this spell are also cured of all diseases and any effect making them blinded or deafened. This spell has no effect on undead or constructs.",
                spellLevel: 9,
                hasAttack: false,
                hasDamage: false,
                isHealing: false,
                prepared: false
            ),
        ]
    }
#endif
