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
    
    // Closuers to use inside of the closure of socket.on(..) as a wrapper
    var socketConnectionCallback: ((Bool)->Void)?
    var usersCallback: (([FoundryUser]?)->Void)?
    var userActorsCallback: (([FoundryUserActor]?)->Void)?
    var actorCallback: ((FoundryActor?)->Void)?
    var abilityRollCallback: ((AbilityRollModel?)->Void)?
    var skillRollCallback: ((SkillRollModel?)->Void)?
    
    func socketConnect(completionHandler: @escaping (Bool) -> Void) {
        socket.connect()
        socketConnectionCallback = completionHandler
    }
    
    func getUsers(completionHandler: @escaping ([FoundryUser]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USERS)
        usersCallback = completionHandler
    }
    
    func getUserActors(userId: String, completionHandler: @escaping ([FoundryUserActor]?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_USER_ACTORS, userId)
        userActorsCallback = completionHandler
    }
    
    func getActorData(actorId: String, completionHandler: @escaping (FoundryActor?) -> Void) {
        socket.emit(SocketEvents.IOS.REQUEST_FOUNDRY_ACTOR_DATA, actorId)
        actorCallback = completionHandler
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
