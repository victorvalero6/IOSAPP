//
//  DonationsView.swift
//  CaritasMonterrey
//
//  Created by Alumno on 20/10/25.
//
//  Modificado por Gemini con UI de "GitHub Inbox" y datos de "Mis donaciones"
//

import SwiftUI

struct DonationsView: View {
    
    /// Define las opciones del filtro "píldora"
    enum FilterOption: String, CaseIterable {
        case todas = "Todas"
        case enProceso = "En proceso"
        case completadas = "Completadas"
    }
    
    @State private var selectedFilter: FilterOption = .todas
    
    // -------------------------------------------------------------------------
    // MARK: - DATOS (Listos para Base de Datos)
    // -------------------------------------------------------------------------
    
    /// DATOS DE MUESTRA (Mock Data)
    /// Ahora se inicializa desde la propiedad estática en Donation.swift
    /// Esto mantiene la vista limpia de datos hardcodeados.
    @State private var allDonations: [Donation] = Donation.sampleDonations
    
    /// Lógica de filtrado limpia.
    /// Esto lee la lista de 'allDonations' (que vendrá de tu BD)
    /// y la filtra según el 'selectedFilter'.
    private var filteredDonations: [Donation] {
        switch selectedFilter {
        case .todas:
            return allDonations
        case .enProceso:
            return allDonations.filter { $0.status == .enProceso }
        case .completadas:
            return allDonations.filter { $0.status == .completada }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Cuerpo de la Vista
    // -------------------------------------------------------------------------
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // --- Filtros estilo "Píldora" (como en GitHub Inbox) ---
                FilterPillView(selection: $selectedFilter)
                    .padding(.bottom, 12)
                
                // --- Lista de Donaciones ---
                ScrollView {
                    if filteredDonations.isEmpty {
                        // --- Estado Vacío (como en GitHub Inbox) ---
                        EmptyStateView(
                            message: "No hay donaciones en esta categoría."
                        )
                        .padding(.top, 100)
                    } else {
                        // --- Tarjetas de Donación ---
                        VStack(spacing: 12) {
                            ForEach(filteredDonations) { donation in
                                DonationCardView(donation: donation)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Mis donaciones")
            .background(Color(.systemGroupedBackground)) // Fondo gris claro
        }
    }
}


// -----------------------------------------------------------------------------
// MARK: - Componentes de UI Reutilizables
// -----------------------------------------------------------------------------

/// Vista para el filtro estilo "Píldora"
private struct FilterPillView: View {
    @Binding var selection: DonationsView.FilterOption
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(DonationsView.FilterOption.allCases, id: \.self) { filter in
                Button(action: {
                    withAnimation(.spring(dampingFraction: 0.7)) {
                        selection = filter
                    }
                }) {
                    Text(filter.rawValue)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(selection == filter ? Color("AccentColor") : Color(.white))
                        .foregroundColor(selection == filter ? .white : .primary)
                        .clipShape(Capsule())
                        
                  
                }
                .glassEffect()
            }
        }
        .padding(.horizontal)
    }
}


/// Vista para la tarjeta de donación (estilo minimalista)
private struct DonationCardView: View {
    let donation: Donation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // --- Fila Superior: Título y Estado ---
            HStack {
                Image(systemName: "shippingbox.fill")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(donation.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // "Píldora" de Estado (minimalista)
                HStack(spacing: 4) {
                    Image(systemName: donation.status.iconName)
                    Text(donation.status.rawValue)
                }
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(donation.status.color.opacity(0.15))
                .foregroundColor(donation.status.color)
                .clipShape(Capsule())
            }
            
            // --- Fila de Fecha ---
            InfoRow(
                iconName: "calendar",
                text: donation.formattedDate
            )
            
            // --- Fila de Ubicación ---
            InfoRow(
                iconName: "mappin.circle.fill",
                text: donation.location
            )
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground)) // Color de tarjeta blanco
        .cornerRadius(12)
    }
}


/// Fila de información reutilizable (Icono + Texto)
private struct InfoRow: View {
    let iconName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 20) // Alinea los iconos
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}


/// Vista de "Estado Vacío" (como la de GitHub)
private struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 50))
                .foregroundColor(Color(red: 0.4, green: 0.75, blue: 0.75)) // Teal
            
            Text("¡Todo al día!")
                .font(.headline)
                .fontWeight(.bold)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
    }
}


// -----------------------------------------------------------------------------
// MARK: - Vista Previa
// -----------------------------------------------------------------------------

#Preview {
    DonationsView()
}
