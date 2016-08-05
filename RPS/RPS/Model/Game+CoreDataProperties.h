//
//  Game+CoreDataProperties.h
//  RPS
//
//  Created by Jeremy on 05/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Game.h"
#import "Device.h"
NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *won;
@property (nullable, nonatomic, retain) Device *device;
@property (nullable, nonatomic, retain) NSSet<Round *> *rounds;

@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addRoundsObject:(Round *)value;
- (void)removeRoundsObject:(Round *)value;
- (void)addRounds:(NSSet<Round *> *)values;
- (void)removeRounds:(NSSet<Round *> *)values;

@end

NS_ASSUME_NONNULL_END
