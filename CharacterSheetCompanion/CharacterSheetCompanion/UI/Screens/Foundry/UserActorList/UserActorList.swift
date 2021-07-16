//
//  UserActorList.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/13/21.
//

import Foundation

import SwiftUI

struct UserActorList: View {
    @ObservedObject var userActorVM: UserActorListViewModel
    @State var hideNavigation = false
    var user: FoundryUser
    
    init(user: FoundryUser) {
        self.user = user
        userActorVM = UserActorListViewModel(user: self.user)
    }
    
    var body: some View {
        ZStack {
            if let userActors = userActorVM.foundryUserActors {
                List(userActors) { userActor in
                    NavigationLink(destination: NavigationLazyView(ActorDetailSummary(userActor: userActor))) {
                        Text(userActor.name)
                    }
                }
            } else {
                Text("No actors found for \(user.userName)")
            }
        }
        .navigationTitle("Select Actor")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#if DEBUG
struct UserActorList_Previews: PreviewProvider {
    static var previews: some View {
        UserActorList(user: FoundryUser.mockedData[0])
    }
}
#endif
