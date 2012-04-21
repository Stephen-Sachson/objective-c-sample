//
//  BookViewController.m
//  Sample
//
//  Created by Stephen on 4/8/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "BookViewController.h"
#import "Restaurant.h"
#import "SampleAppDelegate.h"
#import "ViewController.h"


@implementation BookViewController
@synthesize managedObjectContext;
@synthesize addButton;
@synthesize aView;
@synthesize label1,label2;
@synthesize text1, text2;
@synthesize segCtrl;
@synthesize array,array1;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Book";
	addButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(switchView)];
	self.navigationItem.rightBarButtonItem=addButton;
	[segCtrl addTarget:self action:@selector(picSwitch) forControlEvents:UIControlEventValueChanged];
	//array=[[NSMutableArray alloc] init];
	if (managedObjectContext == nil) 
	{ 
        managedObjectContext = [(SampleAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
	}
	//Fetch with Request
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	NSEntityDescription *entity=[NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	NSError *error;
	NSMutableArray *result=[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (result==nil) {
		NSLog(@"Fail to fetch entity");
	}
	[self setArray:result];
	[request release];
	[result release];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)picSwitch {
	if (segCtrl.selectedSegmentIndex==0) {
		label1.text=@"Name:";
		label2.text=@"Contact:";
		text1.text=string;
		text2.text=string1;
		text2.enabled=YES;
	}
	else {
		label1.text=@"Cuisine:";
		label2.text=@"Provider:";
		string1=[[NSString alloc] initWithString:text2.text];
		text2.text=text1.text;
		text2.enabled=NO;
		string=[[NSString alloc] initWithString:text1.text];
		text1.text=nil;
	}
}

- (void)switchView {
	label1.text=@"Name:";
	label2.text=@"Contact:";
	text1.clearButtonMode=UITextFieldViewModeAlways;
	text2.clearButtonMode=UITextFieldViewModeAlways;
	addButton.enabled=NO;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[self.view addSubview:aView];
	[UIView commitAnimations];
	if([array count]!=0)
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	self.tableView.scrollEnabled=NO;
}

- (IBAction)doneButtonPushed {
	addButton.enabled=YES;
	Restaurant *res=(Restaurant *)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
	Cuisine *csn=(Cuisine *)[NSEntityDescription insertNewObjectForEntityForName:@"Cuisine" inManagedObjectContext:managedObjectContext];
	if (segCtrl.selectedSegmentIndex==0) {
	  if ([text1.text isEqualToString:[NSString stringWithFormat:@""]]) [res setName:@"N/A"];
	  else [res setName:text1.text];
	  [res setContact:[NSNumber numberWithInt:[text2.text intValue]]];
	}
	else {
		[csn setName:text1.text];
		[res setName:string];
		[res setContact:[NSNumber numberWithInt:[string1 intValue]]];
	}	

	[res addCuisineObject:csn];
	
	NSLog([[[res cuisine] anyObject] name]);
	NSError *error;
	if (![managedObjectContext save:&error]) {
	}
	[array addObject:res];
	//[array1 insertObject:csn atIndex:0];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[aView removeFromSuperview];
	[UIView commitAnimations];
	self.tableView.scrollEnabled=YES;
	NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[array count]-1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[array count]-1 inSection:0] 
	 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
		NSManagedObject *resToDel=[array objectAtIndex:integer];
		[managedObjectContext deleteObject:resToDel];
		//resToDel=[array1 objectAtIndex:0];
		//[managedObjectContext deleteObject:resToDel];
		//[managedObjectContext reset];
		NSError *error=nil;
		if (![managedObjectContext save:&error]) {
		}
		[array removeObjectAtIndex:integer];
		NSIndexPath *indexPath=[NSIndexPath indexPathForRow:integer inSection:0];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
	}
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -
#pragma mark Deal with Keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if([textField isFirstResponder]) {
		[textField resignFirstResponder];
	}
	return YES;
}
#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%i",[array count]);
    return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    Restaurant *res=(Restaurant *)[array objectAtIndex:indexPath.row];
	
	cell.textLabel.text=[res name];
	cell.detailTextLabel.text=[NSString stringWithFormat:@"Dial +%i",[[res contact] intValue]];

    // Set up the cell...
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	integer=indexPath.row;
	sheet=[[UIActionSheet alloc] initWithTitle:@"Selete an Action" 
													 delegate:self 
											cancelButtonTitle:@"Cancel" 
									   destructiveButtonTitle:@"Delete" 
											otherButtonTitles:@"Throw'em a Call",nil];
	[sheet showInView:self.view];
	
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
	[addButton release];
	[managedObjectContext release];
	[aView release];
	[label1 release];
	[label2 release];
	[text1 release];
	[text2 release];
	[segCtrl release];
	[array release];
	[array1 release];
	[string release];
	[string1 release];
    [super dealloc];
}


@end

