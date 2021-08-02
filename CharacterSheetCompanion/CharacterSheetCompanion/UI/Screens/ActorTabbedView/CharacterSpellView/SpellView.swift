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
    @State private var showingAttackSheet = false
    @State private var showingDamageSheet = false
    
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
                VStack {
                    HStack{
                        Button("Display") {
                            characterSpellVM.displayItem(spellSummary: spellSummary)
                        }
                        if characterSpellVM.hasAttack(spellSummary: spellSummary) {
                            Button("Cast") {
                                showingAttackSheet.toggle()
                            }.sheet(isPresented: $showingAttackSheet, content: {
                                SpellItemAttackSheetView(characterSpellVM: characterSpellVM, spellSummary: spellSummary)
                            })
                        }
                        if spellSummary.hasDamage {
                            Button("Damage") {
                                showingDamageSheet.toggle()
                            }.sheet(isPresented: $showingDamageSheet, content: {
                                SpellItemDamageSheetView(characterSpellVM: characterSpellVM, spellSummary: spellSummary)
                            })
                        }
                    }.buttonStyle(RoundedRectangleButtonStyle())
                    Text(spellSummary.description).font(.footnote)
                }
            }
        }
        .contentShape(Rectangle())
    }
}
