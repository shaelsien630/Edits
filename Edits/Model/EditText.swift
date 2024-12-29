//
//  EditText.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import Foundation
import SwiftUI

struct EditText: Identifiable {
    let id: String = UUID().uuidString
    var text: String
    var color: Color
    var position: CGPoint
}
