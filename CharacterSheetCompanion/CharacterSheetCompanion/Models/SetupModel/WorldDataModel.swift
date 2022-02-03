//
//  WorldDataModel.swift
//  FoundryCharacterCompanion
//
//  Created by Zachary Sanders on 7/23/21.
//

import Foundation

struct WorldDataModel: BaseModel {
    var id: String
    var title: String
    var version: String
    var coreVersion: String
    var system: String
    var description: String

    static func getRequestEvent() -> String {
        REQUEST_EVENTS.SETUP.WORLD_DATA
    }

    static func getReceiveEvent() -> String {
        RECEIVE_EVENTS.SETUP.WORLD_DATA
    }
}

extension WorldDataModel {
    static let mockedData = WorldDataModel(
        id: "exandria",
        title: "Exandria",
        version: "1.9.2",
        coreVersion: "8.5.7",
        system: "dnd5e",
        description: "According to the creation myth believed by followers of the Luxon, a single Light emerged from the darkness at the creation point of the universe. Other lights formed around this Light, but those lights settled as stars; the single Light (which was later called the Luxon) resisted that urge to burn and instead traveled, seeking self-knowledge.[3] The Luxon traveled without much comprehension, knowing only that they were light in the darkness, and occasionally passed other things of light.[4] The Luxon, having noticed a particular lonely planet, began to embrace the world and gave their light to the planet, cracking the surface and giving it fiery life. The elemental chaos gave birth to titans called Primordials, and they erupted and fought each other[3] and the Luxon.[5] Finding no consciousness in the elemental chaos and seeing the Primordials' souls being lost to the darkness beyond as they killed each other, the Luxon broke into scattered Luxon beacons that would enact a cycle of rebirth for those who were bound to their light, in hopes that those beings would gradually learn and mature, and one day something would find and reassemble the Luxon, at which point the Luxon would ask them \"What am I, and what is my purpose?\""
    )
}
