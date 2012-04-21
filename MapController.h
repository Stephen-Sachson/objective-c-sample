//
//  MapController.h
//  Sample
//
//  Created by Stephen on 4/1/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKReverseGeocoder.h>

@class Annotations;
@interface MapController : UIViewController <MKReverseGeocoderDelegate,UISearchBarDelegate>{
	MKMapView *mapView;
	UISegmentedControl *segCtrl;
	UIBarButtonItem *barButton;
	MKReverseGeocoder *reverseGeocoder,*addressOfAnnotation;
	BOOL shouldTrack, getAddress;
	Annotations *annotation1;
	UISearchBar *searchBar;
	UIView *dimView;
	CGRect frame;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segCtrl;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, retain) UISearchBar *searchBar;

- (void)toggleMode;
- (void)center;
- (IBAction)openSearchBar;
@end
