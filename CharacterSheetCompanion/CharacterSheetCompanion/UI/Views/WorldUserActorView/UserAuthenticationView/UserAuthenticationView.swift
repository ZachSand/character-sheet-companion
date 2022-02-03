//
//  UserAuthSheet.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import SwiftUI

struct UserAuthenticationView: View {
    @EnvironmentObject var setupCompleteContainer: SetupCompleteContainer
    @ObservedObject var userAuthenticationVM: UserAuthenticationViewModel
    @State private var password: String = ""
    @Binding var user: SetupUserModel?
    @Binding var actor: SetupActorModel?

    var body: some View {
        VStack {
            if let user = self.user, let actor = self.actor {
                Spacer()
                SecureField("Enter password for \(user.name)", text: $password)
                    .multilineTextAlignment(.center)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding([.leading, .trailing], 27.5)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                switch userAuthenticationVM.authState {
                case .NOT_AUTHENTICATING:
                    Text("Leave password blank if \(user.name) does not have a password")
                        .font(.footnote)
                        .padding()
                case .AUTHENTICATING:
                    Text("Authenticating...")
                    ProgressView()
                case .FAILED_AUTHENTICATION:
                    Text("Login failed. Make sure you've entered the corrected password for \(user.name)")
                        .foregroundColor(Color.red)
                case .AUTHENTICATED:
                    Text("Login successful!").onAppear {
                        setupCompleteContainer.setupComplete = true
                        userAuthenticationVM.completeSetup(user: user, actor: actor)
                    }
                case .none:
                    Text("")
                }

                Spacer()

                Button {
                    userAuthenticationVM.verifyUserAuth(user: user, actor: actor, password: password)
                } label: {
                    Text("Load Character Sheet for \n \(actor.name)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 80)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            } else {
                Text("User and Actor must be selected")
            }
        }
        .navigationTitle("User Login")
    }
}

#if DEBUG
    struct UserAuthenticationView_Previews: PreviewProvider {
        @State static var user: SetupUserModel? = SetupUserModel.mockedData[0]
        @State static var actor: SetupActorModel? = SetupActorModel.mockedData[0]

        static var previews: some View {
            UserAuthenticationView(userAuthenticationVM: UserAuthenticationViewModel(), user: $user, actor: $actor)
        }
    }
#endif
