//
//  karmaTests.swift
//  karmaTests
//
//  Created by Giovanni Demasi on 05/12/22.
//

import XCTest

import Firebase
@testable import karma
import FirebaseFirestore
var iteration : Int = 0

final class karmaTests: XCTestCase {
    var authVM : AuthViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.authVM = AuthViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.authVM = nil
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
        self.authVM.register(withEmail: "aaa@gmail.com", password: "TestTest1990!", fullname: "uno", username: "due")

        
        //XCTAssertEqual(sut.didAuthenticateUser, false)
    }
    
}
