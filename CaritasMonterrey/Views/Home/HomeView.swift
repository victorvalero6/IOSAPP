//
//  HomeView.swift
//  CaritasMonterrey
//
//  Created by Alumno on 20/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Campañas destacadas")
                Button("Donar ahora") {}
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Inicio")
        }
    }    
}

#Preview{
    HomeView()
}
