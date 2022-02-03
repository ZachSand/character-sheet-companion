//
//  ServerSendEvents.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 9/8/21.
//

import Foundation

struct RECEIVE_EVENTS {
    enum SETUP {
        static let WORLD_USERS = "server:SendSetupWorldUsers"
        static let WORLD_DATA = "server:SendSetupWorldData"
        static let WORLD_USER_AUTH = "server:SendSetupWorldUserAuth"
        static let JOIN_ROOM = "server:SendSetupJoinRoom"
    }

    enum ACTOR {
        static let ATTRIBUTES = "server:SendActorAttributes"
        static let ABILITIES = "server:SendActorAbilities"
        static let SKILLS = "server:SendActorSkills"
        static let SPELL_SLOTS = "server:SendActorSpellSlots"
        static let INVENTORY = "server:SendActorInventory"
        static let DETAILS = "server:SendActorDetails"
        static let CURRENCY = "server:SendActorCurrency"
        static let SPELLS = "server:SendActorSpells"
        static let BASE_DATA = "server:SendActorBaseData"
        static let CLASSES = "server:SendActorClasses"
        static let TRAITS = "server:SendActorTraits"
    }

    enum ROLL {
        static let ABILITY = "server:SendRollAbility"
        static let SKILL = "server:SendRollSkill"
        static let ITEM_ATTACK = "server:SendRollItemAttack"
        static let ITEM_DAMAGE = "server:SendRollItemDamage"
        static let ITEM_CONSUME = "server:SendRollItemConsume"
        static let ITEM_TOOL = "server:SendRollItemTool"
        static let INITIATIVE = "server:SendRollInitiative"
        static let DEATH_SAVE = "server:SendRollDeathSave"
        static let HIT_DIE = "server:SendRollHitDie"
    }

    enum DISPLAY {
        static let CHAT_DATA = "server:SendDisplayChatData"
        static let CHAT_MESSAGE = "server:SendDisplayChatMessage"
    }
}
