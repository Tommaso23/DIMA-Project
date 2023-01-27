    //
    //  ContentView.swift
    //  karma
    //
    //  Created by Giovanni Demasi on 05/12/22.
    //

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel

    //@State var selectedTab: Tabs = .search
    
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                LoginView()
            } else if let user = viewModel.currentUser {
                //MainPageView()
                MainView(user: user)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let myEnvObject = AuthViewModel(firebaseAuth: Auth.auth(), firestore: Firestore.firestore())
        ContentView().environmentObject(myEnvObject)
    }
}
