//
//  ImageUploaderMock.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation
import UIKit

class ImageUploaderMock : ImageUploaderProtocol {
    
    func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        
    }
    
    func uploadCollectionImage(image: UIImage, completion: @escaping(String) -> Void){
        print("Upload collection image")
    }
}
