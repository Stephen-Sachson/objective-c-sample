//
//  BookViewController.h
//  Sample
//
//  Created by Stephen on 4/8/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Restaurant.h"
#import "Cuisine.h"

@interface BookViewController : UITableViewController <UITextFieldDelegate,UIActionSheetDelegate>{
	NSManagedObjectContext *managedObjectContext;
	UIBarButtonItem *addButton;
	UIView *aView;
	UILabel *label1;
	UILabel *label2;
	UITextField *text1;
	UITextField *text2;
	UISegmentedControl *segCtrl;
	NSMutableArray *array,*array1;
	NSInteger integer;
	UIActionSheet *sheet;
	NSString *string,*string1;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) IBOutlet UIView *aView;
@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UILabel *label2;
@property (nonatomic, retain) IBOutlet UITextField *text1;
@property (nonatomic, retain) IBOutlet UITextField *text2;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segCtrl;
@property (nonatomic, retain) NSMutableArray *array,*array1;
- (IBAction) doneButtonPushed;
@end
