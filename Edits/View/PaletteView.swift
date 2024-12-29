//
//  PaletteView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct PaletteView: View {
    @EnvironmentObject var viewModel: ViewModel
    let colorData: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .brown, .gray, .black]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 20) {
                ForEach(0..<2) { rowIndex in
                    HStack(spacing: 20)  {
                        ForEach(0..<5) { columnIndex in
                            let colorIndex = rowIndex * 5 + columnIndex
                            Button {
                                viewModel.updateColor(id: viewModel.selectedTextID, newColor: colorData[colorIndex])
                            } label: {
                                Rectangle()
                                    .fill(colorData[colorIndex])
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button {
                viewModel.editColorMode = false
            } label: {
                Text("완료")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(Color.accentColor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PaletteView()
}
