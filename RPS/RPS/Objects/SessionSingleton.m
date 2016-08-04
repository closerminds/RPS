//
//  SessionSingleton.m
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//

#import "SessionSingleton.h"

@implementation SessionSingleton
@synthesize appDelegate;
@synthesize device;

-(id)init{
    self = [super init];
    if (self) {
        self.utils = [[UtilsObject alloc]init];
        appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [self loadExistingData];
    }
    return self;
}

-(Device *)loadExistingData{
    NSInteger idDevice = [[NSUserDefaults standardUserDefaults]integerForKey:@"iddevice"];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %d",idDevice];
    [fetchRequest setPredicate:predicate];
    NSMutableArray *results = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if (results.count>0) {
        device = [results objectAtIndex:0];
    }
    else{
        device = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:[appDelegate managedObjectContext]];
        idDevice = [[NSDate date] timeIntervalSince1970];
        [device  setValue:[NSNumber numberWithInteger:idDevice] forKey:@"id"];
        NSError *error = nil;
        // Save the object to persistent store
        if (![[appDelegate managedObjectContext] save:&error]) {
            DLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else{
            [[NSUserDefaults standardUserDefaults]setInteger:idDevice forKey:@"iddevice"];
        }
    }
    return device;
}

SYNTHESIZE_SINGLETON_FOR_CLASS(SessionSingleton);
@end
