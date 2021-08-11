//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorTabbedView: View {
    @ObservedObject var actorTabbedVM: ActorTabbedViewModel
    var actor: ActorModel
    var user: UserModel

    init(actor: ActorModel, user: UserModel) {
        self.actor = actor
        self.user = user
        actorTabbedVM = ActorTabbedViewModel(actor: actor)
    }

    var body: some View {
        if actorTabbedVM.dataLoadComplete {
            CharacterOverviewView(actorOverview: ActorOverviewModel.mockedData)
                .frame(alignment: .top)
            Divider()
            TabView {
                CharacterAbilityView(characterAbilityVM: CharacterAbilityViewModel(abilities: ActorAbilityModel.mockedData))
                    .tabItem {
                        Label("Character", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                CharacterSkillView(characterSkillVM: CharacterSkillViewModel(skills: ActorSkillModel.mockedData))
                    .tabItem {
                        Label("Skills", systemImage: "list.dash")
                    }
                CharacterSpellView(characterSpellVM: CharacterSpellViewModel(spellSlots: ActorSpellSlotModel.mockedData))
                    .tabItem {
                        Label("Spells", systemImage: "book")
                    }
                    .tag(3)
                CharacterInventoryView(characterInventoryVM: CharacterInventoryViewModel(inventory: ActorInventoryModel.mockedData))
                    .tabItem {
                        Label("Inventory", systemImage: "bag")
                    }
                    .tag(4)
                CharacterBiographyView(characterBiographyVM: CharacterBiographyViewModel(biography: ActorBiographyModel.mockedData))
                    .tabItem {
                        Label("Biography", systemImage: "info.circle")
                    }
                    .tag(5)
                ChatView(chatVM: ChatViewModel(user: UserModel.mockedData[0], chatMessages: ChatMessageModel.mockedData))
                    .tabItem {
                        Label("Chat", systemImage: "message")
                    }
                    .tag(6)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        } else {
            Text("Loading ActorData data for \(actor.name)")
            ProgressView()
        }
    }
}

#if DEBUG
    struct ActorTabbedView_Previews: PreviewProvider {
        static var previews: some View {
            ActorTabbedView(
                actor: ActorModel.mockedData[0],
                user: UserModel.mockedData[0]
            )
        }
    }
#endif
