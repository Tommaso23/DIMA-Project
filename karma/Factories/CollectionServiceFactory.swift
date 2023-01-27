//
//  FirebaseFatory.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation


class CollectionServiceFactory{
    static func create() -> CollectionServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["unit_tests"]
        if environment == "true" {
            return CollectionServiceMock()
        }
        else {
            return CollectionService()
        }
    }
}
