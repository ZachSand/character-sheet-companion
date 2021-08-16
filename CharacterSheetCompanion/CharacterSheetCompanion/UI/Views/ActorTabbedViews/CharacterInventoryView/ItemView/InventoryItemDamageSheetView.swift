//
//  InventoryItemDamageSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct InventoryItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)

            Button("Roll Damage for " + inventoryItem.name) {
                characterInventoryVM.rollItemDamage(inventoryItem: inventoryItem, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .buttonStyle(RoundedRectangleButtonStyle())
        }
    }
}

#if DEBUG
    struct InventoryItemDamageSheetView_Previews: PreviewProvider {
        static var previews: some View {
            InventoryItemDamageSheetView(
                characterInventoryVM: CharacterInventoryViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataWeapons[0]
            )
        }
    }
#endif
