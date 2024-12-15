//
//  SkinSync_HomeApp.swift
//  SkinSync-Home
//
//  Created by student on 20/11/24.
//

import SwiftUI

@main
struct SkinSync_HomeApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .modelContainer(for: [UserModel.self]) // Daftarkan model User untuk SwiftData
        }
    }
}
