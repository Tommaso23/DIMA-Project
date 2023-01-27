//
//  FirebaseAuthMock.swift
//  karma
//
//  Created by Giovanni Demasi on 26/01/23.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseAuthMock {
    
    private var registeredUsers = [String: String]()
    var current_User: User?
    
    static var staticInit: (() -> ())?
    
    func currentUser() -> User? {
        return current_User
    }
    
    func createUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        if registeredUsers.keys.contains(email) {
            completion(nil)
            return
        }
        registeredUsers[email] = password
        completion(nil)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        guard registeredUsers[email] == password else {
            completion(nil)
            return
        }
        completion(nil)
    }
    
    func signOut(completion: (Error?) -> Void) {
        completion(nil)
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        guard registeredUsers.keys.contains(email) else {
            completion(nil)
            return
        }
        completion(nil)
    }
    
    func changePassword(email: String, newPassword: String, completion: @escaping (Error?) -> Void) {
        guard registeredUsers.keys.contains(email) else {
            completion(nil)
            return
        }
        registeredUsers[email] = newPassword
        completion(nil)
    }
}
