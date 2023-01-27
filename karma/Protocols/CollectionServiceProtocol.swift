//
//  UserServiceProtocol.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation

protocol CollectionServiceProtocol {
    
    func uploadCollection(title: String, caption: String, amount: Float, image: String, completion: @escaping(Bool) -> Void)
    
    func fetchCollections(completion: @escaping([Collection]) -> Void)
    
    func fetchCollections(forUid uid: String, completion: @escaping([Collection]) -> Void)
    
    func addToFavourite(_ collection: Collection, completion: @escaping() -> Void)
    
    func checkIfUserlikedCollection(_ collection: Collection, completion: @escaping(Bool) -> Void)
    
    func removeFromFavourite(_ collection: Collection, completion: @escaping() -> Void)
}
