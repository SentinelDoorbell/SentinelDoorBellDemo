/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Live Stream View
 * Function: Live stream view of the selected camera. It also has many action
 *         : that the user can use to interact with the camera such as tilting
 *         : up/down, moving the camera left and right, changing brightness, 
 *         : alarm, taking snapshots etc. (Header)
 *
 * Modifications
 * 
 * Date   : December 2011
 * Change : New file
 * Author : SentinelTeam
 *
 * Date   :
 * Change :
 * Author :
 *
 */

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SentinelTouchView;

/*
 * Live Stream of the camera. It has a web view for viewing the live stream from
 * the camera, handles many actions that could perform on the camera in 
 * selection such moving the camera using touches, buttons and taking snapshots. 
 * The class also implements the alert delegates and web view delegates for 
 * handling events during the display such as errors that might be raised.
 */
@interface UILiveFeedViewController : UIViewController 
                <UIAlertViewDelegate, UIWebViewDelegate> 
{
	IBOutlet UIWebView *theWebView;
	
    IBOutlet NSURLRequest *theRequest;
	
    IBOutlet NSURLConnection *theConnection;
	
    IBOutlet UIImageView *theImageView;
	
    IBOutlet SentinelTouchView *tmpview;
	
    IBOutlet UIButton *viewSnapshotsFromLiveFeed;
    
	NSManagedObjectContext *context;
	
	NSManagedObjectContext *contextDefaultCam;
	
	UIAlertView *connectionStat;
}

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

/******************************************************************************
 * Each of the following selectors handle an action on the camera by looking
 * up the right http request using the config access and sending the 
 * request to the camera. 
 ******************************************************************************/

/*
 * Selector to handle clicking the tilt scan button for moving the camera
 */
- (IBAction) onTiltScanClick: (id) sender;

/*
 * Selector to handle clicking the pan scan buttong for moving the camera
 */
- (IBAction) onPanScanClick: (id) sender;

/*
 * Selector to handle chaning the brightness of the cameara to darker
 */
- (IBAction) onBrightnessDarker:(id) sender;

/*
 * Selector to handle resetting the brightness of the cameara to default.
 */
- (IBAction) onBrightnessReset:(id) sender;

/*
 * Selector to handle chaning the brightness of the cameara to brighter.
 */
- (IBAction) onBrightnessBrighter:(id) sender;

/*
 * Selector to handle changing the mode of the camera to night mode.
 */
- (IBAction) OnNightModeSwitch: (id) sender;

/*
 * Selector to handle making the camera play a sound
 */
- (IBAction) OnAlarmClick: (id) sender;

/*
 * Selector to handle taking a snapshot of the current display of the camera.
 */
- (IBAction) OnSnapshot: (id) sender;

/*
 * Selector to handle view snapshots button, it replaces the current view with
 * view of the snapshots. 
 */
- (IBAction) OnViewSnapshotsClick: (id) sender;
@end

/*
 * Class to handle moving the camera using detected touches on the live stream
 * view of the camera. 
 */
@interface SentinelTouchView : UIView
{
	
}

/*
 * Reset the camera to the home position which is the default.
 */
- (void) homePosition;

/*
 * Tilt the camera up
 */
- (void) tiltUp;

/*
 * Tilt the camera down
 */
- (void) tiltDown;

/*
 * Pan the camera left
 */
- (void) PanLeft;

/*
 * Pan the camera right
 */
- (void) PanRight;

@end
