//
//  About.h
//  Sample
//
//  Created by Stephen on 3/30/12.
//  Copyright 2012 silicon valley. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface About : UIViewController {
	CGPoint point;
	UIWebView *webView;
	NSString *htmlString;
}
@property (nonatomic, retain)IBOutlet UIWebView *webView;
- (void) dismiss;
- (IBAction) back;
@end
