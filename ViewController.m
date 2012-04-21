//
//  ViewController.m
//  Sample
//
//  Created by Stephen on 4/9/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize subView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithInteger:(NSInteger)index {
    if (self = [super init]) {
        n=index;
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addSubview:subView];
	UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Do you want to delete it?" 
													 delegate:self cancelButtonTitle:@"Cancel" 
									   destructiveButtonTitle:@"Delete" 
											otherButtonTitles:@"Other",nil];
	[sheet showInView:self.view];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
