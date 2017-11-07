//
//  TelstraiOSTests.m
//  TelstraiOSTests
//
//  Created by Prem Budhwani on 03/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import "RestAPICommunicator.h"
#import "FactBuilder.h"
#import "Fact+CoreDataProperties.h"


@interface TelstraiOSTests : XCTestCase

@end

@implementation TelstraiOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//Unit test to check if the tableview has been initialized
- (void)testInitTableView{
    HomeViewController *hvc = [[HomeViewController alloc]init];
    [hvc view];
    XCTAssertNotNil(hvc.tableView);
}

//Unit test to check if the ActivityIndicatorView has been initialized
- (void)testInitActivityIndicatorView
{
    HomeViewController *hvc = [[HomeViewController alloc]init];
    [hvc view];
    XCTAssertNotNil(hvc.loaderView);
}

//Unit test to check if RestAPICommunicator is working successfully
- (void)testRestAPICommunicator
{
    //Expectation
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing RestAPICommunicator fetchDataFromURL Method Works!"];
    
    RestAPICommunicator *webServiceObj = [[RestAPICommunicator alloc]init];
    [webServiceObj fetchDataFromURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json" completionHandler:^(NSDictionary *dictionaryDataObject, NSError *error) {
        XCTAssertNotNil(dictionaryDataObject);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", [error localizedDescription]);
        }
        
    }];
}

//Unit test to check if FactBuilder is working successfully and can generate the core data objects
- (void)testFactBuilder
{
    //Expectation
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing FactBuilder BuildFactFromDictionary Method Works!"];
    
    RestAPICommunicator *webServiceObject = [[RestAPICommunicator alloc]init];
    [webServiceObject fetchDataFromURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json" completionHandler:^(NSDictionary *dictionaryDataObject, NSError *error) {
        if (dictionaryDataObject != nil && error == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                Fact *factToShow = [FactBuilder BuildFactFromDictionary:dictionaryDataObject];
                XCTAssertNotNil(factToShow);
                [expectation fulfill];
            });
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", [error localizedDescription]);
        }
        
    }];
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/
@end
