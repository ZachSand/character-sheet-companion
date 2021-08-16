//
//  CharacterCurrencyView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/13/21.
//

import SwiftUI

struct CharacterCurrencyView: View {
    @ObservedObject var characterCurrencyVM: CharacterCurrencyViewModel

    var body: some View {
        HStack {
            if let currency = characterCurrencyVM.currency {
                Image(systemName: "dollarsign.square")
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .leading)
                Text("\(currency.copper) Copper, \(currency.silver) Silver, \(currency.electrum) Electrum, \(currency.gold) Gold, \(currency.platinum) Platinum")
                    .font(.footnote)
            }
        }
    }
}
