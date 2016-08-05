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
    
    computerRoundViews = [[NSMutableArray alloc]init];
    playerRoundViews = [[NSMutableArray alloc]init];
    
    computeurTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 64, session.utils.screenWidth-20, 20)];
    [computeurTitle setTextAlignment:NSTextAlignmentRight];
    [computeurTitle setText:NSLocalizedString(@"COMPUTER", @"")];
    [self.view addSubview:computeurTitle];
    
    UILabel *computeurRounds = [[UILabel alloc]initWithFrame:CGRectMake(session.utils.screenWidth-110, CGRectGetMaxY(computeurTitle.frame), 100, 20)];
    [computeurRounds setText:NSLocalizedString(@"ROUNDS", @"")];
    [computeurRounds setTextAlignment:NSTextAlignmentRight];
    [computeurRounds setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]-2]];
    [self.view addSubview:computeurRounds];
    
    //views to display rounds won by computer
    for (int i=0; i<NB_ROUNDS; i++) {
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(10+i*(ROUND_SIZE+5),CGRectGetMinY(computeurRounds.frame)+(computeurRounds.frame.size.height/2-ROUND_SIZE/2),ROUND_SIZE,ROUND_SIZE)];
        [roundView.layer setBorderWidth:1];
        [roundView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [roundView.layer setCornerRadius:roundView.layer.frame.size.width/2];
        roundView.tag = i ;
        [self.view addSubview:roundView];
        [computerRoundViews addObject:roundView];
    }
    
     playerTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, session.utils.screenHeight-HAND_SIZE-40, session.utils.screenWidth-20, 20)];
    [playerTitle setTextAlignment:NSTextAlignmentLeft];
    [playerTitle setText:NSLocalizedString(@"PLAYER 1", @"")];
    [self.view addSubview:playerTitle];
    
    UILabel *playerRounds = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(playerTitle.frame)-20, 100, 20)];
    [playerRounds setText:NSLocalizedString(@"ROUNDS", @"")];
    [playerRounds setTextAlignment:NSTextAlignmentLeft];
    [playerRounds setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]-2]];
    [self.view addSubview:playerRounds];
    
    //views to display rounds won by player
    for (int i=0; i<NB_ROUNDS; i++) {
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(session.utils.screenWidth-ROUND_SIZE*NB_ROUNDS-30 +i*(ROUND_SIZE+5),CGRectGetMinY(playerRounds.frame)+(computeurRounds.frame.size.height/2-ROUND_SIZE/2),ROUND_SIZE,ROUND_SIZE)];
        [roundView.layer setBorderWidth:1];
        [roundView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [roundView.layer setCornerRadius:roundView.layer.frame.size.width/2];
        roundView.tag = NB_ROUNDS+i ;
        [self.view addSubview:roundView];
        [playerRoundViews addObject:roundView];
    }
    
    //Fight Zone:
    computeurChoice = [[UIImageView alloc]initWithFrame:CGRectMake(session.utils.screenWidth/2-10-HAND_SIZE, session.utils.screenHeight/2-HAND_SIZE, HAND_SIZE, HAND_SIZE)];
    [computeurChoice.layer setCornerRadius:HAND_SIZE/2];
    [computeurChoice setClipsToBounds:YES];
    [computeurChoice.layer setBorderWidth:1];
    [computeurChoice.layer setBorderColor:[UIColor redColor].CGColor];
    [computeurChoice setContentMode:UIViewContentModeScaleAspectFill];
    [computeurChoice setImage:[UIImage imageNamed:@"qmark"]];
    [computeurChoice.layer setMasksToBounds:YES];
    [self.view addSubview:computeurChoice];
    
    playerChoiceZone = [[UIView alloc]initWithFrame:CGRectMake(session.utils.screenWidth/2+10, session.utils.screenHeight/2, HAND_SIZE, HAND_SIZE)];
    [playerChoiceZone.layer setCornerRadius:HAND_SIZE/2];
    [playerChoiceZone.layer setBorderWidth:1];
    [playerChoiceZone.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.view addSubview:playerChoiceZone];
    
    //Views to display hands CHIFOUMI
    handsView = [[NSMutableArray alloc]init];
    float maxHandsWidth = HAND_SIZE*NB_HANDS+HAND_SPACING*(NB_HANDS-1);
    handX = session.utils.screenWidth/2-maxHandsWidth/2;
    handY = session.utils.screenHeight-HAND_SIZE-10;
    for (int i=0; i<NB_HANDS; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(handX+i*(HAND_SIZE+HAND_SPACING),handY,HAND_SIZE,HAND_SIZE)];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hand_%ld",(long)i]]];
        [imageView.layer setCornerRadius:HAND_SIZE/2];
        [imageView setClipsToBounds:YES];
        [imageView.layer setBorderWidth:1];
        [imageView.layer setBorderColor:[UIColor blackColor].CGColor];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView.layer setMasksToBounds:YES];
        imageView.tag=i;
        [self.view addSubview:imageView];
        [imageView setUserInteractionEnabled:YES];
        UIPanGestureRecognizer * recognizerGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handDragging:)];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTapped:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handDoubleTapped:)];
        doubleTap.numberOfTapsRequired=2;
        [imageView addGestureRecognizer:recognizerGesture];
        [imageView addGestureRecognizer:singleTap];
        [imageView addGestureRecognizer:doubleTap];
        [handsView addObject:imageView];
    }
    
    [self.view setMultipleTouchEnabled:NO];
    [self newGame];
}


