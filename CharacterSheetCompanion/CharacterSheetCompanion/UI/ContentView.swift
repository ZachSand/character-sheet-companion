//
//  ContentView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 6/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ConnectView()
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
