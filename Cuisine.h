//
//  Cuisine.h
//  Sample
//
//  Created by Stephen on 4/8/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Restaurant;

@interface Cuisine :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* restaurant;

@end


@interface Cuisine (CoreDataGeneratedAccessors)
- (void)addRestaurantObject:(Restaurant *)value;
- (void)removeRestaurantObject:(Restaurant *)value;
- (void)addRestaurant:(NSSet *)value;
- (void)removeRestaurant:(NSSet *)value;

@end

