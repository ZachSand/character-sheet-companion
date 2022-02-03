//
//  InventoryItemDamageSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemDamageSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var itemDamageSheetVM: ItemDamageSheetViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)

            Button("Roll Damage for " + inventoryItem.name) {
                itemDamageSheetVM.rollItemDamage(inventoryItem: inventoryItem, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .buttonStyle(ItemDamageButtonStyle())
        }
    }
}

#if DEBUG
    struct ItemDamageSheetView_Previews: PreviewProvider {
        static var previews: some View {
            ItemDamageSheetView(
                itemDamageSheetVM: ItemDamageSheetViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataWeapons[0]
            )
        }
    }
#endif
