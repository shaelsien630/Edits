//
//  MenuView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                viewModel.addText() // 글자 추가 시 기본값으로 셋팅
            } label: {
                Text("글자 추가")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 70, height: 20)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(5)
            }
            
            Spacer()
            
            Button {
                viewModel.undo() // 실행 취소
            } label: {
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(5)
            }
            .disabled(viewModel.undoStack.isEmpty)
            
            Button {
                viewModel.redo() // 재실행
            } label: {
                Image(systemName: "arrow.uturn.forward")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(5)
            }
            .disabled(viewModel.redoStack.isEmpty)
        }
        .padding(10)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MenuView()
}
