//
//  WorldDataView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/6/21.
//

import SwiftUI

struct WorldDataView: View {
    let worldData: WorldDataModel

    init(worldData: WorldDataModel) {
        self.worldData = worldData
    }

    var body: some View {
        VStack {
            Text(worldData.title).font(.title)
            Text("World Version: \(worldData.version)").font(.footnote)
            Text("Foundry Version: \(worldData.coreVersion)").font(.footnote)
            Text("Foundry System: \(worldData.system)").font(.footnote)
            Text("World Description")
                .padding(.top, 5)
                .padding(.bottom, 0)
            Text(worldData.description)
                .lineLimit(5)
                .font(.footnote)
                .padding([.leading, .trailing, .bottom])
        }
    }
}

#if DEBUG
    struct WorldDataView_Previews: PreviewProvider {
        static var previews: some View {
            WorldDataView(worldData: WorldDataModel.mockedData)
        }
    }
#endif
