//
//  SettingsView.swift
//  DiceRolling
//
//  Created by Giorgio Latour on 6/22/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var rolls: DiceRolls
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    Text("Delete All Rolls")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
            .alert("Delete All Rolls", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                
                Button("Delete", role: .destructive) {
                    rolls.deleteAllRolls()
                }
            } message: {
                Text(deleteAlertMessage)
            }

        }
    }
    
    let deleteAlertMessage = """
        Are you sure you want to delete all
        previous rolls? This action cannot be undone.
    """
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
