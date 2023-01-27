//
//  CollectionService.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Firebase
import FirebaseFirestore
import SwiftUI


struct CollectionService : CollectionServiceProtocol {
    
    func uploadCollection(title: String, caption: String, amount: Float, image: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data  = ["uid": uid,
                     "title": title,
                     "caption": caption,
                     "collectionImageUrl": image,
                     "amount": amount,
                     "currentAmount": 0,
                     "favourites": 0,
                     "participants": 0,
                     "timestamp": Timestamp(date: Date())] as [String : Any]
        

        Firestore.firestore().collection("collections").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload collection with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    //fetching collections for DashboardView
    func fetchCollections(completion: @escaping([Collection]) -> Void) {
        Firestore.firestore().collection("collections")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let collections = documents.compactMap({try? $0.data(as: Collection.self) })
                completion(collections)
            }
    }
    
    //fetching collections for personal User
    func fetchCollections(forUid uid: String, completion: @escaping([Collection]) -> Void) {
        Firestore.firestore().collection("collections")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let collections = documents.compactMap({try? $0.data(as: Collection.self) })
                completion(collections.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
//    func makePayment(destinationId: String, _ collection: Collection, total: Float) {
//        guard let senderId = Auth.auth().currentUser?.uid else { return }
//        guard let collectionId = collection.id else { return }
//        
//        let data = ["senderId": senderId,
//                    "destinationId": destinationId,
//                    "collectionId": collectionId,
//                    "total": total,
//                    "timestamp": Timestamp(date: Date())] as [String : Any]
//        Firestore.firestore().collection("payments").document()
//            .setData(data)
//    }
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        let userFavRef = Firestore.firestore().collection("users").document(uid).collection("user-favs")
        
        Firestore.firestore().collection("collections").document(collId)
            .updateData(["favourites": collection.favourites + 1]) { _ in
                userFavRef.document(collId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserlikedCollection(_ collection: Collection, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("user-favs").document(collId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            completion(snapshot.exists)
        }
    }
    
    func removeFromFavourite(_ collection: Collection, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let collId = collection.id else { return }
        guard collection.favourites > 0 else { return }
        
        let userFavRef = Firestore.firestore().collection("users").document(uid).collection("user-favs")
        
        Firestore.firestore().collection("collections").document(collId)
            .updateData(["favourites": collection.favourites - 1]) { _ in
                userFavRef.document(collId).delete() { _ in
                    completion()
            }
        }
        
    }
}

