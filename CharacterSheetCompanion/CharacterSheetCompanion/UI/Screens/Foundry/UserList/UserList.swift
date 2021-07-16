//
//  UserActorList.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/6/21.
//

import SwiftUI

struct UserList: View {
    @ObservedObject var userVM = UserListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if let users = userVM.foundryUsers {
                    List(users) { user in
                        NavigationLink(destination: NavigationLazyView(UserActorList(user: user))) {
                            Text(user.userName)
                        }
                    }
                } else {
                    Text("No users found")
                }
            }
            .navigationTitle("Select User")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct UserList_Previews: PreviewProvider {    
    static var previews: some View {
        UserList()
    }
}
#endif
