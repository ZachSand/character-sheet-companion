//
//  ItemAttackSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemAttackSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var itemAttackSheetVM: ItemAttackSheetViewModel
    @State var inventoryItem: ActorInventoryItemModel
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Roll Attack for " + inventoryItem.name) {
                itemAttackSheetVM.rollItemAttack(inventoryItem: inventoryItem, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}

#if DEBUG
    struct ItemAttackSheetView_Previews: PreviewProvider {
        static var previews: some View {
            ItemAttackSheetView(
                itemAttackSheetVM: ItemAttackSheetViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataWeapons[0]
            )
        }
    }
#endif
