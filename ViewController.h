//
//  ViewController.h
//  Sample
//
//  Created by Stephen on 4/9/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookViewController.h"

@interface ViewController : BookViewController <UIActionSheetDelegate>{
	NSInteger n;
	UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
@end
