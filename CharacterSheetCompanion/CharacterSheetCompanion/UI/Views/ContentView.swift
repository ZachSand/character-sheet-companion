//
//  ContentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 6/28/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var setupCompleteContainer = SetupCompleteContainer()

    var body: some View {
        ZStack {
            if setupCompleteContainer.setupComplete {
                LazyView(ActorTabbedView(actorTabbedVM: ActorTabbedViewModel()))
            } else {
                NavigationView {
                    ConnectView(connectVM: ConnectViewModel())
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }.environmentObject(setupCompleteContainer)
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
