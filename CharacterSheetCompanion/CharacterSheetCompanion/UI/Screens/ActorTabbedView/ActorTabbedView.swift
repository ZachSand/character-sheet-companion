//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorTabbedView: View {
    @ObservedObject var actorTabbedVM: ActorTabbedViewModel
    var userActor: UserActorModel
    var user: UserModel

    init(userActor: UserActorModel, user: UserModel) {
        self.userActor = userActor
        self.user = user
        actorTabbedVM = ActorTabbedViewModel(userActor: userActor)
    }

    var body: some View {
        if let foundryActor = actorTabbedVM.foundryActor {
            CharacterOverviewView(foundryActor: foundryActor)
                .frame(alignment: .top)
            Divider()
            TabView {
                CharacterAbilityView(foundryActor: foundryActor)
                    .tabItem {
                        Label("Character", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                CharacterSkillView(foundryActor: foundryActor)
                    .tabItem {
                        Label("Skills", systemImage: "list.dash")
                    }
                CharacterSpellView(foundryActor: foundryActor)
                    .tabItem {
                        Label("Spells", systemImage: "book")
                    }
                    .tag(3)
                CharacterInventoryView(foundryActor: foundryActor)
                    .tabItem {
                        Label("Inventory", systemImage: "bag")
                    }
                    .tag(4)
                CharacterBiographyView(foundryActor: foundryActor)
                    .tabItem {
                        Label("Biography", systemImage: "info.circle")
                    }
                    .tag(5)
                ChatView(user: user, foundryActor: foundryActor)
                    .tabItem {
                        Label("Chat", systemImage: "message")
                    }
                    .tag(6)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        } else {
            Text("Loading Actor data for \(userActor.name)")
            ProgressView()
        }
    }
}
