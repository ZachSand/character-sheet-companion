//
//  InventoryItemToolSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemToolSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var itemToolSheetVM: ItemToolSheetViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Use " + inventoryItem.name) {
                itemToolSheetVM.rollItemToolRoll(inventoryItem: inventoryItem, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}

#if DEBUG
    struct ItemToolSheetView_Previews: PreviewProvider {
        static var previews: some View {
            ItemToolSheetView(
                itemToolSheetVM: ItemToolSheetViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataTools[0]
            )
        }
    }
#endif
