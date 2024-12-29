//
//  EditView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var viewModel: ViewModel
    @FocusState var textFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 20) {
                Button {
                    // 내용 편집 - 키보드 노출
                    viewModel.editTextMode = true
                    textFieldFocused = true
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.accentColor)
                        .shadow(radius: 5)
                        .frame(width: 120, height: 50)
                        .overlay(
                            Text("내용 편집")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                }
                Button {
                    // 색상 편집 - 키보드 감춤
                    viewModel.editColorMode = true
                    textFieldFocused = false
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.accentColor)
                        .shadow(radius: 5)
                        .frame(width: 120, height: 50)
                        .overlay(
                            Text("글자 색상")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                }
            }
            Spacer()
            Button {
                viewModel.selectedTextID = ""
                viewModel.selectedEditingText = ""
                viewModel.editTextMode = false
                viewModel.editColorMode = false
                viewModel.editMode = false
            } label: {
                ZStack() {
                    Text("편집 모드 종료")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .background(Color.accentColor)
                    
                    TextField("Enter text", text: $viewModel.selectedEditingText)
                        .focused($textFieldFocused)
                        .opacity(0)
                        .onChange(of: textFieldFocused) { newValue in
                            viewModel.isFocused = newValue
                        }
                        .onSubmit {
                            viewModel.updateText(id: viewModel.selectedTextID, newText: viewModel.selectedEditingText)
                        }
                    
                    Toggle("Toggle Focus", isOn: $viewModel.isFocused)
                        .opacity(0)
                        .onChange(of: viewModel.isFocused) { newValue in
                            textFieldFocused = newValue
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
