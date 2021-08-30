//
//  CurrencyModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorCurrencyModel: Codable, BaseModel {
    var copper: Int
    var silver: Int
    var electrum: Int
    var gold: Int
    var platinum: Int

    static func getRequestEvent() -> String {
        SocketEvents.IOS.ACTOR.REQUEST_ACTOR_CURRENCY
    }

    static func getReceiveEvent() -> String {
        SocketEvents.SERVER.ACTOR.SEND.SEND_ACTOR_CURRENCY
    }
}

extension SocketEvents.IOS.ACTOR {
    static let REQUEST_ACTOR_CURRENCY = "ios:requestActorCurrency"
}

extension SocketEvents.SERVER.ACTOR.SEND {
    static let SEND_ACTOR_CURRENCY = "server:sendActorCurrency"
}

#if DEBUG
    extension ActorCurrencyModel {
        static let mockedData = ActorCurrencyModel(copper: 125, silver: 2000, electrum: 13, gold: 9000, platinum: 400)
    }
#endif
