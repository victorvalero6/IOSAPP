//
//  ContentView.swift
//  CaritasMonterrey
//
//  Created by Alumno on 20/10/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Inicio", systemImage: "house.fill") }
            NavigationStack { DonationsView() }
                .tabItem { Label("Donaciones", systemImage: "heart.fill") }
            NotificationsView()
                .tabItem { Label("Notifs", systemImage: "bell.fill") }
            ProfileView()
                .tabItem { Label("Perfil", systemImage: "person.fill") }
        }
    }
}

