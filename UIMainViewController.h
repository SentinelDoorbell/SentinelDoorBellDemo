//
//  UIMainViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIMainViewController : UIViewController 
{
	IBOutlet UIButton *selectCameraFromList;
	IBOutlet UIButton *configureCamera;
	IBOutlet UIButton *setDefaultCamera;
	IBOutlet UIButton *viewSnapshots;
}

- (IBAction) selectCameraFromListPressed:(id)sender;
- (IBAction) configureCameraPressed:(id)sender;
- (IBAction) setDefaultCamera:(id)sender;
- (IBAction) viewSnapshots:(id)sender;

@end
