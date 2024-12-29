//
//  EditTextView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct EditTextView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isHidden: Bool = false
    @State var dragOffset: CGSize = .zero
    let textlID: String
    
    var body: some View {
        Text(viewModel.editMode && viewModel.selectedTextID == textlID ? viewModel.selectedEditingText : viewModel.getText(id: textlID)?.text ?? "")
            .font(.subheadline)
            .bold()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundColor(viewModel.getText(id: textlID)?.color ?? Color.black)
            .background(Color.white)
            .overlay(
                ZStack(alignment: .topLeading) {
                    // 선택된 텍스트 테두리
                    if viewModel.editMode && viewModel.selectedTextID == textlID {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 4)
                    } else {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                    }
                    
                    // 선택된 텍스트 삭제 버튼
                    if viewModel.editMode && viewModel.selectedTextID == textlID {
                        Button {
                            withAnimation(.easeInOut) {
                                isHidden = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewModel.deleteText(id: textlID)
                                viewModel.editMode = false
                            }
                        } label: {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.accentColor)
                                .overlay(
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.white)
                                )
                                .offset(x: -10, y: -10)
                        }
                    }
                }
            )
            .opacity(isHidden ? 0 : 1) // 삭제시 애니메이션
            .position(x: (viewModel.getText(id: textlID)?.position.x ?? .zero) + dragOffset.width,
                      y: (viewModel.getText(id: textlID)?.position.y ?? .zero) + dragOffset.height)
            .gesture(
                viewModel.editMode && viewModel.selectedTextID == textlID ? DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in // Preivew 영역에서만 텍스트 이동 가능
                        let limitedX = max(0, min(UIScreen.main.bounds.width, (viewModel.getText(id: textlID)?.position.x ?? .zero) + value.translation.width))
                        let limitedY = max(0, min(380, (viewModel.getText(id: textlID)?.position.y ?? .zero) + value.translation.height))
                        
                        viewModel.updatePosition(for: textlID, to: CGPoint(x: limitedX, y: limitedY))
                        dragOffset = .zero
                    }
                : nil
            )
    }
}
