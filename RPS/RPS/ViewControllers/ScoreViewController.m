//
//  ScoreViewController.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "ScoreViewController.h"
#import "ScoreTableViewCell.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR_A(6, 51, 68, 1)];
    
    session = [SessionSingleton sharedSessionSingleton];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, session.utils.screenWidth, session.utils.screenHeight) style:UITableViewStylePlain];
    myTableView.delegate= self;
    myTableView.dataSource = self;
    [myTableView setSeparatorColor:[UIColor whiteColor]];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:myTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    //remove badge from tabbar
    [[[self.tabBarController tabBar]items] objectAtIndex:self.tabBarController.selectedIndex].badgeValue = nil;
    [self reloadData];
}

-(void)reloadData{
    games = [[NSMutableArray alloc]init];
    if([session device].games && [session device].games.count>0){
        games = [[[session device].games sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]]mutableCopy];
    }
    [myTableView reloadData];
}

/*******************
 * tableview
 *********************/
#pragma mark tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *identifier = [NSString stringWithFormat:@"Cell%ld",(long)row];
    ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if([[games objectAtIndex:row] rounds].count>row){
        [cell updateRow:[games objectAtIndex:row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    CGFloat cellHeight = CELL_HEADER_HEIGHT+CELL_SUB_HEADER_HEIGHT+5;
    if([[games objectAtIndex:row] rounds]){
        cellHeight+=CELL_ROUND_HEIGHT*[[games objectAtIndex:row] rounds].count;
    }
    return cellHeight;
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
