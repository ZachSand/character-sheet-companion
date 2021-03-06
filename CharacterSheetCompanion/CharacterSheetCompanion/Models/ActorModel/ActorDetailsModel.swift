//
//  ActorDetails.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import Foundation

struct ActorDetailsModel: Codable, BaseModel {
    var biography: String
    var appearance: String
    var flaws: String
    var bonds: String
    var personalityTraits: String
    var ideals: String

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.ACTOR.DETAILS
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.ACTOR.DETAILS
    }
}

#if DEBUG
    extension ActorDetailsModel {
        static let mockedData = ActorDetailsModel(
            biography: "Almost all of the common people and other folk that one might encounter along the Sword Coast or in the North have one thing in common: they live out their lives without ever traveling more than a few miles from where they were born. You aren’t one of those folk.",
            appearance: "Gender: Male Eyes: Burgundy Luster Height: 5' 5 Faith: Odea, Godddess of Light and Compassion (Air) Hair: Blonde with Red and Shimmering Bronze Highlights. Skin: Dark Grey, with Bright, Silvery, Freckled Skin. Age: 23 Weight: 115",
            flaws: "I consider the adherents of other gods to be deluded innocents at best, or ignorant fools at worst.",
            bonds: "Though I had no choice, I lament having to leave my loved one(s) behind. I hope to see them again one day.",
            personalityTraits: "I begin or end my day with small traditional rituals that are unfamiliar to those around me.",
            ideals: "Reserved. As someone new to these strange lands, I am cautious and respectful in my dealings. (Lawful)"
        )
    }
#endif
