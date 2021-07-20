//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorDetailSummary : View {
    @ObservedObject var actorDetailSummaryVM: ActorDetailSummaryViewModel
    var userActor: FoundryUserActor
    
    init(userActor: FoundryUserActor) {
        self.userActor = userActor
        actorDetailSummaryVM = ActorDetailSummaryViewModel(userActor: userActor)
    }
    
    var body: some View {
        if actorDetailSummaryVM.foundryActor != nil {
            TabView {
                CharacterOverviewView(foundryActor: actorDetailSummaryVM.foundryActor!)
                    .tabItem{
                        Label("Character", systemImage: "list.dash")
                    }
                    .tag(1)
                CharacterActionView(foundryActor: actorDetailSummaryVM.foundryActor!)
                    .tabItem {
                        Label("Actions", systemImage: "list.dash")
                    }
                    .tag(2)
                CharacterSkillView(foundryActor: actorDetailSummaryVM.foundryActor!)
                    .tabItem{
                        Label("Skills", systemImage: "list.dash")
                    }
                CharacterSpellView(foundryActor: actorDetailSummaryVM.foundryActor!)
                    .tabItem{
                        Label("Spells", systemImage: "list.dash")
                    }
                    .tag(3)
                CharacterInventoryView(foundryActor: actorDetailSummaryVM.foundryActor!)
                    .tabItem{
                        Label("Inventory", systemImage: "list.dash")
                    }
                    .tag(4)

            }
            .accentColor(.white)
            .onAppear() {
                UITabBar.appearance().barTintColor = .orange
            }
            .navigationTitle("")
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        } else {
            Text("No actor data found for \(userActor.name)")
        }
    }
}
