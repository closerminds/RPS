//
//  Device+CoreDataProperties.h
//  RPS
//
//  Created by Jeremy on 05/08/2016.
//  Copyright © 2016 Jeremy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Device.h"

NS_ASSUME_NONNULL_BEGIN

@interface Device (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *iddevice;
@property (nullable, nonatomic, retain) NSSet<Game *> *games;

@end

@interface Device (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet<Game *> *)values;
- (void)removeGames:(NSSet<Game *> *)values;

@end

NS_ASSUME_NONNULL_END
