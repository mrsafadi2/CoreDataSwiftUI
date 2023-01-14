//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    let corDataManager = CoreDataManager.instance
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, corDataManager.container.viewContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                print("App in Background")
                corDataManager.save()
            case .inactive:
                print("App is Inactive")
            case .active:
                print("App is Active")
            @unknown default:
                print("Apple have some Changeing")
            }
        }
    }
}
