//
//  ScoreTableViewCell.m
//  RPS
//
//  Created by jeremy on 08/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "ScoreTableViewCell.h"


@implementation ScoreTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundView:nil];
        [self setSelected:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor clearColor]];
        session = [SessionSingleton sharedSessionSingleton];
        
        
        statusImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CELL_HEADER_HEIGHT/2-RESULT_IMAGE_SIZE/2, RESULT_IMAGE_SIZE, RESULT_IMAGE_SIZE)];
        [self addSubview:statusImage];
        
        titleCellLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, session.utils.screenWidth-50-100, CELL_HEADER_HEIGHT)];
        [titleCellLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:titleCellLabel];
        
        dateGameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleCellLabel.frame), 0, 90, CELL_HEADER_HEIGHT)];
        [dateGameLabel setTextAlignment:NSTextAlignmentRight];
        [dateGameLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]-2]];
        [dateGameLabel setTextColor:[UIColor whiteColor]];
        [dateGameLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:dateGameLabel];
        
        UILabel *player1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_HEADER_HEIGHT, COLOMN, CELL_SUB_HEADER_HEIGHT)];
        [player1Label setText:NSLocalizedString(@"COMPUTER", @"")];
        [player1Label setTextAlignment:NSTextAlignmentCenter];
        [player1Label setAdjustsFontSizeToFitWidth:YES];
        [player1Label setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        [player1Label setTextColor:[UIColor whiteColor]];
        [player1Label setBackgroundColor:[UIColor blueColor]];
        [self addSubview:player1Label];
        
        UILabel *player2Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(player1Label.frame), CELL_HEADER_HEIGHT, COLOMN, CELL_SUB_HEADER_HEIGHT)];
        [player2Label setText:NSLocalizedString(@"PLAYER 1", @"")];
        [player2Label setTextAlignment:NSTextAlignmentCenter];
        [player2Label setAdjustsFontSizeToFitWidth:YES];
        [player2Label setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        [player2Label setBackgroundColor:[UIColor blackColor]];
        [player2Label setTextColor:[UIColor whiteColor]];
        [self addSubview:player2Label];
    }
    return self;
}

/**
 * Not Optimized
 */
-(void)updateRow:(Game*)game{
    for(UIView *v in self.subviews){
        if(v.tag==1){
            [v removeFromSuperview];
        }
    }
    
    [titleCellLabel setText:NSLocalizedString(([NSString stringWithFormat:@"CRESULT_%d",[game.won intValue]]), @"")];
    
    [statusImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"result_%d",[game.won intValue]]]];
    NSDate *d = game.date;
    if(d){
        NSTimeInterval nbDaysBetween = [session.utils daysBetweenDate:d andDate:[NSDate date]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        if(nbDaysBetween==0){
            [formatter setDateFormat:@"HH:mm"];
            [dateGameLabel setText:[formatter stringFromDate:d]];
        }
        else{
            if(nbDaysBetween==1){
                [formatter setDateFormat:NSLocalizedString(@"YESTERDAY", @"")];
            }
            else if(nbDaysBetween<7){
                [formatter setDateFormat:NSLocalizedString(@"WEEKFORMAT", @"")];
            }
            else{
                [formatter setDateFormat:NSLocalizedString(@"DATE_FORMAT", @"")];
            }
        }
        [dateGameLabel setText:[formatter stringFromDate:d]];
    }
    else{
        [dateGameLabel setText:@""];
    }
    
    
    NSMutableArray *rounds = [[[game rounds] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]]mutableCopy];
    
    NSInteger nbRounds=0;
    for (Round *r in rounds) {
        UIImageView *computeurChoice = [[UIImageView alloc]initWithFrame:CGRectMake(COLOMN/2-LITTLE_HAND_SIZE/2, CELL_HEADER_HEIGHT+CELL_SUB_HEADER_HEIGHT+CELL_ROUND_HEIGHT/2-LITTLE_HAND_SIZE/2+(nbRounds*CELL_ROUND_HEIGHT), LITTLE_HAND_SIZE, LITTLE_HAND_SIZE)];
        [computeurChoice.layer setCornerRadius:LITTLE_HAND_SIZE/2];
        [computeurChoice setClipsToBounds:YES];
        [computeurChoice.layer setBorderWidth:1];
        [computeurChoice.layer setBorderColor:[UIColor redColor].CGColor];
        [computeurChoice setContentMode:UIViewContentModeScaleAspectFill];
        [computeurChoice setImage:[UIImage imageNamed:[NSString stringWithFormat:@"computer_hand_%ld",[r.player1Choice integerValue]]]];
        [computeurChoice.layer setMasksToBounds:YES];
        computeurChoice.tag=1;
        [self addSubview:computeurChoice];
        
        UIImageView *player1Choice = [[UIImageView alloc]initWithFrame:CGRectMake(COLOMN+COLOMN/2-LITTLE_HAND_SIZE/2, CELL_HEADER_HEIGHT+CELL_SUB_HEADER_HEIGHT+CELL_ROUND_HEIGHT/2-LITTLE_HAND_SIZE/2+(nbRounds*CELL_ROUND_HEIGHT), LITTLE_HAND_SIZE, LITTLE_HAND_SIZE)];
        [player1Choice.layer setCornerRadius:LITTLE_HAND_SIZE/2];
        [player1Choice setClipsToBounds:YES];
        [player1Choice.layer setBorderWidth:1];
        [player1Choice.layer setBorderColor:[UIColor redColor].CGColor];
        [player1Choice setContentMode:UIViewContentModeScaleAspectFill];
        [player1Choice setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hand_%ld",[r.player2Choice integerValue]]]];
        [player1Choice.layer setMasksToBounds:YES];
        player1Choice.tag=1;
        [self addSubview:player1Choice];
        
        UIView *roundView = [[UIView alloc]initWithFrame:CGRectMake(2*COLOMN+40/2-LITTLE_ROUND_SIZE/2,CELL_HEADER_HEIGHT+CELL_SUB_HEADER_HEIGHT+(nbRounds*CELL_ROUND_HEIGHT)+CELL_ROUND_HEIGHT/2-LITTLE_ROUND_SIZE/2,LITTLE_ROUND_SIZE,LITTLE_ROUND_SIZE)];
        [roundView.layer setBorderWidth:1];
        [roundView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [roundView.layer setCornerRadius:roundView.layer.frame.size.width/2];
        roundView.tag=1;
        switch ([r.result integerValue]) {
            case WIN:
                [roundView setBackgroundColor:[UIColor greenColor]];
                break;
            case LOOSE:
                [roundView setBackgroundColor:[UIColor redColor]];
                break;
            default:
                [roundView setBackgroundColor:[UIColor lightGrayColor]];
                break;
        }
        
        [self addSubview:roundView];
        
        nbRounds ++;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
