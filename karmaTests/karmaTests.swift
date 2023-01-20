//
//  karmaTests.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest
@testable import karma
import Firebase
import FirebaseFirestore
var iteration : Int = 0

final class karmaTests: XCTestCase {
    
    override func setUpWithError() throws {
#if EMULATORS
        
        iteration += 1
        print(">> Testing on Emulators <<")
#endif
        if(iteration == 1){
            FirebaseApp.configure()
            Auth.auth().useEmulator(withHost: "localhost", port: 9099)
            //Firestore.firestore().useEmulator(withHost: "127.0.0.1", port: 8080)
            let settings = Firestore.firestore().settings
            settings.host = "localhost:8080"
            settings.isPersistenceEnabled = false
            settings.isSSLEnabled = false
            Firestore.firestore().settings = settings}
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        let sut = AuthViewModel()
        sut.register(withEmail: "example@gmail.com", password: "example", fullname: "example", username: "example")
        XCTAssertEqual(sut.didAuthenticateUser, false)
    }
    
}
