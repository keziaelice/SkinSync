//
//  SkinSync_HomeApp.swift
//  SkinSync-Home
//
//  Created by student on 20/11/24.
//

import SwiftUI
import SwiftData

@main
struct SkinSync_HomeApp: App {
    var body: some Scene {
        WindowGroup {
            Pre_OnboardingView()
                .modelContainer(for: [UserModel.self, ProductsData.self])
        }
    }
}
