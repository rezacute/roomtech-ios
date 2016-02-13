//
//  houzieTests.swift
//  houzieTests
//
//  Created by syahRiza on 2/8/16.
//  Copyright © 2016 roomtech. All rights reserved.
//

import XCTest
@testable import houzie

class houzieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        /**
         MXCredentials *credentials = [[MXCredentials alloc] initWithHomeServer:@"http://matrix.org"
         userId:@"@your_user_id:matrix.org"
         accessToken:@"your_access_tokem"];
         
         // Create a matrix session
         MXRestClient *mxRestClient = [[MXRestClient alloc] initWithCredentials:credentials];
         
         // Create a matrix session
         MXSession *mxSession = [[MXSession alloc] initWithMatrixRestClient:mxRestClient];
         
         // Launch mxSession: it will first make an initial sync with the home server
         // Then it will listen to new coming events and update its data
         [mxSession start:^{
         
         // mxSession is ready to be used
         // Now we can get all rooms with:
         mxSession.rooms;
         
         } failure:^(NSError *error) {
         }];
*/
        let homeserver = "http://www.roomtech.io:8008"
        let expectation = self.expectationWithDescription("high")
        let credentials = MXCredentials(homeServer: homeserver, userId: "@riza:localhost", accessToken: "MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjJjaWQgdXNlcl9pZCA9IEByaXphOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAxZGNpZCB0aW1lIDwgMTQ1NDc3NjA2OTczNAowMDJmc2lnbmF0dXJlIF5TWbxwDikyXTyIqAQsG2wyvEXOZVQPEPOODKe11MoBCg")
        let client = MXRestClient(credentials: credentials) { (datas) -> Bool in
            return true
        }
        let mxSession = MXSession(matrixRestClient: client)
        mxSession.start({ () -> Void in
            print("",mxSession.rooms().count)
            expectation.fulfill()
            //
            }) { (error ) -> Void in
                
                print(error.localizedDescription)
                expectation.fulfill()
        }

        self.waitForExpectationsWithTimeout(30.0) { (error ) -> Void in
            print("error")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
