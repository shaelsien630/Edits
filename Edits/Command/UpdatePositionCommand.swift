//
//  UpdatePositionCommand.swift
//  Edits
//
//  Created by 최서희 on 12/19/24.
//

import Foundation

struct UpdatePositionCommand: Command {
    private let viewModel: ViewModel
    private let id: String
    private let newPosition: CGPoint
    private let oldPosition: CGPoint

    init(viewModel: ViewModel, id: String, newPosition: CGPoint, oldPosition: CGPoint) {
        self.viewModel = viewModel
        self.id = id
        self.newPosition = newPosition
        self.oldPosition = oldPosition
    }

    func execute() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].position = newPosition
        }
    }

    func undo() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].position = oldPosition
        }
    }
}
