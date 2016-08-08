//
//  ChiFouMiController.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "ChiFouMiController.h"

@implementation ChiFouMiController
@synthesize roundIndex;
@synthesize currentGame;
@synthesize gameComplet;
@synthesize delegate;

-(id)init{
    self = [super init];
    if (self) {
        roundIndex = 0;
        player1Score = 0;
        player2Score = 0;
        gameComplet = NO;
        currentGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[[SessionSingleton sharedSessionSingleton].appDelegate managedObjectContext]];
    }
    return self;
}

-(RPSCode)generateChoice{
    return  (arc4random() % NB_HANDS);
}

-(GResult)determineWinner:(RPSCode)computerCode withPlayerChoice:(RPSCode)playerCode{
    GResult result ;
    if (computerCode==playerCode) {
        result = EGALITY;
    }
    else if ((computerCode>0 && computerCode-1==playerCode) || (computerCode==0 && playerCode==(NB_HANDS-1))){
        result = LOOSE;
        player1Score ++;
    }
    else{
        result = WIN;
        player2Score ++;
    }
    
    Round *newRound = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[[SessionSingleton sharedSessionSingleton].appDelegate managedObjectContext]];
    [newRound setPlayer1Choice:[NSNumber numberWithInteger:computerCode]];
    [newRound setPlayer2Choice:[NSNumber numberWithInteger:playerCode]];
    [newRound setResult:[NSNumber numberWithInteger:result]];
    [newRound setGame:currentGame];
    
    if(player1Score == NB_WIN_ROUNDS || player2Score == NB_WIN_ROUNDS){
        gameComplet = YES;
    }
    
    if(delegate){
        if([delegate respondsToSelector:@selector(affectRound:forRound:)]){
           [delegate affectRound:result forRound:roundIndex];
        }
        if (gameComplet && [delegate respondsToSelector:@selector(endGame:)]) {
            [delegate endGame:[self gameFinished]];
        }
        else{
            if([delegate respondsToSelector:@selector(newRound)]){
                [delegate performSelector:@selector(newRound) withObject:nil afterDelay:([SessionSingleton sharedSessionSingleton].enableAnimations?NEXT_ROUND_WAIT:0)];
            }
        }
    }
    
    //if egality the round is null
    if (result!=EGALITY) {
        roundIndex++;
    }

    return result;
}

-(GResult)gameFinished{
    NSInteger roundWinded = 0;
    for (Round *r in [currentGame.rounds allObjects]) {
        roundWinded+=[r.result integerValue];
    }
    GResult gameResult = (roundWinded>0?WIN:roundWinded<0?LOOSE:EGALITY);
    [currentGame setWon:[NSNumber numberWithInteger:gameResult]];
    [currentGame setDate:[NSDate date]];
    [currentGame setDevice:[SessionSingleton sharedSessionSingleton].device];
    NSError *error = nil;
    if (![[[SessionSingleton sharedSessionSingleton].appDelegate managedObjectContext] save:&error]) {
        DLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NEW_SCORE_CAN_DISPLAY" object:nil];
    return gameResult;
}

@end
