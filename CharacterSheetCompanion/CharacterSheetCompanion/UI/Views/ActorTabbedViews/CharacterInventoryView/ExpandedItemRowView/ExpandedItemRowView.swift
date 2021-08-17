//
//  ExpandedItemRowView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/17/21.
//

import SwiftUI

struct ExpandedItemRowView: View {
    @ObservedObject var expandedItemRowVM: ExpandedItemRowViewModel
    @State var inventoryItem: ActorInventoryItemModel

    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false
    @State private var showingConsumableSheet = false
    @State private var showingToolSheet = false

    var body: some View {
        VStack {
            HStack {
                Button("Display") {
                    expandedItemRowVM.displayItem(inventoryItem: inventoryItem)
                }.buttonStyle(ItemDisplayButtonStyle())

                if inventoryItem.isTool() {
                    Button("Use Tool") {
                        showingToolSheet.toggle()
                    }.sheet(isPresented: $showingToolSheet, content: {
                        ItemToolSheetView(itemToolSheetVM: ItemToolSheetViewModel(), inventoryItem: inventoryItem)
                    })
                }

                if inventoryItem.hasAttack {
                    Button("Attack") {
                        showingAttackSheet.toggle()
                    }
                    .sheet(isPresented: $showingAttackSheet, content: {
                        ItemAttackSheetView(itemAttackSheetVM: ItemAttackSheetViewModel(), inventoryItem: inventoryItem)
                    })
                }

                if inventoryItem.hasDamage {
                    if inventoryItem.isConsumable() {
                        Button("Use") {
                            showingConsumableSheet.toggle()
                        }
                        .sheet(isPresented: $showingConsumableSheet, content: {
                            ItemConsumableSheetView(itemConsumableSheetVM: ItemConsumableSheetViewModel(), inventoryItem: inventoryItem)
                        })
                    } else {
                        Button("Damage") {
                            showingDamageSheet.toggle()
                        }
                        .sheet(isPresented: $showingDamageSheet, content: {
                            ItemDamageSheetView(itemDamageSheetVM: ItemDamageSheetViewModel(), inventoryItem: inventoryItem)
                        })
                    }
                }
            }

            Text(inventoryItem.description).font(.footnote)
        }
    }
}
