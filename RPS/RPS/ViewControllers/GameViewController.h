//
//  GameViewController.h
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionSingleton.h"
#import "ChiFouMiController.h"

#define ROUND_SIZE 20
#define HAND_SPACING 20
#define HAND_SIZE 60

@interface GameViewController : UIViewController<UIAlertViewDelegate>
{
    SessionSingleton *session;
    UILabel *computeurTitle;
    UILabel *playerTitle;
    float handY;
    float handX;
    
    ChiFouMiController *ia;
    
    NSMutableArray *handsView;
    
    UIImageView *computeurChoice;
    UIView *playerChoiceZone;
    
    NSMutableArray *computerRoundViews;
    NSMutableArray *playerRoundViews;
}
@end
