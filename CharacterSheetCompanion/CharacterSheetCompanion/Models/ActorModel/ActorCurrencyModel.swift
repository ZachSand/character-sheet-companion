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
        REQUEST_EVENTS.ACTOR.CURRENCY
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.CURRENCY
    }
}

#if DEBUG
    extension ActorCurrencyModel {
        static let mockedData = ActorCurrencyModel(copper: 125, silver: 2000, electrum: 13, gold: 9000, platinum: 400)
    }
#endif
