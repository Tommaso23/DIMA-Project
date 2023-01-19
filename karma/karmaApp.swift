//
//  karmaApp.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

@main
struct karmaApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    
    init() {
        // Firebase configurtion is always executed
        FirebaseApp.configure()
        // initialization for testing, using emulators
        #if EMULATORS
        print(">> Testing on Emulators <<")
        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
        //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        #elseif DEBUG
        print(">> Testing on Firebase Server <<")
        #endif

    }
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication
                       .LaunchOptionsKey: Any]?) -> Bool {
      FirebaseApp.configure()
      return true
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView() //Replace it with dashboardView
                
            }
            .environmentObject(viewModel)
        }
    }
}
