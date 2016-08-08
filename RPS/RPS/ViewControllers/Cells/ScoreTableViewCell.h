//
//  ScoreTableViewCell.h
//  RPS
//
//  Created by jeremy on 08/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreViewController.h"
#import "SessionSingleton.h"
#import "ChiFouMiController.h"


@interface ScoreTableViewCell : UITableViewCell
{
    SessionSingleton *session;
    UIImageView *statusImage;
    UILabel *titleCellLabel;
    UILabel *dateGameLabel;
}

-(void)updateRow:(Game*)game;
@end
