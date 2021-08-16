//
//  UserAuthSheet.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/16/21.
//

import SwiftUI

struct UserAuthSheet: View {
    @ObservedObject var userAuthenticationSheetVM: UserAuthenticationViewModel
    @State private var password: String = ""
    @Binding var user: UserModel?
    @Binding var actor: ActorModel?

    var body: some View {
        VStack {
            if let user = self.user, let actor = self.actor {
                Text("User Login").font(.largeTitle)
                    .padding()
                Spacer()
                SecureField("Enter password for \(user.name)", text: $password)
                    .multilineTextAlignment(.center)
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding([.leading, .trailing], 27.5)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                Text("Leave password blank if \(user.name) does not have a password")
                    .font(.footnote)
                    .padding()

                Spacer()
                if userAuthenticationSheetVM.sentLoginRequest {
                    ProgressView("Authenticating...")
                    Spacer()
                }

                Button {
                    userAuthenticationSheetVM.verifyUserAuth(user: user, password: password)
                    if userAuthenticationSheetVM.userAuthSuccessful {
                        if let window = UIApplication.shared.windows.first {
                            userAuthenticationSheetVM.completeSetup(user: user, actor: actor)
                            window.rootViewController = UIHostingController(rootView: ActorTabbedView(actor: actor, user: user))
                            window.makeKeyAndVisible()
                        }
                    }
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
            }
        }
    }
}

#if DEBUG
    struct UserAuthSheetPreviews: PreviewProvider {
        @State static var user: UserModel? = UserModel.mockedData[0]
        @State static var actor: ActorModel? = ActorModel.mockedData[0]

        static var previews: some View {
            UserAuthSheet(userAuthenticationSheetVM: UserAuthenticationViewModel(), user: $user, actor: $actor)
        }
    }
#endif
