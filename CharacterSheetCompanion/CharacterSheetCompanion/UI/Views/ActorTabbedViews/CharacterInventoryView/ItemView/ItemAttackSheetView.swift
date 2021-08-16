//
//  ItemAttackSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct InventoryItemAttackSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Roll Attack for " + inventoryItem.name) {
                characterInventoryVM.rollItemAttack(inventoryItem: inventoryItem, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}

#if DEBUG
    struct InventoryItemAttackSheetView_Previews: PreviewProvider {
        static var previews: some View {
            InventoryItemAttackSheetView(
                characterInventoryVM: CharacterInventoryViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataWeapons[0]
            )
        }
    }
#endif
