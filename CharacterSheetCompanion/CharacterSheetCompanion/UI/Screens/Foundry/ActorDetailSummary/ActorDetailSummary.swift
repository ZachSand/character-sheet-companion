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
            VStack {
                Text("Attributes")
                List(actorDetailSummaryVM.getAbilities()) {ability in
                    Button(action: {
                        actorDetailSummaryVM.rollAbility(actorAbility: ability, isSave: false, advantage: false, disadvantage: false)
                    })
                    {
                        Text(ability.id)
                    }
                }
                Text("Skills")
                List(actorDetailSummaryVM.getSkills()) {skill in
                    Button(action: {
                        actorDetailSummaryVM.rollSkillCheck(actorSkill: skill, advantage: false, disadvantage: false)
                    })
                    {
                        Text(skill.id)
                    }
                }
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
