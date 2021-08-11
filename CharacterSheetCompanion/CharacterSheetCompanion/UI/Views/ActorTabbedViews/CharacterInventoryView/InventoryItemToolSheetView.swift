//
//  InventoryItemToolSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct InventoryItemToolSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Use " + inventoryItem.name) {
                characterInventoryVM.rollItemToolRoll(inventoryItem: inventoryItem, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}

#if DEBUG
    struct InventoryItemToolSheetView_Previews: PreviewProvider {
        static var previews: some View {
            InventoryItemToolSheetView(
                characterInventoryVM: CharacterInventoryViewModel(inventory: ActorInventoryModel.mockedData),
                inventoryItem: ActorInventoryItemModel.mockedDataTools[0]
            )
        }
    }
#endif
