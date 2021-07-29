//
//  ActorDetailSummary.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/7/21.
//

import SwiftUI

struct ActorTabbedView : View {
    @ObservedObject var actorTabbedVM: ActorTabbedViewModel
    var userActor: UserActorModel
    
    init(userActor: UserActorModel) {
        self.userActor = userActor
        actorTabbedVM = ActorTabbedViewModel(userActor: userActor)
    }
    
    var body: some View {
        if actorTabbedVM.foundryActor != nil {
            TabView {
                CharacterAbilityView(foundryActor: actorTabbedVM.foundryActor!)
                    .tabItem{
                        Label("Character", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                CharacterSkillView(foundryActor: actorTabbedVM.foundryActor!)
                    .tabItem{
                        Label("Skills", systemImage: "list.dash")
                    }
                CharacterSpellView(foundryActor: actorTabbedVM.foundryActor!)
                    .tabItem{
                        Label("Spells", systemImage: "book")
                    }
                    .tag(3)
                CharacterInventoryView(foundryActor: actorTabbedVM.foundryActor!)
                    .tabItem{
                        Label("Inventory", systemImage: "bag")
                    }
                    .tag(4)
            }
            .accentColor(.black)
            .onAppear() {
                UITabBar.appearance().barTintColor = .orange
            }
            .navigationTitle("")
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        } else {
            Text("Loading Actor data for \(userActor.name)")
            ProgressView()
        }
    }
}

struct SomeProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        
    }
    
    
}
