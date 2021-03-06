//
//  SpellView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import SwiftUI

struct SpellRowView: View {
    let spell: ActorSpellModel
    let isExpanded: Bool

    var body: some View {
        VStack {
            HStack {
                if let imageData = spell.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .leading)
                } else {
                    Image(systemName: "wand.and.stars")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .leading)
                }
                Text(spell.name).font(.headline)
            }
            if isExpanded {
                ExpandedSpellRowView(expandedSpellRowVM: ExpandedSpellRowViewModel(), spell: spell)
            }
        }
        .contentShape(Rectangle())
    }
}

#if DEBUG
    struct SpellView_Previews: PreviewProvider {
        static var previews: some View {
            SpellRowView(
                spell: ActorSpellModel.mockedData[0], isExpanded: true
            )
        }
    }
#endif
