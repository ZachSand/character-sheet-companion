//
//  SpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import SwiftUI

struct SpellView : View {
    var characterSpellVM: CharacterSpellViewModel
    let spellSummary: SpellSummary
    let isExpanded: Bool
    
    
    var body: some View {
        VStack{
            HStack{
                if let imageData = Data(base64Encoded: spellSummary.img), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .leading)
                }
                Text(spellSummary.name).font(.headline)
            }
            if isExpanded {
                ExpandedSpellView(characterSpellVM: characterSpellVM, spellSummary: spellSummary)
            }
        }
        .contentShape(Rectangle())
    }
}
