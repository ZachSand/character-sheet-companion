//
//  InventoryItemConsumableSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct InventoryItemConsumableSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItem: InventoryItemModel

    @State private var consume = false
    var body: some View {
        VStack {
            Toggle("Consume", isOn: $consume)
            Text(characterInventoryVM.getConsumeText(inventoryItem: inventoryItem)).font(.footnote)
            Button("Consume " + inventoryItem.name) {
                characterInventoryVM.rollItemConsume(inventoryItem: inventoryItem, consume: consume)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()

        }.buttonStyle(RoundedRectangleButtonStyle())
    }
}

#if DEBUG
    struct InventoryItemConsumableSheetView_Previews: PreviewProvider {
        static var previews: some View {
            InventoryItemConsumableSheetView(
                characterInventoryVM: CharacterInventoryViewModel(inventory: InventoryModel.mockedData),
                inventoryItem: InventoryItemModel.mockedDataConsumables[0]
            )
        }
    }
#endif
