/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Main View Controller
 * Function: This is the main view of the application, the root of the 
 *         : navigation. (Header)
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

#define kSCNavBarImageTag 6183746
#define kSCNavBarColor [UIColor colorWithRed:0.54 green:0.18 blue:0.03 alpha:1.0]

/*
 * Main view controller that the user sees when launching the application. It
 * is the root of the navigation through out the app. Each button will launch
 * a new UI view.  
 */
@interface UIMainViewController : UIViewController 
{
	IBOutlet UIButton *selectCameraFromList;
	IBOutlet UIButton *configureCamera;
	IBOutlet UIButton *setDefaultCamera;
	IBOutlet UIButton *viewSnapshots;
	IBOutlet UIButton *surveillance;
	
	IBOutlet UIButton *infoSelectCam;
	IBOutlet UIButton *infoConfigCam;
	IBOutlet UIButton *infoDefaultCam;
	IBOutlet UIButton *infoSnapShot;
	IBOutlet UIButton *infoSurveillance;
	
	IBOutlet UILabel *tooltip;
	
	NSManagedObjectContext *contextDefaultCam;
}

/* 
 * This selector handles pressing the button of selecting a camera to be viewed
 * from the list of the configured cameras. This will launch a view with the
 * list of all the cameras stored.
 */
- (IBAction) selectCameraFromListPressed:(id)sender;

/*
 * This selector handles pressing the configure camera button for modifying
 * existing camera configuration, adding new camera configuration or deleting 
 * a camera configuration. 
 */
- (IBAction) configureCameraPressed:(id)sender;

/*
 * TODO remove, not being used. 
 */
- (IBAction) setDefaultCamera:(id)sender;

/*
 * This selector handles pressing the view snapshots button. This selector will
 * replace the current view with to the snapshots view.
 */
- (IBAction) viewSnapshots:(id)sender;

/*
 * This selector handles pressing the surveillance button, it will replace the
 * the current view with the surveillance view which allows users to view more
 * than live camera at the same time.
 */
- (IBAction) surveillancePressed:(id)sender;

/*
 * Displays information about the function of the select camera button.
 */
- (IBAction) infoSelectCamPressed:(id)sender;

/*
 * Displays information about the function of config camera button.
 */
- (IBAction) infoConfigCamPressed:(id)sender;

/*
 * TODO remove, not being used.
 */
- (IBAction) infoDefaultCamPressed:(id)sender;

/*
 * Display information about the function of view snapshots button.
 */
- (IBAction) infoSnapShotPressed:(id)sender;

/*
 * Property for the the managed object context for accessing database.
 */
- (IBAction) infoSurveillancePressed:(id)sender;

@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

@end

@interface ToolTipExit : UIView
{
	
}

@end