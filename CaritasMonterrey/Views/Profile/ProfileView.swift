//
//  ProfileView.swift
//  CaritasMonterrey
//
//  Created by Alumno on 20/10/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable().frame(width: 100, height: 100)
                Text("Nombre del usuario").font(.title3)
                List { Text("Historial de donaciones") }
            }
            .padding()
            .navigationTitle("Perfil")
        }
    }
}


