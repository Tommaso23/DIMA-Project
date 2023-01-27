//
//  CollectionReferenceMock.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore


class CollectionReferenceMock {
    var collectionPath: String
    var firestore: FirestoreMock
    
    init(collectionPath: String, firestore: FirestoreMock){
        self.collectionPath = collectionPath
        self.firestore = firestore
    }
    
    func document(_ documentPath: String?) -> DocumentReferenceMock {
        return DocumentReferenceMock(documentPath: documentPath ?? "", collectionPath: collectionPath, firestore: firestore)
    }
}
