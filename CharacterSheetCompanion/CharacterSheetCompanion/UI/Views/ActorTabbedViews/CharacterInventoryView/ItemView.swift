//
//  ItemView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/9/21.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel

    @State var inventoryItem: ActorInventoryItemModel
    @State var isExpanded: Bool
    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false
    @State private var showingConsumableSheet = false
    @State private var showingToolSheet = false

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
            if isExpanded {
                VStack {
                    HStack {
                        Button("Display") {
                            characterInventoryVM.displayItem(inventoryItem: inventoryItem)
                        }

                        if inventoryItem.isTool() {
                            Button("Use Tool") {
                                showingToolSheet.toggle()
                            }.sheet(isPresented: $showingToolSheet, content: {
                                InventoryItemToolSheetView(characterInventoryVM: characterInventoryVM, inventoryItem: inventoryItem)
                            })
                        }

                        if inventoryItem.hasAttack {
                            Button("Attack") {
                                showingAttackSheet.toggle()
                            }
                            .sheet(isPresented: $showingAttackSheet, content: {
                                InventoryItemAttackSheetView(characterInventoryVM: characterInventoryVM, inventoryItem: inventoryItem)
                            })
                        }

                        if inventoryItem.hasDamage {
                            if inventoryItem.isConsumable() {
                                Button("Use") {
                                    showingConsumableSheet.toggle()
                                }
                                .sheet(isPresented: $showingConsumableSheet, content: {
                                    InventoryItemConsumableSheetView(characterInventoryVM: characterInventoryVM, inventoryItem: inventoryItem)
                                })
                            } else {
                                Button("Damage") {
                                    showingDamageSheet.toggle()
                                }
                                .sheet(isPresented: $showingDamageSheet, content: {
                                    InventoryItemDamageSheetView(characterInventoryVM: characterInventoryVM, inventoryItem: inventoryItem)
                                })
                            }
                        }
                    }.buttonStyle(RoundedRectangleButtonStyle())
                    Text(inventoryItem.description).font(.footnote)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

#if DEBUG
    struct ItemView_Previews: PreviewProvider {
        static var previews: some View {
            ItemView(
                characterInventoryVM: CharacterInventoryViewModel(),
                inventoryItem: ActorInventoryItemModel.mockedDataTools[0],
                isExpanded: true
            )
        }
    }
#endif
