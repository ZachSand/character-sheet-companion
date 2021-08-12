//
//  CharacterEquipmentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterInventoryView: View {
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State private var selection: Set<ActorInventoryItemModel> = []

    var body: some View {
        VStack {
            Text("Inventory")
            HStack {
                Image(systemName: "dollarsign.square")
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .leading)
                Text(characterInventoryVM.getCurrency()).font(.footnote)
            }
            List {
                ForEach(characterInventoryVM.getInventorySections()) { inventorySection in
                    Section(header: Text(inventorySection.id)) {
                        ForEach(inventorySection.inventoryItems) { inventoryItem in
                            ItemView(characterInventoryVM: characterInventoryVM, inventoryItem: inventoryItem, isExpanded: self.selection.contains(inventoryItem))
                                .onTapGesture { self.selectDeselect(inventoryItem) }
                        }
                    }
                }
            }
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

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color.yellow.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#if DEBUG
    struct CharacterInventoryView_Previews: PreviewProvider {
        static let characterInventoryVM: CharacterInventoryViewModel = {
            let characterInventoryVM = CharacterInventoryViewModel()
            characterInventoryVM.inventory = ActorInventoryModel.mockedData
            return characterInventoryVM
        }()

        static var previews: some View {
            CharacterInventoryView(characterInventoryVM: characterInventoryVM)
        }
    }
#endif
