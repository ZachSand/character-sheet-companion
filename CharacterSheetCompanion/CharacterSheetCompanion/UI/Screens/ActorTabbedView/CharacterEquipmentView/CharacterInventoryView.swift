//
//  CharacterEquipmentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterInventoryView: View {
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State private var selection: Set<InventoryItemSummary> = []
    var foundryActor: ActorModel

    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterInventoryVM = CharacterInventoryViewModel(foundryActor: foundryActor)
    }

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
                ForEach(characterInventoryVM.getInventoryCategories()) { inventoryCategory in
                    Section(header: Text(inventoryCategory.id)) {
                        ForEach(inventoryCategory.items) { inventoryItemSummary in
                            ItemView(characterInventoryVM: characterInventoryVM, inventoryItemSummary: inventoryItemSummary, isExpanded: self.selection.contains(inventoryItemSummary))
                                .onTapGesture { self.selectDeselect(inventoryItemSummary) }
                        }
                    }
                }
            }
        }
    }

    private func selectDeselect(_ inventoryItemSummary: InventoryItemSummary) {
        if selection.contains(inventoryItemSummary) {
            selection.remove(inventoryItemSummary)
        } else {
            selection.insert(inventoryItemSummary)
        }
    }
}

struct ItemView: View {
    var characterInventoryVM: CharacterInventoryViewModel
    let inventoryItemSummary: InventoryItemSummary
    let isExpanded: Bool
    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false
    @State private var showingConsumableSheet = false
    @State private var showingToolSheet = false

    var body: some View {
        VStack {
            HStack {
                if let imageData = Data(base64Encoded: inventoryItemSummary.img) {
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .leading)
                    }
                }
                Text(inventoryItemSummary.name).font(.headline)
            }
            if isExpanded {
                VStack {
                    HStack {
                        Button("Display") {
                            characterInventoryVM.displayItem(inventoryItemSummary: inventoryItemSummary)
                        }

                        if inventoryItemSummary.type == "tool" {
                            Button("Use Tool") {
                                showingToolSheet.toggle()
                            }.sheet(isPresented: $showingToolSheet, content: {
                                InventoryItemToolSheetView(characterInventoryVM: characterInventoryVM, inventoryItemSummary: inventoryItemSummary)
                            })
                        }

                        if characterInventoryVM.hasAttack(inventoryItemSummary: inventoryItemSummary) {
                            Button("Attack") {
                                showingAttackSheet.toggle()
                            }
                            .sheet(isPresented: $showingAttackSheet, content: {
                                InventoryItemAttackSheetView(characterInventoryVM: characterInventoryVM, inventoryItemSummary: inventoryItemSummary)
                            })
                        }

                        if inventoryItemSummary.hasDamage {
                            if characterInventoryVM.isConsumable(inventoryItemSummary: inventoryItemSummary) {
                                Button("Use") {
                                    showingConsumableSheet.toggle()
                                }
                                .sheet(isPresented: $showingConsumableSheet, content: {
                                    InventoryItemConsumableSheetView(characterInventoryVM: characterInventoryVM, inventoryItemSummary: inventoryItemSummary)
                                })
                            } else {
                                Button("Damage") {
                                    showingDamageSheet.toggle()
                                }
                                .sheet(isPresented: $showingDamageSheet, content: {
                                    InventoryItemDamageSheetView(characterInventoryVM: characterInventoryVM, inventoryItemSummary: inventoryItemSummary)
                                })
                            }
                        }
                    }.buttonStyle(RoundedRectangleButtonStyle())
                    Text(inventoryItemSummary.description).font(.footnote)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct InventoryItemAttackSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItemSummary: InventoryItemSummary
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Roll Attack for " + inventoryItemSummary.name) {
                characterInventoryVM.rollItemAttack(inventoryItemSummary: inventoryItemSummary, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}

struct InventoryItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItemSummary: InventoryItemSummary
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)

            Button("Roll Damage for " + inventoryItemSummary.name) {
                characterInventoryVM.rollItemDamage(inventoryItemSummary: inventoryItemSummary, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .buttonStyle(RoundedRectangleButtonStyle())
        }
    }
}

struct InventoryItemConsumableSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItemSummary: InventoryItemSummary

    @State private var consume = false
    var body: some View {
        VStack {
            Toggle("Consume", isOn: $consume)
            Text(characterInventoryVM.getConsumeText(inventoryItemSummary: inventoryItemSummary)).font(.footnote)
            Button("Consume " + inventoryItemSummary.name) {
                characterInventoryVM.rollItemConsume(inventoryItemSummary: inventoryItemSummary, consume: consume)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()

        }.buttonStyle(RoundedRectangleButtonStyle())
    }
}

struct InventoryItemToolSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel
    @State var inventoryItemSummary: InventoryItemSummary
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        VStack {
            Toggle("Advantage", isOn: $advantage)
            Toggle("Disadvantage", isOn: $disadvantage)

            Button("Use " + inventoryItemSummary.name) {
                characterInventoryVM.rollItemToolRoll(inventoryItemSummary: inventoryItemSummary, advantage: advantage, disadvantage: disadvantage)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
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
