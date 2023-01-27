//
//  DocumentSnapshotmock.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore



class DocumentSnapshotMock {
    var dataa: [String: Any]?
    
    init(data: [String: Any]?) {
        self.dataa = data
    }
    
    func data() -> [String: Any]? {
        return dataa
    }
}

