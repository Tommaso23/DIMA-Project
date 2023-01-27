//
//  karmaApp.swift
//  karma
//
//  Created by Giovanni Demasi on 05/12/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct karmaApp: App {
    @StateObject var viewModel = AuthViewModel(firebaseAuth: Auth.auth(), firestore: Firestore.firestore())
    
    
    init() {
        // Firebase configurtion is always executed
//        // initialization for testing, using emulators
//#if EMULATORS
//        print(">> Testing on Emulators <<")
//        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
//        let settings = Firestore.firestore().settings
//        settings.host = "localhost:8080"
//        settings.isPersistenceEnabled = false
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
//#elseif DEBUG
//        print(">> Testing on Firebase Server <<")
//#endif
//        let appOptions = FirebaseOptions(
//                    googleAppID: "1:774454406954:ios:29b746b4e87fd351677853",
//                    gcmSenderID: "774454406954"
//                )
//                appOptions.apiKey = "AIzaSyBNJrBaHVFFDFz-pIiUrgXmmIfNFUTmg6I"
//                appOptions.projectID = "dima-project-7bd5f"
        FirebaseApp.configure()
        // Checking if unit tests are running
        if ProcessInfo.processInfo.environment["unit_tests"] == "true" {
          print("Setting up Firebase emulator localhost:8080")
          Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
          //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
          let settings = Firestore.firestore().settings
          settings.host = "127.0.0.1:8080"
          settings.isPersistenceEnabled = false
          settings.isSSLEnabled = false
          Firestore.firestore().settings = settings
        }
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
