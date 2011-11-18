//
//  UILiveFeedViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SentinelTouchView;

@interface UILiveFeedViewController : UIViewController <UIAlertViewDelegate> {
	IBOutlet UIWebView *theWebView;
	IBOutlet NSURLRequest *theRequest;
	IBOutlet NSURLConnection *theConnection;
	IBOutlet UIImageView	*theImageView;
	IBOutlet SentinelTouchView *tmpview;
	IBOutlet UIButton *viewSnapshotsFromLiveFeed;
	NSManagedObjectContext *context;
}

@property (nonatomic, retain) NSManagedObjectContext *context;

- (IBAction) onTiltScanClick: (id) sender;

- (IBAction) onPanScanClick: (id) sender;

- (IBAction) onBrightnessDarker:(id) sender;

- (IBAction) onBrightnessReset:(id) sender;

- (IBAction) onBrightnessBrighter:(id) sender;

- (IBAction) OnNightModeSwitch: (id) sender;

- (IBAction) OnAlarmClick: (id) sender;

- (IBAction) OnSnapshot: (id) sender;

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
