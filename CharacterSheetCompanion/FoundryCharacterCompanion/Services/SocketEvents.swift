//
//  SocketEvents.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/9/21.
//

import Foundation

struct SocketEvents {
    struct IOS {
        static let JOIN_ROOM = "ios:join"
        static let JOINED_ROOM = "ios:joinedRoom"
        static let REQUEST_FOUNDRY_USERS = "ios:requestFoundryUsers"
        static let REQUEST_FOUNDRY_USER_ACTORS = "ios:requestFoundryUserActor"
        static let REQUEST_FOUNDRY_ACTOR_DATA = "ios:requestFoundryActorData"
        static let REQUEST_FOUNDRY_ABILITY_ROLL = "ios:requestFoundryAbilityRoll"
        static let REQUEST_FOUNDRY_SKILL_ROLL = "ios:requestFoundrySkillRoll"
        static let REQUEST_FOUNDRY_ITEM_ATTACK_ROLL = "ios:requestFoundryItemAttackRoll"
        static let REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL = "ios:requestFoundryItemDamageRoll"
        static let REQUEST_FOUNDRY_ITEM_CONSUME_ROLL = "ios:requestFoundryItemConsumeRoll"
        static let REQUEST_FOUNDRY_ITEM_TOOL_ROLL = "ios:requestFoundryItemToolRoll"
        static let REQUEST_FOUNDRY_DISPLAY_ITEM = "ios:requestFoundryDisplayItem"
        static let REQUEST_FOUNDRY_WORLD_DATA = "ios:requestFoundryWorldData"
    }
    struct SERVER {
        static let SEND_FOUNDRY_USERS = "server:sendFoundryUsers"
        static let SEND_FOUNDRY_USER_ACTORS = "server:sendFoundryUserActor"
        static let SEND_FOUNDRY_ACTOR_DATA = "server:sendFoundryActorData"
        static let SEND_FOUNDRY_ABILITY_ROLL = "server:sendFoundryAbilityRoll"
        static let SEND_FOUNDRY_SKILL_ROLL = "server:sendFoundrySkillRoll"
        static let SEND_FOUNDRY_ITEM_ATTACK_ROLL = "server:sendFoundryItemAttackRoll"
        static let SEND_FOUNDRY_ITEM_DAMAGE_ROLL = "server:sendFoundryItemDamageRoll"
        static let SEND_FOUNDRY_ITEM_CONSUME_ROLL = "server:sendFoundryItemConsumeRoll"
        static let SEND_FOUNDRY_ITEM_TOOL_ROLL = "server:sendFoundryItemToolRoll"
        static let SEND_FOUNDRY_WORLD_DATA = "server:sendFoundryWorldData"
    }
}
