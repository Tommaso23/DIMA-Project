//
//  FirebaseFirestoreMock.swift
//  karma
//
//  Created by Giovanni Demasi on 26/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirestoreMock {
    var documents: [String: [String: Any]] = [:]
    var documentsSnapshot: [DocumentSnapshot] = []
    var error: Error?
    
    func collection(_ collectionPath: String) -> CollectionReferenceMock {
        return CollectionReferenceMock(collectionPath: collectionPath, firestore: self)
    }
}






                     
                     
                     
