//
//  BaseRollModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/26/21.
//

import Foundation

protocol BaseRollModel: BaseModel {
    var actorId: String { get set }
    var result: Int { get set }
}
