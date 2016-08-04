//
//  Game+CoreDataProperties.h
//  RPS
//
//  Created by Jeremy on 04/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *won;
@property (nullable, nonatomic, retain) NSManagedObject *device;
@property (nullable, nonatomic, retain) Round *rounds;

@end

NS_ASSUME_NONNULL_END
