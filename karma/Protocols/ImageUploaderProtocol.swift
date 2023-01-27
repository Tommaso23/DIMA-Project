//
//  ImageUploaderProtocol.swift
//  karma
//
//  Created by Giovanni Demasi on 27/01/23.
//

import Foundation
import UIKit

protocol ImageUploaderProtocol {
    
    func uploadImage(image: UIImage, completion: @escaping(String) -> Void)
    
    func uploadCollectionImage(image: UIImage, completion: @escaping(String) -> Void)
}
