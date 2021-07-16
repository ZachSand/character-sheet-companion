//
//  ContentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 6/28/21.
//

import SwiftUI

struct ContentView: View {
    @State var socketConnectSuccess = false
    
    var body: some View {
        return Group {
            if(socketConnectSuccess) {
                UserList()
            } else {
                FoundryConnectView(connectSuccess: $socketConnectSuccess)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}