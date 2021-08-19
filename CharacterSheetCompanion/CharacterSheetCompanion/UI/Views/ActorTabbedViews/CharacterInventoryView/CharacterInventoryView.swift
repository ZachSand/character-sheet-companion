//
//  CharacterEquipmentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterInventoryView: View {
    @ObservedObject var characterInventoryVM: CharacterInventoryViewModel

    var body: some View {
        VStack {
            CharacterCurrencyView(characterCurrencyVM: CharacterCurrencyViewModel())
            List {
                ForEach(characterInventoryVM.getInventorySections()) { inventorySection in
                    Section(header: Text(inventorySection.id)) {
                        ItemListView(inventorySection: inventorySection)
                    }
                }
            }
        }
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
