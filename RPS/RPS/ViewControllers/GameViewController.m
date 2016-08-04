//
//  GameViewController.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    session = [SessionSingleton sharedSessionSingleton];
    
    self.title = NSLocalizedString(@"RUN !", @"");
    
    UILabel *computeurTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 64, session.utils.screenWidth-20, 20)];
    [computeurTitle setTextAlignment:NSTextAlignmentRight];
    [computeurTitle setText:NSLocalizedString(@"PLAYER 1", @"")];
    [self.view addSubview:computeurTitle];
    
    UILabel *computeurRounds = [[UILabel alloc]initWithFrame:CGRectMake(session.utils.screenWidth-110, CGRectGetMaxY(computeurTitle.frame), 100, 20)];
    [computeurRounds setText:NSLocalizedString(@"ROUNDS", @"")];
    [computeurRounds setTextAlignment:NSTextAlignmentRight];
    [computeurRounds setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]-2]];
    [self.view addSubview:computeurRounds];
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
