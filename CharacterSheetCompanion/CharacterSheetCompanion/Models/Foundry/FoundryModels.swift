//
//  FoundryDataModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation

struct FoundryUser: Decodable {
    var userId: String
    var userName: String
    var isActive: Bool
}

extension FoundryUser: Identifiable {
    var id: String { return userId }
}

struct FoundryUserActor: Decodable {
    var actorId: String
    var name: String
}

extension FoundryUserActor: Identifiable {
    var id: String { return actorId }
}

struct FoundryActor: Codable {
    var actor: Actor
}

// MARK: - Actor
struct Actor: Codable {
    var actorData: ActorData
    var actorItems: ActorItems
    var name: String
    var id: String
}

struct ActorItems: Codable {
    var inventory: Inventory
    var spells: [ActorItem]
    var features: Features
}

struct Features: Codable {
    var active: [ActorItem]
    var passive: [ActorItem]
}

struct Inventory: Codable {
    var weapon: [ActorItem]
    var equipment: [ActorItem]
    var consumable: [ActorItem]
    var tool: [ActorItem]
    var backpack: [ActorItem]
    var loot: [ActorItem]
}

// MARK: - ActorData
struct ActorData: Codable {
    var abilities: [String: Ability]
    var attributes: Attributes
    var details: Details
    var traits: Traits
    var currency: Currency
    var skills: [String: Skill]
    var spells: Spells
    var bonuses: Bonuses
    var resources: Resources
    var prof: Int
    var classes: [Class]
    var mod: Int
}

// MARK: - Ability
struct Ability: Codable {
    var value, proficient: Int
    var mod, prof, saveBonus, checkBonus: Int
    var save, dc: Int
    var min: Int?
    var max: Int?
}

// MARK: - Attributes
struct Attributes: Codable {
    var ac: AC
    var hp: AttributesHP
    var attributesInit: Init
    var movement: Movement
    var senses: Senses
    var spellcasting: String
    var death: Death
    var exhaustion: Int
    var inspiration: Bool
    var hd, prof, spelldc: Int
    var encumbrance: Encumbrance

    enum CodingKeys: String, CodingKey {
        case ac, hp
        case attributesInit = "init"
        case movement, senses, spellcasting, death, exhaustion, inspiration, hd, prof, spelldc, encumbrance
    }
}

// MARK: - AC
struct AC: Codable {
    var value: Int
    var label: String?
    var type: String?
}

// MARK: - Init
struct Init: Codable {
    var value, bonus, mod, prof: Int
    var total: Int
}

// MARK: - Death
struct Death: Codable {
    var success, failure: Int
}

// MARK: - Encumbrance
struct Encumbrance: Codable {
    var value, pct: Double
    var max: Int
    var encumbered: Bool?
    var min: Int?
}

// MARK: - AttributesHP
struct AttributesHP: Codable {
    var value, min, max: Int
    var temp, tempmax: Int?
}

// MARK: - Movement
struct Movement: Codable {
    var burrow, climb, fly, swim: Int
    var walk: Int
    var units: String
    var hover: Bool
}

// MARK: - Senses
struct Senses: Codable {
    var darkvision, blindsight, tremorsense, truesight: Int
    var units, special: String
}

// MARK: - Bonuses
struct Bonuses: Codable {
    var mwak, rwak, msak, rsak: Msak
    var abilities: BonusesAbilities
    var spell: SpellBonusDC
}

// MARK: - BonusesAbilities
struct BonusesAbilities: Codable {
    var check, save, skill: String
}

// MARK: - Msak
struct Msak: Codable {
    var attack, damage: String
}

// MARK: - Spell
struct SpellBonusDC: Codable {
    var dc: StringOrInt
}

// MARK: - Class
struct Class: Codable {
    var classDescription: ClassDescription
    var source: String
    var levels: Int
    var subclass, hitDice: String
    var hitDiceUsed: Int
    var saves: [String]
    var skills: Skills
    var spellcasting: Spellcasting
    var name: String

    enum CodingKeys: String, CodingKey {
        case classDescription = "description"
        case source, levels, subclass, hitDice, hitDiceUsed, saves, skills, spellcasting, name
    }
}

// MARK: - ClassDescription
struct ClassDescription: Codable {
    var value, chat: String
    var unidentified: BoolOrString
}

// MARK: - Skills
struct Skills: Codable {
    var number: Int
    var choices, value: [String]
}

// MARK: - Spellcasting
struct Spellcasting: Codable {
    var progression, ability: String
}

// MARK: - Currency
struct Currency: Codable {
    var pp, gp, ep, sp: Int
    var cp: Int
}

// MARK: - Details
struct Details: Codable {
    var biography: Biography
    var alignment, race, background, originalClass: String
    var xp: Encumbrance
    var appearance, trait, ideal, bond, flaw: String
    var gender, height, eyes, skin, hair: String?
    var age, weight: Int?
    var level: Int
}

// MARK: - Biography
struct Biography: Codable {
    var value: String
}

// MARK: - Resources
struct Resources: Codable {
    var primary, secondary, tertiary: Resource
}

// MARK: - Resource
struct Resource: Codable {
    var value, max: Int?
    var sr, lr: Bool
    var label: String?
}

// MARK: - Skill
struct Skill: Codable {
    var value: Int
    var type, label: String?
    var ability: String
    var mod, bonus, prof, total: Int
    var passive: Int
}

// MARK: - Spells
struct Spells: Codable {
    var spell1, spell2, spell3, spell4: Spell
    var spell5, spell6, spell7, spell8: Spell
    var spell9, pact: Spell
    var spell0: Spell0?
}

