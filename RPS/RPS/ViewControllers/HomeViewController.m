//
//  HomeViewController.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "HomeViewController.h"
#import "GameViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGBCOLOR_A(6, 51, 68, 1)];
    
    session = [SessionSingleton sharedSessionSingleton];
    
    UIImageView *rulesImage = [[UIImageView alloc]initWithFrame:CGRectMake(session.utils.screenWidth/2-RULES_IMAGE_WIDTH/2, session.utils.screenHeight/2-RULES_IMAGE_HEIGHT/2-PLAY_BTN_HEIGHT/2-20, RULES_IMAGE_WIDTH, RULES_IMAGE_HEIGHT)];
    [rulesImage setImage:[UIImage imageNamed:@"rules.jpg"]];
    [rulesImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:rulesImage];
    
    UIButton *newGameButton = [[UIButton alloc]initWithFrame:CGRectMake(session.utils.screenWidth/2-PLAY_BTN_WIDTH/2,CGRectGetMaxY(rulesImage.frame)+10, PLAY_BTN_WIDTH, PLAY_BTN_HEIGHT)];
    [newGameButton.layer setCornerRadius:10];
    [newGameButton setBackgroundColor:UIColorFromRGBWithAlpha(0x4CD964, 1)];
    [newGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newGameButton setTitleColor:RGBCOLOR_A(255, 255, 255, 0.5) forState:UIControlStateHighlighted];
    [newGameButton setTitle:NSLocalizedString(@"NEW GAME", @"") forState:UIControlStateNormal];
    [newGameButton addTarget:self action:@selector(newGameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newGameButton];
}

-(void)newGameButtonPressed:(id)sender{
    GameViewController *gameView = [[GameViewController alloc]init];
    gameView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gameView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
