//
//  SocketEventUtility.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Foundation

struct SocketListenerUtility {
    static let jsonDecoder = JSONDecoder()

    static func parseSocketEventData<FoundryModel: Decodable>(_ data: [Any]) throws -> FoundryModel? {
        let data = data[0] as? String
        var foundryModel: FoundryModel?
        if let rollData = data {
            if let json = rollData.data(using: .utf8) {
                try parseFoundryModel(&foundryModel, json)
            }
        }
        return foundryModel
    }

    static func parseSocketEventDataArray<FoundryModel: Decodable>(_ data: [Any]) throws -> [FoundryModel]? {
        let data = data[0] as? String
        var foundryModel: [FoundryModel]?
        if let rollData = data {
            if let json = rollData.data(using: .utf8) {
                try parseFoundryModel(&foundryModel, json)
            }
        }
        return foundryModel
    }

    static func parseFoundryModel<FoundryModel: Decodable>(_ foundryModel: inout FoundryModel?, _ json: Data) throws {
        var errorMessage: String
        do {
            foundryModel = try jsonDecoder.decode(FoundryModel.self, from: json)
        } catch let DecodingError.keyNotFound(key, context) {
            errorMessage = context.codingPath.description
            errorMessage += "could not find key \(key) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch let DecodingError.valueNotFound(type, context) {
            errorMessage = context.codingPath.description
            errorMessage += "could not find type \(type) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch let DecodingError.typeMismatch(type, context) {
            errorMessage = context.codingPath.description
            errorMessage += "type mismatch for type \(type) in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch let DecodingError.dataCorrupted(context) {
            errorMessage = context.codingPath.description
            errorMessage += "data found to be corrupted in JSON: \(context.debugDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        } catch let error as NSError {
            errorMessage = "Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)"
            throw FoundryJSONError.errorMessage(errorMessage)
        }
    }
}
