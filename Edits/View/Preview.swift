//
//  Preview.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct Preview: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ForEach(viewModel.editTexts, id: \.id) { editText in
                Button {
                    if viewModel.selectedTextID != editText.id {
                        // 텍스트 편집 중 다른 텍스트 클릭 시 저장
                        viewModel.updateText(id: viewModel.selectedTextID, newText: viewModel.selectedEditingText)
                        // selected 초기화
                        viewModel.bringTextToFront(id: editText.id)
                        viewModel.selectedTextID = editText.id
                        viewModel.selectedEditingText = editText.text
                    }
                    
                    // 텍스트 누르면 편집 모드 초기화
                    viewModel.editMode = true
                    viewModel.editTextMode = false
                    viewModel.editColorMode = false
                    viewModel.isFocused = false
                } label: {
                    EditTextView(textlID: editText.id)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(viewModel.editMode ? Color.black.opacity(0.9) : Color.black)
        .animation(.easeInOut, value: viewModel.editMode)
    }
}
