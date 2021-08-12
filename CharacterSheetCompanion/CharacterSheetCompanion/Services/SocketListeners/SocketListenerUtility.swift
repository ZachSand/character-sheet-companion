//
//  SocketEventUtility.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Foundation

struct SocketListenerUtility {
    static let jsonDecoder = JSONDecoder()

    static func parseSocketEventData<FoundryModel: Decodable>(_ data: [Any]) throws -> FoundryModel {
        if let socketData = data[0] as? String, let json = socketData.data(using: .utf8) {
            return try parseModel(json)
        }
        throw FoundryJSONError.errorMessage("Unable to unwrap data")
    }

    static func parseSocketEventDataArray<FoundryModel: Decodable>(_ data: [Any]) throws -> [FoundryModel] {
        if let socketData = data[0] as? String, let json = socketData.data(using: .utf8) {
            return try parseModel(json)
        }
        throw FoundryJSONError.errorMessage("Unable to unwrap data")
    }

    static func parseModel<FoundryModel: Decodable>(_ json: Data) throws -> FoundryModel {
        var errorMessage: String
        do {
            return try jsonDecoder.decode(FoundryModel.self, from: json)
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
