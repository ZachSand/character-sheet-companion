//
//  CharacterBiographyViewModel.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/3/21.
//

import Foundation

class CharacterBiographyViewModel: ObservableObject {
    @Published var biography: ActorBiographyModel

    init(biography: ActorBiographyModel) {
        self.biography = biography
    }
}
