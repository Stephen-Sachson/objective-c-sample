//
//  RootViewController.h
//  Sample
//
//  Created by Stephen on 3/29/12.
//  Copyright silicon valley 2012. All rights reserved.
//
#import <CoreData/CoreData.h>
@class About;
@class FoodController;
@class MapController;
@class BookViewController;
@interface RootViewController : UITableViewController <UITextFieldDelegate>{
	About *about;
	FoodController *food;
	MapController *map;
	BookViewController *book;
	UITextField *text;
	UIAlertView *alert;
	NSString *kPIN;
	
}
@property (nonatomic, retain)About *about;
@property (nonatomic, retain)IBOutlet FoodController *food;
@property (nonatomic, retain)IBOutlet MapController *map;
@property (nonatomic, retain)IBOutlet BookViewController *book;

- (void)openAbout;
- (void)displayAlert;
- (void)showAlert;
- (int)randomGenerator;


@end
