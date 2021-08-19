//
//  UsersPickerView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/18/21.
//

import SwiftUI

struct UserPickerView: View {
    @ObservedObject var userPickerVM: UserPickerViewModel
    @Binding var selectedUser: SetupUserModel?

    var body: some View {
        if let users = userPickerVM.users {
            Picker(selection: $selectedUser, label: Text("Select Foundry User")) {
                ForEach(users) { user in
                    Text(user.name).tag(user as SetupUserModel?)
                }
            }
            .onAppear {
                if users.count > 0 {
                    selectedUser = users[0]
                }
            }
        } else {
            Text("No Users Found")
        }
    }
}

#if DEBUG
    struct UserPickerView_Previews: PreviewProvider {
        static let userPickerVM: UserPickerViewModel = {
            let userPickerVM = UserPickerViewModel()
            userPickerVM.users = SetupUserModel.mockedData
            return userPickerVM
        }()

        @State static var selectedUser: SetupUserModel? = SetupUserModel.mockedData[0]

        static var previews: some View {
            UserPickerView(userPickerVM: userPickerVM, selectedUser: $selectedUser)
        }
    }
#endif
