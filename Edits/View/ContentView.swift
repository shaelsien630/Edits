//
//  ContentView.swift
//  Edits
//
//  Created by 최서희 on 12/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Preview()
            if viewModel.editMode {
                if viewModel.editColorMode { PaletteView() }
                else { EditView() }
            } else {
                MenuView()
                ListView()
            }
        }
        .ignoresSafeArea()
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
