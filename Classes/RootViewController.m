//
//  RootViewController.m
//  Sample
//
//  Created by Stephen on 3/29/12.
//  Copyright silicon valley 2012. All rights reserved.
//

#import "RootViewController.h"
#import "SampleAppDelegate.h"
#import "About.h"
#import "FoodController.h"
#import "MapController.h"
#import "BookViewController.h"
#import "extra.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation RootViewController
@synthesize about;
@synthesize food;
@synthesize map;
@synthesize book;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *image=[UIImage imageNamed:@"beijing.png"];
	self.navigationItem.titleView=[[[UIImageView alloc] initWithImage:image] autorelease];
    self.title=NSLocalizedString(@"Back2Main", @"Navigation Bar Button");
	self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"About",@"About Button")]
																		   style:UIBarButtonItemStylePlain 
																		  target:self action:@selector(openAbout)]
																			autorelease];
	self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.png"]];
	self.tableView.opaque=NO;
	SampleAppDelegate *appDelegate=(SampleAppDelegate *)[[UIApplication sharedApplication] delegate];
	if ([((NSNumber *)[appDelegate.indexNum objectAtIndex:0]) intValue]!=-1) {
		NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[[appDelegate.indexNum objectAtIndex:1] intValue] 
												  inSection:[[appDelegate.indexNum objectAtIndex:0] intValue]];
		[self tableView:((UITableView *) self.tableView) didSelectRowAtIndexPath:indexPath];
	}
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)openAbout {
	about=[[About alloc] initWithString:NSLocalizedString(@" </p><p>Copyright© 2012 Stephen Sachson</p><p> All rights reserved.",@"Copyright declare")];
	[self presentModalViewController:about animated:YES];
	[about release];
}

- (int)randomGenerator {
	srand((unsigned)time(NULL));
	int i;
	i=rand();
	return i;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	SampleAppDelegate *appDelegate=(SampleAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.indexNum replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:-1]];
	[appDelegate.indexNum replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:-1]];
    kPIN=[[NSString alloc] initWithFormat:@"%i",[self randomGenerator]];
	NSLog(kPIN);
	[self showAlert];
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */
- (void) displayAlert {
	UIAlertView *_alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Reminder",@"Alert title") message:NSLocalizedString(@"Sorry, this function is not currently available.",@"message")
									delegate:self cancelButtonTitle:NSLocalizedString(@"Alright", @"Cancel Button") otherButtonTitles:NSLocalizedString(@"Drat!",@"Cancel Button 2"),nil];
	[_alert show];
	[_alert release];
	
}
- (void)showAlert {
	alert=[[UIAlertView alloc] initWithTitle:@"Obtain Permission" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
	
	text=[[UITextField alloc] initWithFrame:CGRectMake(12.0, 42.0, 260.0, 25.0)];
	text.placeholder=@"Enter Password";
	text.delegate=self;
	text.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
	//[text becomeFirstResponder];
	[text setBackgroundColor:[UIColor whiteColor]];
	text.textAlignment=UITextAlignmentCenter;
	text.layer.cornerRadius=5.0; 
	[alert addSubview:text];
	[alert show];
	[alert release];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([text isFirstResponder]) [text resignFirstResponder];
	if ([text.text isEqualToString:kPIN]) 
		[alert dismissWithClickedButtonIndex:0 animated:YES];
	else {
		text.text=nil;
		text.placeholder=@"Incorrect, Try Again";
	}

	return YES;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
		case 0:
			return 3;
			break;
		case 1:
			return 2;
			break;
		default:
			return 0;
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:NSLocalizedString(@"Resturant",@"Section Header")];
			break;
		case 1:
			return [NSString stringWithFormat:NSLocalizedString(@"Hotel", @"Section Header 2")];
			break;

		default:
			return nil;
			break;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:NSLocalizedString(@"Have a really feast", @"Section Footer")];
			break;
		case 1:
			return [NSString stringWithFormat:NSLocalizedString(@"Take a break", @"Section Footer 2")];
			break;
			
		default:
			return nil;
			break;
	}
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellIdentifier] autorelease];
    
    
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	
	CGRect frame=cell.contentView.frame;
    frame.origin.y+=3;
	
	UILabel *label=[[UILabel alloc] initWithFrame:frame];
	label.textColor=[UIColor brownColor];
	label.highlightedTextColor=[UIColor yellowColor];
	label.font=[UIFont boldSystemFontOfSize:18];
	label.backgroundColor=[UIColor clearColor];
	if(indexPath.section==0) {
	switch (indexPath.row) {
		case 0:
			label.text=NSLocalizedString(@"   Food", @"Cell");
			break;
		case 1:
			label.text=NSLocalizedString( @"   Location", @"Cell 2");
			break;
		case 2:
			label.text=NSLocalizedString( @"   Book",@"Cell 3");
			break;


		default:
			break;
	}
	}
	else if(indexPath.section==1) {
		switch (indexPath.row) {
			case 0:
				label.text=NSLocalizedString( @"   Location",@"Cell 2");
				break;
			case 1:
				label.text=NSLocalizedString( @"   Book",@"Cell 3");
				break;

			default:
				break;
		}
	}
	[cell.contentView addSubview:label];
	frame.origin.x+=100;
	frame.size.width-=100;
	UILabel *_label=[[UILabel alloc] initWithFrame:frame];
	_label.textColor=[UIColor grayColor];
	_label.highlightedTextColor=[UIColor whiteColor];
	_label.backgroundColor=[UIColor clearColor];
	_label.font=[UIFont italicSystemFontOfSize:15];
	if(indexPath.section==0) {
		switch (indexPath.row) {
			case 0:
				_label.text=NSLocalizedString( @"stimulate your tongue",@"Description");
				break;
			case 1:
				_label.text=NSLocalizedString( @"find your way", @"Description 2");
				break;
			case 2:
				_label.text=NSLocalizedString( @"let's go", @"Description 3");
				break;


			default:
				break;
		}
	}
	else if (indexPath.section==1) {
		switch (indexPath.row) {
			case 0:
				_label.text=NSLocalizedString( @"where is it", @"Description 4");
				break;
			case 1:
				_label.text=NSLocalizedString( @"hurry, no room for ya", @"Description 5");
				break;

			default:
				break;
		}
	}
	[cell.contentView addSubview:_label];
	[label release];
	[_label release];
	}

    return cell;
	
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SampleAppDelegate *appDelegate=(SampleAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate.indexNum replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:indexPath.section]];
	[appDelegate.indexNum replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:indexPath.row]];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if (indexPath.section==0) {
		switch (indexPath.row) {
			case 0:
				[self.navigationController pushViewController:food animated:YES];
				break;
			case 1:
				[self.navigationController pushViewController:map animated:YES];
				break;
			case 2:
				[self.navigationController pushViewController:book animated:YES];
				break;

			default:
				break;
		}
		
	}
	else {
		switch (indexPath.row) {
			case 0:
				if([[NSUserDefaults standardUserDefaults] boolForKey:@"activate"]) {
					Extra *extra=[[Extra alloc] initWithName:NSLocalizedString( @"Location",@"Cell 2")];
					[self.navigationController pushViewController:extra animated:YES];
				}
				else
				[self displayAlert];
				break;
			case 1:
				if([[NSUserDefaults standardUserDefaults] boolForKey:@"activate"]) {
					Extra *_extra=[[Extra alloc] initWithName:NSLocalizedString(@"Book",@"Cell 3")];
					[self.navigationController pushViewController:_extra animated:YES];
				}
				else
				[self displayAlert];
				break;
				
			default:
				break;
		}

	}


	
    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}

	
@end

