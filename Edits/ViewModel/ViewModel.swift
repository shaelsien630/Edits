//
//  ViewModel.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var editTexts: [EditText] = []
    @Published var editMode: Bool = false
    @Published var editTextMode: Bool = false
    @Published var editColorMode: Bool = false
    @Published var isFocused: Bool = false
    @Published var selectedTextID: String = ""
    @Published var selectedEditingText: String = ""
    var undoStack: [Command] = []
    var redoStack: [Command] = []
    
    func performCommand(_ command: Command) {
        command.execute()
        undoStack.append(command)
        redoStack.removeAll()
    }
    
    func undo() {
        guard let lastCommand = undoStack.popLast() else { return }
        lastCommand.undo()
        redoStack.append(lastCommand)
    }
    
    func redo() {
        guard let lastCommand = redoStack.popLast() else { return }
        lastCommand.execute()
        undoStack.append(lastCommand)
    }
    
    func addText() {
        let randomX = CGFloat.random(in: 50...(UIScreen.main.bounds.width-50))
        let randomY = CGFloat.random(in: 100...(400-50))
        let newText = EditText(
            text: "텍스트",
            color: Color.black,
            position: CGPoint(x: randomX, y: randomY)
        )
        let command = AddTextCommand(viewModel: self, editText: newText)
        performCommand(command)
    }
    
    func updateText(id: String, newText: String) {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            let command = UpdateTextCommand(viewModel: self, id: id, newText: newText, oldText: editTexts[index].text)
            performCommand(command)
        }
    }
    
    func updateColor(id: String, newColor: Color) {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            let command = UpdateColorCommand(viewModel: self, id: id, newColor: newColor, oldColor: editTexts[index].color)
            performCommand(command)
        }
    }
    
    func updatePosition(for id: String, to newPosition: CGPoint) {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            let command = UpdatePositionCommand(viewModel: self, id: id, newPosition: newPosition, oldPosition: editTexts[index].position)
            performCommand(command)
        }
    }
    
    func deleteText(id: String) {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            let command = DeleteTextCommand(viewModel: self, editText: editTexts[index])
            performCommand(command)
        }
    }
    
    func getText(id: String) -> EditText? {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            return editTexts[index]
        }
        else { return nil }
    }
    
    func bringTextToFront(id: String) {
        if let index = editTexts.firstIndex(where: { $0.id == id }) {
            let selectedText = editTexts.remove(at: index)
            editTexts.append(selectedText)
        }
    }
}
