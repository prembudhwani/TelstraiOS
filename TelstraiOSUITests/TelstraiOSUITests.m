//
//  TelstraiOSUITests.m
//  TelstraiOSUITests
//
//  Created by Prem Budhwani on 03/11/17.
//  Copyright © 2017 Telstra. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TelstraiOSUITests : XCTestCase

@end

@implementation TelstraiOSUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//UI test to check if there is one Refresh button in the navigationBar
- (void)testHasRightBarButtonItem
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertEqual([app.navigationBars elementBoundByIndex:0].buttons.count, 1);
}

//UI test to check if there is one TableView
- (void)testHasTableView
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertEqual(app.tables.count , 1);
}

//Unit test to check if there is one ActivityIndicatorView
- (void)testHasActivityIndicatorView
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCTAssertEqual(app.activityIndicators.count , 1);
}

@end
