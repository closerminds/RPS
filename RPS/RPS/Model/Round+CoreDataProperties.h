//
//  Round+CoreDataProperties.h
//  RPS
//
//  Created by Jeremy on 05/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Round.h"
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Round (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *player1Choice;
@property (nullable, nonatomic, retain) NSNumber *player2Choice;
@property (nullable, nonatomic, retain) NSNumber *result;
@property (nullable, nonatomic, retain) Game *game;

@end

NS_ASSUME_NONNULL_END
