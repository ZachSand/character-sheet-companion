//
//  FoundryCompanionServerSocketManager.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/2/21.
//

import Foundation
import SocketIO

class FoundrySocketIOManager: NSObject {
    
    static let sharedInstance = FoundrySocketIOManager()
    
    let manager: SocketManager!
    let jsonDecoder: JSONDecoder!
    let jsonEncoder: JSONEncoder!
    let socket:SocketIOClient!
    
    override init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .compress])
        jsonDecoder = JSONDecoder()
        jsonEncoder = JSONEncoder()
        socket = manager.defaultSocket;
        super.init()
        addSocketHandlers();
       
    }
    
    // ID of the SocketIO room that should be joined
    var roomId:String!
    
    // Closures to use inside of the closure of socket.on(..) as a wrapper
    var socketConnectionCallback: ((Bool)->Void)?
    var usersCallback: (([UserModel]?)->Void)?
    var userActorsCallback: (([UserActorModel]?)->Void)?
    var actorCallback: ((ActorModel?)->Void)?
    var abilityRollCallback: ((AbilityRollModel?)->Void)?
    var skillRollCallback: ((SkillRollModel?)->Void)?
    var itemAttackRollCallback: ((ItemAttackRollModel?)->Void)?
    var itemDamageRollCallback: ((ItemDamageRollModel?)->Void)?
    var itemConsumeRollCallback: ((ItemConsumeRollModel?)->Void)?
    var itemToolRollCallback: ((ItemToolRollModel?)->Void)?
    var worldDataCallback: ((WorldDataModel?)->Void)?
    var initiativeRollCallback: ((InitiativeRollModel?)->Void)?
    
    
    func socketConnect(completionHandler: @escaping (Bool) -> Void) {
        socket.connect()
        socketConnectionCallback = completionHandler
    }
    
    func getUsers(completionHandler: @escaping ([UserModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USERS)
        usersCallback = completionHandler
    }
    
    func getUserActors(completionHandler: @escaping ([UserActorModel]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USER_ACTORS)
        userActorsCallback = completionHandler
    }
    
    func getActorData(actorId: String, completionHandler: @escaping (ActorModel?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ACTOR_DATA, actorId)
        actorCallback = completionHandler
    }
    
    func getWorldData(completionHandler: @escaping (WorldDataModel?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_WORLD_DATA)
        worldDataCallback = completionHandler
    }
    
    func rollAbility(abilityRoll: AbilityRollModel, completionHandler: @escaping (AbilityRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(abilityRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ABILITY_ROLL, json)
                abilityRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollSkill(skillRoll: SkillRollModel, completionHandler: @escaping (SkillRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(skillRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_SKILL_ROLL, json)
                skillRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollItemAttack(attackRoll: ItemAttackRollModel, completionHandler: @escaping (ItemAttackRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(attackRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_ATTACK_ROLL, json)
                itemAttackRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollItemDamage(damageRoll: ItemDamageRollModel, completionHandler: @escaping (ItemDamageRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(damageRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_DAMAGE_ROLL, json)
                itemDamageRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollItemConsume(itemConsumeRoll: ItemConsumeRollModel, completionHandler: @escaping (ItemConsumeRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(itemConsumeRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_CONSUME_ROLL, json)
                itemConsumeRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollItemTool(itemToolRoll: ItemToolRollModel, completionHandler: @escaping (ItemToolRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(itemToolRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ITEM_TOOL_ROLL, json)
                itemToolRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func rollInitiative(initiativeRoll: InitiativeRollModel, completionHandler: @escaping (InitiativeRollModel?) -> Void) {
        do {
            let jsonData = try jsonEncoder.encode(initiativeRoll)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_INITIATIVE_ROLL, json)
                initiativeRollCallback = completionHandler
            }
        } catch {
            
        }
    }
    
    func displayItemCard(displayItem: ItemDisplayModel) {
        do {
            let jsonData = try jsonEncoder.encode(displayItem)
            if let json = String(data: jsonData, encoding: .utf8) {
                socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_DISPLAY_ITEM, json)
            }
        } catch {
            
        }
    }
    
    private func addSocketHandlers() {
        socket.on(clientEvent: .connect) {data, ack in
            self.socket.emit(SocketEvents.IOS.JOIN_ROOM, self.roomId)
        }
        
        socket.on(SocketEvents.IOS.JOINED_ROOM) {data, ack in
            self.socketConnectionCallback?(true)
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_USERS) {data, ack in
            do {
                try self.usersCallback?(self.parseSocketEventDataArray(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_USER_ACTORS) {data, ack in
            do {
                try self.userActorsCallback?(self.parseSocketEventDataArray(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ACTOR_DATA) {data, ack in
            do {
                try self.actorCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ABILITY_ROLL) {data, ack in
            do {
                try self.abilityRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_SKILL_ROLL) {data, ack in
            do {
                try self.skillRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_ATTACK_ROLL) {data, ack in
            do {
                try self.itemAttackRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_DAMAGE_ROLL) {data, ack in
            do {
                try self.itemDamageRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
            
        socket.on(SocketEvents.SERVER.SEND_INITIATIVE_ROLL) {data, ack in
            do {
                try self.initiativeRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_WORLD_DATA) {data, ack in
            do {
                try self.worldDataCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_CONSUME_ROLL) {data, ack in
            do {
                try self.itemConsumeRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
        
        socket.on(SocketEvents.SERVER.SEND_FOUNDRY_ITEM_TOOL_ROLL) {data, ack in
            do {
                try self.itemToolRollCallback?(self.parseSocketEventData(data))
            } catch FoundryJSONError.errorMessage(let errorMessage) {
                print(errorMessage)
            } catch {
                print(error)
            }
        }
    }
    
    private func parseSocketEventDataArray<FoundryModel: Decodable>(_ data: [Any]) throws -> [FoundryModel]? {
        let data = data[0] as? String
        var foundryModel: [FoundryModel]?
        if let rollData = data {
            if let json = rollData.data(using: .utf8) {
                try parseFoundryModel(&foundryModel, json)
            }
        }
        return foundryModel
    }
    
    private func parseSocketEventData<FoundryModel: Decodable>(_ data: [Any]) throws -> FoundryModel? {
        let data = data[0] as? String
        var foundryModel: FoundryModel?
        if let rollData = data {
            if let json = rollData.data(using: .utf8) {
                try parseFoundryModel(&foundryModel, json)
            }
        }
        return foundryModel
    }
    
    private func parseFoundryModel<FoundryModel: Decodable>(_ foundryModel: inout FoundryModel?, _ json: Data) throws {
        var errorMessage: String
        do {
            foundryModel = try self.jsonDecoder.decode(FoundryModel.self, from: json)
        } catch DecodingError.keyNotFound(let key, let context) {
            errorMessage = context.codingPath.description
            errorMessage += "could not find key \(key) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch DecodingError.valueNotFound(let type, let context) {
            errorMessage = context.codingPath.description
            errorMessage += "could not find type \(type) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch DecodingError.typeMismatch(let type, let context) {
            errorMessage = context.codingPath.description
            errorMessage += "type mismatch for type \(type) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch DecodingError.dataCorrupted(let context) {
            errorMessage = context.codingPath.description
            errorMessage += "data found to be corrupted in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch let error as NSError {
            errorMessage = "Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        }
    }
}

enum FoundryJSONError: Error {
    case errorMessage(String)
}
