//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterSpellView: View {
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State private var selection: Set<SpellSummary> = []
    var foundryActor: ActorModel
    
    init(foundryActor: ActorModel) {
        self.foundryActor = foundryActor
        characterSpellVM = CharacterSpellViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            CharacterOverviewView(foundryActor: foundryActor)
            List {
                ForEach(characterSpellVM.getSpellCategories()) { spellCategory in
                    Section(header: Text(spellCategory.id)) {
                        ForEach(spellCategory.items) { spellSummary in
                            SpellView(characterSpellVM: characterSpellVM, spellSummary: spellSummary, isExpanded: self.selection.contains(spellSummary))
                                .onTapGesture { self.selectDeselect(spellSummary) }
                        }
                    }
                }
            }
        }
    }
    
    private func selectDeselect(_ spellSummary: SpellSummary) {
            if selection.contains(spellSummary) {
                selection.remove(spellSummary)
            } else {
                selection.insert(spellSummary)
            }
        }
}

struct SpellView : View {
    var characterSpellVM: CharacterSpellViewModel
    let spellSummary: SpellSummary
    let isExpanded: Bool
    
    var body: some View {
        VStack{
            HStack{
                if let imageData = Data(base64Encoded: spellSummary.img) {
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .leading)
                    }
                }
                Text(spellSummary.name).font(.headline)
            }
            if isExpanded {
                VStack {
                    HStack{
                        Button(action: {
                            characterSpellVM.displayItem(spellSummary: spellSummary)
                        })
                        {
                            Text("Display")
                        }
                        if characterSpellVM.hasAttack(spellSummary: spellSummary) {
                            Button(action: {
                                
                            })
                            {
                                Text("Attack")
                            }
                        }
                    }.buttonStyle(RoundedRectangleButtonStyle())
                    Text(spellSummary.description).font(.footnote)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

