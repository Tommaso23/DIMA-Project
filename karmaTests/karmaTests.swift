//
//  karmaTests.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest

@testable import karma
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class karmaTests: XCTestCase {
    var uploadCollectionVM : UploadCollectionViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
//        let appOptions = FirebaseOptions(
//                    googleAppID: "1:774454406954:ios:29b746b4e87fd351677853",
//                    gcmSenderID: "774454406954"
//                )
//                appOptions.apiKey = "AIzaSyBNJrBaHVFFDFz-pIiUrgXmmIfNFUTmg6I"
//                appOptions.projectID = "dima-project-7bd5f"
//        FirebaseApp.configure()
//        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
//        //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
//        let settings = Firestore.firestore().settings
//        settings.host = "127.0.0.1:8080"
//        settings.isPersistenceEnabled = false
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
        
        uploadCollectionVM = UploadCollectionViewModel(service: CollectionServiceFactory.create())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        //self.measure {
        // Put the code you want to measure the time of here.
        //}
    }
    
    func testRandom () throws{
        uploadCollectionVM.uploadCollection(withTitle: "Title", withCaption: "Caption", withAmount: 20000, withImage: UIImage())
    }
    
}
