//
//  ListView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(viewModel.editTexts.reversed(), id: \.id) { editText in
                    Button {
                        viewModel.bringTextToFront(id: editText.id)
                        viewModel.selectedTextID = editText.id
                        viewModel.selectedEditingText = editText.text
                        viewModel.editMode = true
                    } label: {
                        Text(editText.text)
                            .foregroundColor(editText.color)
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
