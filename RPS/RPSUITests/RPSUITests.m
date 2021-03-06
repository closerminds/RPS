//
//  RPSUITests.m
//  RPSUITests
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RPSUITests : XCTestCase

@end

@implementation RPSUITests

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

- (void)testFullGameUI {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [app.buttons[@"New Game"] tap];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    XCUIElement *hand0Image = app.images[@"hand_0"];
    [hand0Image tap];
    [hand0Image tap];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    XCUIElement *hand1Image = app.images[@"hand_1"];
    [hand1Image tap];
    [hand1Image tap];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    XCUIElement *hand2Image = app.images[@"hand_2"];
    [hand2Image tap];
    [hand2Image tap];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    while(!app.alerts[@"End of the game !"].exists){
        [hand0Image tap];
        [hand0Image tap];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    
    [app.alerts[@"End of the game !"].collectionViews.buttons[@"Exit"] tap];
    [app.tabBars.buttons[@"Scores"] tap];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}

@end
