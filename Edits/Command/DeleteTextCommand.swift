//
//  DeleteTextCommand.swift
//  Edits
//
//  Created by 최서희 on 12/19/24.
//

import Foundation

struct DeleteTextCommand: Command {
    private let viewModel: ViewModel
    private let editText: EditText

    init(viewModel: ViewModel, editText: EditText) {
        self.viewModel = viewModel
        self.editText = editText
    }

    func execute() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == editText.id }) {
            viewModel.editTexts.remove(at: index)
        }
    }

    func undo() {
        viewModel.editTexts.append(editText)
    }
}
