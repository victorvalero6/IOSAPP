//
//  NotificationsView.swift
//  CaritasMonterrey
//
//  Created by Alumno on 20/10/25.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            List { Text("Tu donación cambió a Aceptada") }
            .navigationTitle("Notificaciones")
        }
    }
}
