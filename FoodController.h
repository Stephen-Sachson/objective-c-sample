//
//  FoodController.h
//  Sample
//
//  Created by Stephen on 4/1/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FoodController : UIViewController {
	UIToolbar *segBar,*segBar1,*segBar2;
	UISegmentedControl *segCtrl;
	UIBarButtonItem *item;
	UIView *aView;
	UIView *bView;
	BOOL hmm;
}
@property (nonatomic, retain)IBOutlet UIToolbar *segBar,*segBar1,*segBar2;
@property (nonatomic, retain)IBOutlet UIView *aView;
@property (nonatomic, retain)IBOutlet UIView *bView;
@end