/************
 ** Player moves
 ************/
#pragma mark handle hands moves or taps
- (void)handDragging:(UIPanGestureRecognizer *)recognizer  {
    UIImageView *handView = (UIImageView *)recognizer.view;
    [self highlightSelectedHand:handView.tag];
    handView.transform = CGAffineTransformIdentity;
    CGPoint translation = [recognizer translationInView:handView];
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if(handView.frame.origin.y>playerTitle.frame.origin.y){
            [UIView animateWithDuration: 0.3
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 handView.frame = CGRectMake(handX+handView.tag*(HAND_SIZE+HAND_SPACING),handY,HAND_SIZE,HAND_SIZE);
                             }completion:^(BOOL finished){
                             }];
             
        }
        else{
            [self playerHasMakeHisChoice:handView];
        }
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:handView];
    
}

-(void)handTapped:(UITapGestureRecognizer *)recognizer {
    UIImageView *handView = (UIImageView *)recognizer.view;
    [self highlightSelectedHand:handView.tag];
}

-(void)handDoubleTapped:(UITapGestureRecognizer *)recognizer {
    UIImageView *handView = (UIImageView *)recognizer.view;
    [self highlightSelectedHand:handView.tag];
    [self playerHasMakeHisChoice:handView];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [touches anyObject];
    DLog(@"Touched view  %@",[touch.view class] );
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        [self highlightSelectedHand:touch.view.tag];
    }
}

-(void)highlightSelectedHand:(NSInteger)index{
    for(UIImageView *h in handsView){
        if (h.tag==index) {
            [self.view bringSubviewToFront:h];
            [h.layer setBorderColor:[UIColor greenColor].CGColor];
        }
        else{
            [h.layer setBorderColor:[UIColor blackColor].CGColor];
        }
    }
}

/************
 ** Player Has Make His Choice but What next ?
 ************/
#pragma mark player has played
-(void)playerHasMakeHisChoice:(UIImageView *)handView{
    [self.view setUserInteractionEnabled:NO];
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         handView.frame = playerChoiceZone.frame;
                     }completion:^(BOOL finished){
                         RPSCode computerChoice = [ia generateChoice];
                         
                         [computeurChoice setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hand_%d",computerChoice]]];
                         
                         GResult roundResult = [ia determineWinner:computerChoice withPlayerChoice:(RPSCode)handView.tag];
                         
                         //if egality the round is null
                         if (roundResult==EGALITY) {
                             [self performSelector:@selector(newRound) withObject:nil afterDelay:2];
                         }
                         else{
                             [self affectRound:roundResult forRound:ia.roundIndex];
                             
                             ia.roundIndex++;
                             if (ia.gameComplet) {
                                 [self endGame];
                             }
                             else{
                                 [self performSelector:@selector(newRound) withObject:nil afterDelay:2];
                             }
                         }
                     }];
}

-(void)affectRound:(GResult)roundResult forRound:(NSInteger)roundIndex{
    switch (roundResult) {
        case WIN:
        {
            [((UIView*)[computerRoundViews objectAtIndex:roundIndex])setBackgroundColor:[UIColor redColor]];
            [((UIView*)[playerRoundViews objectAtIndex:roundIndex])setBackgroundColor:[UIColor greenColor]];
        }break;
        case LOOSE:
        {
            [((UIView*)[computerRoundViews objectAtIndex:roundIndex])setBackgroundColor:[UIColor greenColor]];
            [((UIView*)[playerRoundViews objectAtIndex:roundIndex])setBackgroundColor:[UIColor redColor]];
        }break;
        default:
            break;
    }
}

-(void)newGame{
    ia = [[ChiFouMiController alloc]init];
    for(UIView *v in computerRoundViews){
        [v setBackgroundColor:[UIColor clearColor]];
    }
    for(UIView *v in playerRoundViews){
        [v setBackgroundColor:[UIColor clearColor]];
    }
    [self newRound];
}

-(void)newRound{
    for (UIImageView *handView in handsView) {
        [UIView animateWithDuration: 0.1
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             handView.frame = CGRectMake(handX+handView.tag*(HAND_SIZE+HAND_SPACING),handY,HAND_SIZE,HAND_SIZE);
                         }completion:^(BOOL finished){
                             [computeurChoice setImage:[UIImage imageNamed:@"qmark"]];
                         }];
    }
    [self highlightSelectedHand:-1];
    [self.view setUserInteractionEnabled:YES];
}

-(void)endGame{
    GResult finalResult = [ia gameFinished];
    DLog(@"FINAL RESULT = %d",finalResult);
    NSString *alertMsg = @"";
    switch (finalResult) {
        case WIN:
            alertMsg = NSLocalizedString(@"YOU WIN", @"");
            break;
        case LOOSE:
            alertMsg = NSLocalizedString(@"YOU LOOSE", @"");
            break;
        default: // must never append
            alertMsg = NSLocalizedString(@"EGALITY", @"");
            break;
    }
    UIAlertView *finalAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"END GAME", @"") message:alertMsg delegate:self cancelButtonTitle:NSLocalizedString(@"STOP PLAYING", @"") otherButtonTitles:NSLocalizedString(@"PLAY AGAIN", @""), nil];
    finalAlert.tag = 998;
    [finalAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==998) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self newGame];
        }
    }
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
