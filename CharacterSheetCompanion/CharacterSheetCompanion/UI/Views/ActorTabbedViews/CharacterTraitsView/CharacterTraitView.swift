//
//  CharacterTraitViewBuilder.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/19/21.
//

import SwiftUI

struct CharacterTraitView: View {
    let traits: [String]
    let sectionHeader: String

    var body: some View {
        VStack {
            Section(header: Text(sectionHeader).font(.title2).bold()) {
                ForEach(traits, id: \.self) { trait in
                    Text(trait)
                }
            }
            Divider()
        }
    }
}

#if DEBUG
    struct CharacterTraitView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterTraitView(traits: ["some sense"], sectionHeader: "Senses")
        }
    }
#endif
