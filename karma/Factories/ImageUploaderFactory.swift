//
//  ImageUploaderFactory.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation

class ImageUploaderFactory{
    static func create() -> ImageUploaderProtocol {
        let environment = ProcessInfo.processInfo.environment["unit_tests"]
        if environment == "true" {
            return ImageUploaderMock()
        }
        else {
            return ImageUploader() as! ImageUploaderProtocol
        }
    }
}
