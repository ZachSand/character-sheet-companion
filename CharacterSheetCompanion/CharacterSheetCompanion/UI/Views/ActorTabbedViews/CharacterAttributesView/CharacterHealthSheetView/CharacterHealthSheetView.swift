//
//  CharacterHealthSheetView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/19/21.
//

import SwiftUI

struct CharacterHealthSheetView: View {
    @Binding var attributes: ActorAttributesModel
    @State var healthModificationAmount = 0

    var body: some View {
        VStack {
            Text("Current Health: \(attributes.currentHealth) / \(attributes.maxHealth)")
            HStack {
                Text("Health")
                Picker(selection: $healthModificationAmount, label: Text("Choose Health Change")) {
                    LazyVStack {
                        ForEach(-100...100, id: \.self) { value in
                            Text(String(value))
                        }
                    }
                }
            }
            Button("Apply Health Modification") {
                
            }
        }
    }
}

#if DEBUG
    struct CharacterHealthSheetView_Previews: PreviewProvider {
        @State static var attributes = ActorAttributesModel.mockedData

        static var previews: some View {
            CharacterHealthSheetView(attributes: $attributes)
        }
    }
#endif
