//
//  AbilityView.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 8/2/21.
//

import SwiftUI
import ToastUI

struct AbilityView: View {
    @ObservedObject var characterAbilityVM: CharacterAbilityViewModel
    @State var isSave = false
    @State var ability: AbilityModel
    @State var showRollMode = false
    @State private var advantage = false
    @State private var disadvantage = false

    var body: some View {
        GroupBox(label:
            Text(ability.name)
                .font(.system(size: 10))
                .bold()
                .frame(maxWidth: .infinity, alignment: .top)
        ) {
            VStack {
                ZStack {
                    GeometryReader { geometry in
                        if showRollMode {
                            VStack {
                                Toggle(isOn: $advantage, label: {
                                    Text("Adv")
                                        .font(.system(size: 8))
                                        .frame(alignment: .leading)
                                        .padding(.all, 0)
                                })
                                    .toggleStyle(CheckToggleStyle())
                                    .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .leading)

                                Toggle(isOn: $disadvantage, label: {
                                    Text("Dis")
                                        .font(.system(size: 8))
                                        .frame(alignment: .leading)
                                        .padding(.all, 0)
                                })
                                    .toggleStyle(CheckToggleStyle())
                                    .frame(width: geometry.size.width, height: geometry.size.height / 3, alignment: .leading)

                                HStack(spacing: 5) {
                                    Button(action: {
                                        showRollMode.toggle()
                                    }) {
                                        Text("Cancel")
                                            .font(.system(size: 8))
                                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 3, alignment: .center)
                                    }

                                    Button(action: {
                                        characterAbilityVM.rollAbility(ability: ability, isSave: isSave, advantage: advantage, disadvantage: disadvantage)
                                        showRollMode.toggle()
                                    }) {
                                        Text("Roll")
                                            .font(.system(size: 12))
                                            .foregroundColor(.green)
                                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 3, alignment: .center)
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width: geometry.size.width / 2, height: geometry.size.height / 3, alignment: .center)
                            }
                        } else {
                            VStack {
                                Spacer()
                                Button(getMod(modifier: ability.bonusModifier)) {
                                    showRollMode.toggle()
                                }
                                Spacer()
                                if !isSave {
                                    Text(String(ability.totalScore)).font(.footnote)
                                }
                            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        }
                    }
                }
            }
        }
        .cornerRadius(10)
        .shadow(color: .white, radius: 10, x: -10, y: -10)
        .shadow(color: Color(red: 164 / 255, green: 174 / 255, blue: 192 / 255).opacity(0.4), radius: 10, x: 10, y: 10)
        .toast(isPresented: $characterAbilityVM.showRollResult, dismissAfter: 2.5) {
            let rollResult = characterAbilityVM.getRollResult()
            ToastView("\(rollResult.ability) Roll: \(rollResult.result)!")
        }
    }

    func getMod(modifier: Int) -> String {
        if modifier > 0 {
            return "+\(modifier)"
        }
        return String(modifier)
    }
}

#if DEBUG
    struct AbilityView_Previews: PreviewProvider {
        static var previews: some View {
            AbilityView(
                characterAbilityVM: CharacterAbilityViewModel(abilities: AbilityModel.mockedData),
                ability: AbilityModel.mockedData[0]
            )
        }
    }
#endif