// MARK: - Pact
struct Spell: Codable {
    var value: Int
    var pactOverride: Bool?
    var max: Int
    var level: Int?

    enum CodingKeys: String, CodingKey {
        case value
        case pactOverride = "override"
        case max, level
    }
}

// MARK: - Spell0
struct Spell0: Codable {
    var value, max: Int
}

// MARK: - Traits
struct Traits: Codable {
    var size: String
    var di, dr, dv, ci: Trait
    var languages, weaponProf, armorProf, toolProf: Trait
    var senses: Senses?
}

// MARK: - ArmorProf
struct Trait: Codable {
    var value: [String]
    var custom: String
}

// MARK: - ActorItem
struct ActorItem: Codable {
    var id, name, type, img: String
    var data: ItemData
    var effects: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, type, img, data, effects
    }
}

// MARK: - DataClass
struct ItemData: Codable {
    var dataDescription: ItemDescription
    var source: String?
    var levels: Int?
    var subclass, hitDice: String?
    var hitDiceUsed: Int?
    var saves: [String]?
    var skills: Skills?
    var spellcasting: Spellcasting?
    var activation: Activation?
    var duration: Duration?
    var target, range: Range?
    var uses: Uses?
    var consume: Consume?
    var ability: StringOrStringArray?
    var actionType: String?
    var attackBonus: StringOrInt?
    var chatFlavor: String?
    var critical: JSONNull?
    var damage: Damage?
    var formula: String?
    var save: Save?
    var requirements: String?
    var recharge: Recharge?
    var quantity: Int?
    var weight, price: StringOrDouble?
    var attuned: Bool?
    var attunement: Int?
    var equipped: Bool?
    var rarity: String?
    var identified: Bool?
    var armor: Armor?
    var hp: DataHP?
    var weaponType: String?
    var properties: [String: Bool]?
    var proficient: BoolOrInt?
    var speed: Speed?
    var strength: StringOrInt?
    var stealth: Bool?
    var consumableType: String?
    var capacity: Capacity?
    var currency: Currency?
    var level: Int?
    var school: String?
    var components: Components?
    var materials: Materials?
    var preparation: Preparation?
    var scaling: Scaling?

    enum CodingKeys: String, CodingKey {
        case dataDescription = "description"
        case source, levels, subclass, hitDice, hitDiceUsed, saves, skills, spellcasting, activation, duration, target, range, uses, consume, ability, actionType, attackBonus, chatFlavor, critical, damage, formula, save, requirements, recharge, quantity, weight, price, attuned, attunement, equipped, rarity, identified, armor, hp, weaponType, properties, proficient, speed, strength, stealth, consumableType, capacity, currency, level, school, components, materials, preparation, scaling
    }
}

// MARK: - Activation
struct Activation: Codable {
    var type: String
    var cost: Int?
    var condition: String
}

// MARK: - Armor
struct Armor: Codable {
    var value: Int?
    var type: String?
    var dex: Int?
}

// MARK: - Capacity
struct Capacity: Codable {
    var type: String?
    var value: Double
    var weightless: Bool
}

// MARK: - Components
struct Components: Codable {
    var value: String
    var vocal, somatic, material, ritual: Bool
    var concentration: Bool
}

// MARK: - Consume
struct Consume: Codable {
    var type: String
    var target: String?
    var amount: Int?
}

// MARK: - Damage
struct Damage: Codable {
    var parts: [[String]]
    var versatile: String?
    var value: String?
}

// MARK: - DataDescription
struct ItemDescription: Codable {
    var value: String
    var unidentified: BoolOrString
}

// MARK: - Duration
struct Duration: Codable {
    var value: IntegerOrStringOrNull
    var units: String
}

// MARK: - DataHP
struct DataHP: Codable {
    var value, max: Int
    var dt: Int?
    var conditions: String
}

// MARK: - Materials
struct Materials: Codable {
    var value: String
    var consumed: Bool
    var cost, supply: Int
}

// MARK: - Preparation
struct Preparation: Codable {
    var mode: String
    var prepared: Bool
}

// MARK: - Range
struct Range: Codable {
    var value: StringOrInt?
    var long: IntegerOrStringOrNull?
    var units: String?
    var type: String?
    var width: Int?
}

// MARK: - Recharge
struct Recharge: Codable {
    var value: Int?
    var charged: Bool
}

// MARK: - Save
struct Save: Codable {
    var ability: String
    var dc: Int?
    var scaling: String
}

// MARK: - Scaling
struct Scaling: Codable {
    var mode, formula: String
}

// MARK: - Speed
struct Speed: Codable {
    var value: Int?
    var conditions: String
}

// MARK: - Uses
struct Uses: Codable {
    var value: Int?
    var max: IntegerOrStringOrNull
    var per: String?
    var autoDestroy, autoUse: Bool?
}

enum BoolOrString: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(BoolOrString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BoolOrString"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum IntegerOrStringOrNull: Codable {
    case integer(Int)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(IntegerOrStringOrNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IntegerOrStringOrNull"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum StringOrStringArray: Codable {
    case string(String)
    case stringArray([String])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Ability.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StringOrStringArray"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum BoolOrInt: Codable {
    case bool(Bool)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        throw DecodingError.typeMismatch(BoolOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BoolOrInt"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

enum StringOrInt: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StringOrInt"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum StringOrDouble: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StringOrDouble.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StringOrDouble"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Encode/decode helpers

@objcMembers class JSONNull: NSObject, Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    override public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

@objcMembers class JSONAny: NSObject, Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
