//
//  Command.swift
//  Edits
//
//  Created by 최서희 on 12/19/24.
//

import Foundation

protocol Command {
    func execute()
    func undo()
}
