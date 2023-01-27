//
//  AuthProtocol.swift
//  karma
//
//  Created by Giovanni Demasi on 26/01/23.
//

import Foundation
import Firebase

protocol FirestoreProtocol {
    func collection(_ collectionPath: String) -> CollectionReferenceMock
}
