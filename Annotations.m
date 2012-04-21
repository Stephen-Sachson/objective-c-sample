//
//  Annotations.m
//  Sample
//
//  Created by Stephen on 4/16/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "Annotations.h"


@implementation Annotations
@synthesize title, subTitle;
@synthesize coordinate;
- (id)init {
	if (self=[super init]) {
	}
	return self;
}

- (NSString *)title {
	if (title==nil) return @"Unknown";
	return title;
}

- (NSString *)subtitle {
    return subTitle;
}
@end
