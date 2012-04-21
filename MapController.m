//
//  MapController.m
//  Sample
//
//  Created by Stephen on 4/1/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import "MapController.h"
#import "Constants.h"
#import "Annotations.h"

@implementation MapController
@synthesize mapView;
@synthesize segCtrl;
@synthesize barButton;
@synthesize searchBar;
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
	self.title=NSLocalizedString(@"Spot!",@"Map title");
	self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"Me" 
																			style:UIBarButtonItemStylePlain 
																		   target:self 
																		   action:@selector(center)] autorelease];
	mapView.showsUserLocation=YES;
	[segCtrl addTarget:self action:@selector(toggleMode) forControlEvents:UIControlEventValueChanged];
	if(segCtrl.selectedSegmentIndex==0)
	mapView.mapType=0;
	else mapView.mapType=2;
	barButton.action=@selector(openSearchBar);
	
	//Add annotations
	annotation1=[[Annotations alloc] init];
	CLLocationCoordinate2D coordinate;
	coordinate.latitude=kLatitude;
	coordinate.longitude=kLongitude;
	annotation1.coordinate=coordinate;
	addressOfAnnotation=[[MKReverseGeocoder alloc] initWithCoordinate:annotation1.coordinate];
	addressOfAnnotation.delegate=self;
	[addressOfAnnotation start];
	NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:annotation1,nil];
	[mapView addAnnotations:array];
	
	//Track users location
	[mapView.userLocation addObserver:self forKeyPath:@"location" options:0 context:NULL];
    
	shouldTrack=NO;
	getAddress=YES;
}
#pragma mark -
#pragma mark Geo Code
//be called when the user has moved
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (shouldTrack) {
	MKUserLocation *here=mapView.userLocation;
	CLLocation *location=here.location;
	if(location==nil) return;
	CLLocationDistance far=MAX(location.horizontalAccuracy, kAccuracy);
	MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location.coordinate, far, far);
	[mapView setRegion:region animated:YES];
	}
}

- (void)toggleMode {
	if (segCtrl.selectedSegmentIndex==0)
		mapView.mapType=0;
	else mapView.mapType=2;
}

- (void)center {
	MKUserLocation *here=mapView.userLocation;
	CLLocation *location=here.location;
	if(location==nil) return;
	CLLocationDistance far=kAccuracy;
	MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location.coordinate, far, far);
	[mapView setRegion:region animated:YES];
	//Get the place information with reverseCeocoder
	if (getAddress) {
		reverseGeocoder=[[MKReverseGeocoder alloc] initWithCoordinate:location.coordinate];
		reverseGeocoder.delegate=self;
		[reverseGeocoder start];
	}
	if (!shouldTrack) {
		shouldTrack=YES;
		self.navigationItem.rightBarButtonItem.title=@"View";
	}
	else {
		shouldTrack=NO;
		self.navigationItem.rightBarButtonItem.title=@"Me";
	}

}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	if(placemark.subThoroughfare==nil) return;
	NSMutableString *string=[[NSMutableString alloc] initWithString:placemark.subThoroughfare];
	[string appendString:@" "];
	[string appendString:placemark.thoroughfare];
	NSString *aString=[[NSString alloc] initWithFormat:@"%@, %@",placemark.subLocality,placemark.locality];
	if ([geocoder isEqual:reverseGeocoder]){
		NSLog(@"User Location Title is found");
		mapView.userLocation.subtitle=placemark.locality;
		mapView.userLocation.title=string;
		getAddress=NO;
	}
	else if ([geocoder isEqual:addressOfAnnotation]) {
		NSLog(@"Annotation title is fetched");
		annotation1.subTitle=aString;
		annotation1.title=string;
	}
	[string release];
	[aString release];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	NSLog(@"Error:%@",error);
}
#pragma mark -
#pragma mark Search Bar Code
- (IBAction)openSearchBar {
	if (![searchBar isDescendantOfView:self.mapView]) {
		frame=CGRectMake(0.0f, -40.0f, 320.0f, 40.0f);
		searchBar=[[UISearchBar alloc] initWithFrame:frame];
		searchBar.barStyle=UIBarStyleBlackTranslucent;
		searchBar.delegate=self;
		searchBar.placeholder=@"Input a place name";
		searchBar.showsCancelButton=YES;
		
		
		dimView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 440)];
		dimView.backgroundColor=[UIColor blackColor];
		dimView.alpha=0.0f;
		[UIView beginAnimations:@"fade" context:nil];
		[UIView setAnimationDuration:0.3f];
		[UIView setAnimationDelegate:self];
		//[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		//[UIView setAnimationRepeatAutoreverses:YES];
		[self.mapView addSubview:dimView];
		dimView.alpha = 0.7f;
		[self.mapView addSubview:searchBar];
		frame.origin.y+=40.0f;
		searchBar.frame=frame;
		
		[UIView commitAnimations];
	}
	[searchBar becomeFirstResponder];
}
/*
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    dimView.alpha = 0.0f;
}
*/
//Search Bar Delegate method
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self searchBarCancelButtonClicked:self.searchBar];
	UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140.0f, 180.0f, 40.0f, 40.0f)];
	indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
	indicator.hidesWhenStopped=YES;
	[self.mapView addSubview:indicator];
	[indicator startAnimating];
	[indicator performSelector:@selector(stopAnimating) withObject:indicator afterDelay:7.0f];
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"No Such Place!" message:nil 
												 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert performSelector:@selector(show) withObject:alert afterDelay:7.8f];
	[alert release];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	if ([self.searchBar isFirstResponder])
		[self.searchBar resignFirstResponder];
	
	[UIView beginAnimations:@"fade" context:nil];
	[UIView setAnimationDuration:0.3f];
	[UIView setAnimationDelegate:self];
	frame.origin.y-=40.0f;
	self.searchBar.frame=frame;
	dimView.alpha=0.0f;
	[UIView commitAnimations];
	[self.searchBar performSelector:@selector(removeFromSuperview) withObject:self.searchBar afterDelay:0.3f];
}
#pragma mark -
#pragma mark Memory Management
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


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
	[mapView release];
	[segCtrl release];
	[reverseGeocoder release];
	[addressOfAnnotation release];
	[searchBar release];
    [super dealloc];
}


@end
