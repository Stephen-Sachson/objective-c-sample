//
//  Annotations.h
//  Sample
//
//  Created by Stephen on 4/16/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotations : NSObject <MKAnnotation>{
	NSString *title,*subTitle;
	CLLocationCoordinate2D coordinate;
}
@property (nonatomic, retain) NSString *title, *subTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (NSString *)title;
- (NSString *)subtitle;

@end
