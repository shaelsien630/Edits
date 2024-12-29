//
//  UpdateTextCommand.swift
//  Edits
//
//  Created by 최서희 on 12/19/24.
//

import Foundation

struct UpdateTextCommand: Command {
    private let viewModel: ViewModel
    private let id: String
    private let newText: String
    private let oldText: String

    init(viewModel: ViewModel, id: String, newText: String, oldText: String) {
        self.viewModel = viewModel
        self.id = id
        self.newText = newText
        self.oldText = oldText
    }

    func execute() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].text = newText
        }
    }

    func undo() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].text = oldText
        }
    }
}
