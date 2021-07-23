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
            CharacterOverviewView(foundryActor: foundryActor)
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

struct ItemView : View {
    var characterInventoryVM: CharacterInventoryViewModel
    let inventoryItemSummary: InventoryItemSummary
    let isExpanded: Bool
    
    var body: some View {
        VStack{
            HStack{
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
                    HStack{
                        Button(action: {
                            characterInventoryVM.displayItem(inventoryItemSummary: inventoryItemSummary)
                        })
                        {
                            Text("Display")
                        }
                        if characterInventoryVM.hasAttack(inventoryItemSummary: inventoryItemSummary) {
                            Button(action: {
                                characterInventoryVM.rollItemAttack(inventoryItemSummary: inventoryItemSummary)
                            })
                            {
                                Text("Attack")
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
