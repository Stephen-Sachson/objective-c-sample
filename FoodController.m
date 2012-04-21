//
//  FoodController.m
//  Sample
//
//  Created by Stephen on 4/1/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "FoodController.h"


@implementation FoodController
@synthesize segBar,segBar1,segBar2;
@synthesize aView, bView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=NSLocalizedString( @"Yummy!", @"Food title");
	hmm=NO;
	segCtrl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Chinese",@"Tool Bar Title"),NSLocalizedString(@"Western",@""),NSLocalizedString(@"Other",@""),nil]];
	[segCtrl addTarget:self action:@selector(picSwitch) forControlEvents:UIControlEventValueChanged];
	segCtrl.segmentedControlStyle=UISegmentedControlStyleBar;
	segCtrl.tintColor=[UIColor darkGrayColor];
	segCtrl.opaque=NO;
	CGRect rect=segBar.frame;
	rect.size.width-=24;
	rect.size.height-=7;
	segCtrl.frame=rect;
	segCtrl.selectedSegmentIndex=0;
	item=[[UIBarButtonItem alloc] initWithCustomView:segCtrl];
	segBar.items=[NSArray arrayWithObject:item];
	[segCtrl release];
	[item release];
	
}

- (void) picSwitch {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.8];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	
	switch (segCtrl.selectedSegmentIndex) {
		case 0:
			[aView removeFromSuperview];
			[bView removeFromSuperview];
			if (hmm)
			segBar.items=[NSArray arrayWithObject:item];
			hmm=YES;
			break;
		case 1:
			[bView removeFromSuperview];
			[self.view addSubview:aView];
			segBar1.items=[NSArray arrayWithObject:item];
			break;
		case 2:
			[aView removeFromSuperview];
			[self.view addSubview:bView];
			segBar2.items=[NSArray arrayWithObject:item];
			break;


		default:
			break;
	}
	[UIView commitAnimations];
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
