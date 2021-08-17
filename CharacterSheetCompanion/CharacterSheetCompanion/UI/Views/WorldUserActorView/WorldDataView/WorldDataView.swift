//
//  WorldDataView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/6/21.
//

import SwiftUI

struct WorldDataView: View {
    @ObservedObject var worldDataVM: WorldDataViewModel

    var body: some View {
        VStack {
            if let worldData = worldDataVM.worldData {
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
}

#if DEBUG
    struct WorldDataView_Previews: PreviewProvider {
        static let worldDataVM: WorldDataViewModel = {
            let worldDataVM = WorldDataViewModel()
            worldDataVM.worldData = WorldDataModel.mockedData
            return worldDataVM
        }()

        static var previews: some View {
            WorldDataView(worldDataVM: worldDataVM)
        }
    }
#endif
