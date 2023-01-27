//
//  UploadCollectionViewModel.swift
//  karma
//
//  Created by Tommaso Bucaioni on 29/12/22.
//

import Foundation
import SwiftUI
import Firebase

class UploadCollectionViewModel: ObservableObject {
    
    @Published var didUploadCollection = false
    
    var service : CollectionServiceProtocol
    
    init(service: CollectionServiceProtocol){
        self.service = service
    }
    
    func uploadCollection(withTitle title: String, withCaption caption: String, withAmount amount: Float, withImage image: UIImage) {
        ImageUploaderFactory.create().uploadCollectionImage(image: image) { collectionImageUrl in
            self.service.uploadCollection(title: title, caption: caption, amount: amount, image: collectionImageUrl) {
                success in
                if success {
                    self.didUploadCollection = true
                    
                    //dismiss screen somehow
                } else {
                    // show error message to user
                    print("Error: collection upload failed.")
                }
            }
        }
        
        
    }
    
}

