//
//  Restaurant.h
//  Sample
//
//  Created by Stephen on 4/13/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Cuisine;

@interface Restaurant :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * contact;
@property (nonatomic, retain) NSString * ad;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* cuisine;

@end


@interface Restaurant (CoreDataGeneratedAccessors)
- (void)addCuisineObject:(Cuisine *)value;
- (void)removeCuisineObject:(Cuisine *)value;
- (void)addCuisine:(NSSet *)value;
- (void)removeCuisine:(NSSet *)value;

@end

