//
//  CharacterView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/20/21.
//

import SwiftUI

struct CharacterActionView: View {
    @ObservedObject var characterActionVM: CharacterActionViewModel
    var foundryActor: FoundryActor
    
    init(foundryActor: FoundryActor) {
        self.foundryActor = foundryActor
        characterActionVM = CharacterActionViewModel(foundryActor: foundryActor)
    }
    
    var body: some View {
        VStack {
            
        }
    }
}
