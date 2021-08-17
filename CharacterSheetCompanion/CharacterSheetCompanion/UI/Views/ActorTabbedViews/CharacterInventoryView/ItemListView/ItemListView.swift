//
//  ItemListView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import SwiftUI

struct ItemListView: View {
    @State var inventorySection: InventorySection
    @State private var selection: Set<ActorInventoryItemModel> = []

    var body: some View {
        ForEach(inventorySection.inventoryItems) { inventoryItem in
            ItemRowView(
                inventoryItem: inventoryItem,
                isExpanded: self.selection.contains(inventoryItem)
            )
            .onTapGesture { self.selectDeselect(inventoryItem) }
        }
    }

    private func selectDeselect(_ inventoryItem: ActorInventoryItemModel) {
        if selection.contains(inventoryItem) {
            selection.remove(inventoryItem)
        } else {
            selection.insert(inventoryItem)
        }
    }
}
