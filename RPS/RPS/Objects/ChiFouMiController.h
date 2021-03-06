//
//  ChiFouMiController.h
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//
#import "SessionSingleton.h"
#import "Round.h"

#import <Foundation/Foundation.h>
#define NB_HANDS 3
#define NB_WIN_ROUNDS 3
#define NB_ROUNDS 5

#define NEXT_ROUND_WAIT 1

typedef enum{
    ROCK    = 0,
    PAPER   = 1,
    SCISSOR = 2
}RPSCode;

typedef enum{
    EGALITY    = 0,
    WIN   = 1,
    LOOSE = -1
}GResult;

@protocol ChiFouMiDelegate <NSObject>

@required
-(void)affectRound:(GResult)roundResult forRound:(NSInteger)roundIndex;
-(void)newRound;
-(void)endGame:(GResult)finalResult;
@optional

@end

@interface ChiFouMiController : NSObject
{
    NSInteger player1Score;
    NSInteger player2Score;
}
@property (nonatomic)BOOL gameComplet;
@property (nonatomic)NSInteger roundIndex;
@property (nonatomic,strong)Game *currentGame;

@property (nonatomic)UIViewController<ChiFouMiDelegate> *delegate;

-(RPSCode)generateChoice;
-(GResult)determineWinner:(RPSCode)computerCode withPlayerChoice:(RPSCode)playerCode;
-(GResult)gameFinished;
@end
