//
//  UpdateColorCommand.swift
//  Edits
//
//  Created by 최서희 on 12/19/24.
//

import Foundation
import SwiftUI

struct UpdateColorCommand: Command {
    private let viewModel: ViewModel
    private let id: String
    private let newColor: Color
    private let oldColor: Color

    init(viewModel: ViewModel, id: String, newColor: Color, oldColor: Color) {
        self.viewModel = viewModel
        self.id = id
        self.newColor = newColor
        self.oldColor = oldColor
    }

    func execute() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].color = newColor
        }
    }

    func undo() {
        if let index = viewModel.editTexts.firstIndex(where: { $0.id == id }) {
            viewModel.editTexts[index].color = oldColor
        }
    }
}
