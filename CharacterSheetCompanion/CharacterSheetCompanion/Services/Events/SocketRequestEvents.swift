//
//  IosEvents.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 9/8/21.
//

import Foundation

struct REQUEST_EVENTS {
    enum SETUP {
        static let JOIN_ROOM = "ios:SetupJoinRoom"
        static let WORLD_USERS = "ios:SetupWorldUsers"
        static let WORLD_DATA = "ios:SetupWorldData"
        static let WORLD_USER_AUTH = "ios:SetupWorldUserAuth"
        static let COMPLETE = "ios:SetupComplete"
    }

    enum ACTOR {
        static let ATTRIBUTES = "ios:ActorAttributes"
        static let ABILITIES = "ios:ActorAbilities"
        static let SKILLS = "ios:ActorSkills"
        static let SPELL_SLOTS = "ios:ActorSpellSlots"
        static let INVENTORY = "ios:ActorInventory"
        static let DETAILS = "ios:ActorDetails"
        static let CURRENCY = "ios:ActorCurrency"
        static let SPELLS = "ios:ActorSpells"
        static let BASE_DATA = "ios:ActorBaseData"
        static let CLASSES = "ios:ActorClasses"
        static let TRAITS = "ios:ActorTraits"
    }

    enum ACTOR_CHANGE {
        static let HEALTH = "ios:ActorChangeHealth"
        static let LONG_REST = "ios:ActorChangeLongRest"
        static let SHORT_REST = "ios:ActorChangeShortRest"
    }

    enum ROLL {
        static let ABILITY = "ios:RollAbility"
        static let SKILL = "ios:RollSkill"
        static let ITEM_ATTACK = "ios:RollItemAttack"
        static let ITEM_DAMAGE = "ios:RollItemDamage"
        static let ITEM_CONSUME = "ios:RollItemConsume"
        static let ITEM_TOOL = "ios:RollItemTool"
        static let INITIATIVE = "ios:RollInitiative"
        static let DEATH_SAVE = "ios:RollDeathSave"
        static let HIT_DIE = "ios:RollHitDie"
    }

    enum DISPLAY {
        static let ITEM = "ios:DisplayItem"
        static let CHAT_DATA = "ios:DisplayChatData"
        static let CHAT_MESSAGE = "ios:DisplayChatMessage"
    }
}
