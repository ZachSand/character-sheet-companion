//
//  InventoryItemConsumableSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemConsumableSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var itemConsumableSheetVM: ItemConsumableSheetViewModel
    @State var inventoryItem: ActorInventoryItemModel

    @State private var consume = false
    var body: some View {
        VStack {
            Toggle("Consume", isOn: $consume)
            Text(itemConsumableSheetVM.getConsumeText(inventoryItem: inventoryItem)).font(.footnote)
            Button("Consume " + inventoryItem.name) {
                itemConsumableSheetVM.rollItemConsume(inventoryItem: inventoryItem, consume: consume)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()

        }.buttonStyle(ItemDamageButtonStyle())
    }
}

#if DEBUG
    struct InventoryItemConsumableSheetView_Previews: PreviewProvider {
        static var previews: some View {
            ItemConsumableSheetView(
                itemConsumableSheetVM: ItemConsumableSheetViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataConsumables[0]
            )
        }
    }
#endif
