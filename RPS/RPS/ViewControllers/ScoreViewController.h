//
//  ScoreViewController.h
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionSingleton.h"
#import "Round.h"

#define RESULT_IMAGE_SIZE 20
#define CELL_HEADER_HEIGHT 40
#define CELL_SUB_HEADER_HEIGHT 20
#define CELL_ROUND_HEIGHT 30

#define COLOMN (session.utils.screenWidth/2-20)
#define LITTLE_HAND_SIZE 25
#define LITTLE_ROUND_SIZE 20

@interface ScoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    SessionSingleton *session;
    UITableView *myTableView;
    
    NSMutableArray *games;
}
@end
