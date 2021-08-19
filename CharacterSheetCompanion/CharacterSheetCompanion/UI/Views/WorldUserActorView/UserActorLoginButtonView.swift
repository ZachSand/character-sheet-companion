//
//  UserActorLoginButtonView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import SwiftUI

struct UserActorLoginButtonView: View {
    @Binding var selectedUser: SetupUserModel?
    @Binding var selectedActor: SetupActorModel?
    @State private var showingUserAuthSheet = false

    var body: some View {
        VStack {
            NavigationLink(
                destination: UserAuthenticationView(userAuthenticationVM: UserAuthenticationViewModel(), user: $selectedUser, actor: $selectedActor),
                isActive: $showingUserAuthSheet,
                label: {
                    Button {
                        showingUserAuthSheet.toggle()
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 30)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                }
            )
            .disabled(selectedUser == nil || selectedActor == nil)
            .opacity(selectedUser == nil || selectedActor == nil ? 0.5 : 1)
        }
    }
}
