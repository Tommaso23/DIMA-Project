//
//  DocumentReferenceMock.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class DocumentReferenceMock {
    var documentPath: String?
    var collectionPath: String
    var firestore: FirestoreMock
    
    init(documentPath: String, collectionPath: String, firestore: FirestoreMock){
        self.documentPath = documentPath
        self.collectionPath = collectionPath
        self.firestore = firestore
    }
    
    func setData(_ data: [String: Any], merge: Bool, completion: ((Error?) -> Void)?) {
        firestore.documents["\(collectionPath)/\(documentPath ?? "")"] = data
        completion?(firestore.error)
    }
    func getDocument(completion: @escaping (DocumentSnapshotMock?, Error?) -> Void) {
        let data = firestore.documents["\(collectionPath)/\(documentPath ?? "")"]
        completion(DocumentSnapshotMock(data: data), firestore.error)
    }
    func delete(completion: ((Error?) -> Void)?) {
        firestore.documents.removeValue(forKey: "\(collectionPath)/\(documentPath ?? "")")
        completion?(firestore.error)
    }
}
