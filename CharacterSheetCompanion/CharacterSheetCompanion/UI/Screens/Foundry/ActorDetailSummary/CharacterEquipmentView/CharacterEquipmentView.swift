//
//  CharacterEquipmentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterInventoryView: View {
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor
        characterInventoryVM = CharacterInventoryViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            List(characterInventoryVM.getInventorySummary(), children: \.items) {itemSummary in
                Text(itemSummary.id)
            }
        }
    }
}
