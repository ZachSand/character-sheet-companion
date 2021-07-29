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
                    Section(header: HStack{
                        Text(spellCategory.id)
                        if let spellSlotRemaining = spellCategory.spellSlotRemaining, let maxSpellSlot = spellCategory.maxSpellSlot {
                            Spacer()
                            Text("\(spellSlotRemaining)/\(maxSpellSlot)")
                        }
                    }) {
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

struct SpellHeader: View {
    let name: String

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                Spacer()
            }
            Spacer()
        }
    }
}

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

struct SpellItemAttackSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State var spellSummary: SpellSummary
    @State private var advantage = false
    @State private var disadvantage = false
    @State private var consumeSpellSlot = false

        var body: some View {
            VStack {
                Toggle("Advantage", isOn: $advantage)
                Toggle("Disadvantage", isOn: $disadvantage)
                if(spellSummary.level > 0) {
                    Toggle("Consume Spell Slot", isOn: $consumeSpellSlot)
                }
                
                Button("Roll Attack for " + spellSummary.name) {
                    characterSpellVM.rollItemAttack(spellSummary: spellSummary, advantage: advantage, disadvantage: disadvantage, consumeSpellSlot: consumeSpellSlot)
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .padding()
            }
        }
}

struct SpellItemDamageSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var characterSpellVM: CharacterSpellViewModel
    @State var spellSummary: SpellSummary
    @State private var versatile = false
    @State private var critical = false

    var body: some View {
        VStack {
            Toggle("Versatile", isOn: $versatile)
            Toggle("Critical", isOn: $critical)
            
            Button("Roll Damage for " + spellSummary.name) {
                characterSpellVM.rollItemDamage(spellSummary: spellSummary, critical: critical, versatile: versatile)
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
        }
    }
}
