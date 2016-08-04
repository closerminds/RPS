//
//  HomeViewController.h
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionSingleton.h"

#define RULES_IMAGE_WIDTH 300
#define RULES_IMAGE_HEIGHT 300

#define PLAY_BTN_WIDTH 150
#define PLAY_BTN_HEIGHT 50

@interface HomeViewController : UIViewController
{
    SessionSingleton *session;
}
@end
