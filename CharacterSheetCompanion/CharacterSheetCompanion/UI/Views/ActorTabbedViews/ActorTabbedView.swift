//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorTabbedView: View {
    @ObservedObject var actorListenerWrapper: ActorListenerWrapper
    var actor: ActorModel
    var user: UserModel

    init(actor: ActorModel, user: UserModel) {
        self.actor = actor
        self.user = user
        actorListenerWrapper = ActorListenerWrapper()
    }

    var body: some View {
        if actorListenerWrapper.isActorDataReady {
            CharacterAttributesView(characterOverviewVM: CharacterAttributesViewModel())
                .frame(alignment: .top)
            Divider()
            TabView {
                CharacterAbilityView(characterAbilityVM: CharacterAbilityViewModel())
                    .tabItem {
                        Label("Character", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                CharacterSkillView(characterSkillVM: CharacterSkillViewModel())
                    .tabItem {
                        Label("Skills", systemImage: "list.dash")
                    }
                CharacterSpellView(characterSpellVM: CharacterSpellViewModel())
                    .tabItem {
                        Label("Spells", systemImage: "book")
                    }
                    .tag(3)
                CharacterInventoryView(characterInventoryVM: CharacterInventoryViewModel())
                    .tabItem {
                        Label("Inventory", systemImage: "bag")
                    }
                    .tag(4)
                CharacterDetailsView(characterDetailsVM: CharacterDetailsViewModel())
                    .tabItem {
                        Label("Biography", systemImage: "info.circle")
                    }
                    .tag(5)
                ChatView(chatVM: ChatViewModel(chatMessages: ChatMessageModel.mockedData))
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
