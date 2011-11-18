//
//  UIMainViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSCNavBarImageTag 6183746
#define kSCNavBarColor [UIColor colorWithRed:0.54 green:0.18 blue:0.03 alpha:1.0]

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
}

- (IBAction) selectCameraFromListPressed:(id)sender;
- (IBAction) configureCameraPressed:(id)sender;
- (IBAction) setDefaultCamera:(id)sender;
- (IBAction) viewSnapshots:(id)sender;
- (IBAction) surveillancePressed:(id)sender;

- (IBAction) infoSelectCamPressed:(id)sender;
- (IBAction) infoConfigCamPressed:(id)sender;
- (IBAction) infoDefaultCamPressed:(id)sender;
- (IBAction) infoSnapShotPressed:(id)sender;
- (IBAction) infoSurveillancePressed:(id)sender;

@end

@interface ToolTipExit : UIView
{
	
}

@end