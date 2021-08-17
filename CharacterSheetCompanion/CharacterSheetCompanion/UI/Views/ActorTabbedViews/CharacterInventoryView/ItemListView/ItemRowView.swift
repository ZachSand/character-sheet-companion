//
//  ItemView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemRowView: View {
    @State var inventoryItem: ActorInventoryItemModel
    @State var isExpanded: Bool

    var body: some View {
        VStack {
            HStack {
                if let imageData = inventoryItem.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .leading)
                } else {
                    Image(systemName: "bag")
                }
                Text(inventoryItem.name).font(.headline)
            }
            if isExpanded {}
        }
        .contentShape(Rectangle())
    }
}

#if DEBUG
    struct ItemRowView_Previews: PreviewProvider {
        static var previews: some View {
            ItemRowView(
                inventoryItem: ActorInventoryItemModel.mockedDataTools[0],
                isExpanded: true
            )
        }
    }
#endif
