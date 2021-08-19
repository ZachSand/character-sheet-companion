//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorTabbedView: View {
    @ObservedObject var actorTabbedVM: ActorTabbedViewModel

    var body: some View {
        VStack {
            if actorTabbedVM.isActorDataReady {
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
                    CharacterTraitsView(characterTraitsVM: CharacterTraitsViewModel())
                        .tabItem {
                            Label("Traits", systemImage: "list.bullet.rectangle")
                        }
                        .tag(7)
                }
            } else {
                if let actor = FoundrySocketIOManager.sharedInstance.actor {
                    Text("Loading ActorData data for \(actor.name)")
                }
                ProgressView()
            }
        }
    }
}

#if DEBUG
    struct ActorTabbedView_Previews: PreviewProvider {
        static let actorTabbedVM: ActorTabbedViewModel = {
            let actorTabbedVM = ActorTabbedViewModel()
            actorTabbedVM.isActorDataReady = true
            return actorTabbedVM
        }()

        static var previews: some View {
            ActorTabbedView(actorTabbedVM: actorTabbedVM)
        }
    }
#endif
