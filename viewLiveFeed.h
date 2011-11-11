//
//  viewLiveFeed.h
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SentinelTouchView;

@interface viewLiveFeed : UIViewController {
	IBOutlet UIWebView *theWebView;
	IBOutlet NSURLRequest *theRequest;
	IBOutlet NSURLConnection *theConnection;
	IBOutlet UIImageView	*theImageView;
	IBOutlet SentinelTouchView *tmpview;
	IBOutlet UIButton *viewSnapshotsFromLiveFeed;
}

- (IBAction) onTiltScanClick: (id) sender;

- (IBAction) onPanScanClick: (id) sender;

- (IBAction) onBrightnessDarker:(id) sender;

- (IBAction) onBrightnessReset:(id) sender;

- (IBAction) onBrightnessBrighter:(id) sender;

- (IBAction) OnNightModeSwitch: (id) sender;

- (IBAction) OnAlarmClick: (id) sender;

- (IBAction) OnSnapshot: (id) sender;

- (IBAction) OnImagesClick: (id) sender;

- (IBAction) OnViewSnapshotsClick: (id) sender;

@end


@interface SentinelTouchView : UIView
{
	
}

- (void) homePosition;

- (void) tiltUp;

- (void) tiltDown;

- (void) PanLeft;

- (void) PanRight;

@end
