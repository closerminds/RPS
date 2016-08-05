//
//  RPSTests.m
//  RPSTests
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SessionSingleton.h"
#import "ChiFouMiController.h"
@interface RPSTests : XCTestCase

@end

@implementation RPSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/***********
 * Test on DB
 ***********/
-(void)testLoadCoreData{
    XCTAssertNotNil([[SessionSingleton sharedSessionSingleton]loadExistingData] , @"check if core data load correctly");
}


/***********
 * Test algo winner on a round
 ***********/
-(void)testWinner{
    ChiFouMiController *ia = [[ChiFouMiController alloc]init];
    RPSCode computer = [ia generateChoice];
    RPSCode player = [ia generateChoice];
    NSLog(@"MATCH COMPUTER Choose : %d VS PLAYER Choose :%d",computer,player);
    GResult result = [ia determineWinner:computer withPlayerChoice:player];
    NSLog(@"RESULT : %d",result);
    
    switch (computer) {
        case ROCK:
        {
            switch (player) {
                case ROCK:
                    XCTAssertTrue(result == EGALITY);
                    break;
                case PAPER:
                    XCTAssertTrue(result == WIN);
                    break;
                default:
                    XCTAssertTrue(result == LOOSE);
                    break;
            }
            
        }break;
        case PAPER:
        {
            switch (player) {
                case PAPER:
                    XCTAssertTrue(result == EGALITY);
                    break;
                case SCISSOR:
                    XCTAssertTrue(result == WIN);
                    break;
                default:
                    XCTAssertTrue(result == LOOSE);
                    break;
            }
        }break;
        case SCISSOR:
        {
            switch (player) {
                case SCISSOR:
                    XCTAssertTrue(result == EGALITY);
                    break;
                case ROCK:
                    XCTAssertTrue(result == WIN);
                    break;
                default:
                    XCTAssertTrue(result == LOOSE);
                    break;
            }
        }break;
        default:
            break;
    }
    ia=nil;
}

/***********
 * Test algo winner on a game with 5 rounds
 ***********/
-(void)testFullGame{
    ChiFouMiController *ia = [[ChiFouMiController alloc]init];
    for (int i=0; i<NB_ROUNDS; i++) {
        RPSCode computer = [ia generateChoice];
        RPSCode player = [ia generateChoice];
        NSLog(@"MATCH COMPUTER Choose : %d VS PLAYER Choose :%d",computer,player);
        GResult result = [ia determineWinner:computer withPlayerChoice:player];
        NSLog(@"RESULT : %d",result);
    }
    GResult final = [ia gameFinished];
    NSLog(@"GAME RESULT : %d",final);
    
    XCTAssertTrue(final==WIN || final == LOOSE || final == EGALITY);
    
    //test if current game has well initialized
    XCTAssertTrue(ia.currentGame.rounds);
    XCTAssertTrue(ia.currentGame.date);
    XCTAssertTrue(ia.currentGame.won);
    XCTAssertTrue(ia.currentGame.device);
    
    //test if all rounds are recorded
    XCTAssertTrue(ia.currentGame.rounds.count == NB_ROUNDS);
}

@end
