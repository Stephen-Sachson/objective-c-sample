//
//  About.m
//  Sample
//
//  Created by Stephen on 3/30/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "About.h"


@implementation About
@synthesize webView;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        htmlString=@"<div style=\"font-family:Helvetica,Arial, sans-serif; font-size:40pt;\"align=\"center\"><p>";
		htmlString=[htmlString stringByAppendingString:string];
		htmlString=[htmlString stringByAppendingString:@"</p></span>"];
		
		}
	
    return self;
}

- (void) dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) back {
	[self dismiss];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[webView loadHTMLString:htmlString baseURL:nil];
	
	
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
	[webView release];
    [super dealloc];
}

#pragma mark Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch=[touches anyObject];
	point=[touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch=[touches anyObject];
	CGPoint location=[touch locationInView:self.view];
	
	if(location.y-point.y>50.0f) {
		[self dismiss];
	}
}

@end
