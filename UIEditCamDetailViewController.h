//
//  UIEditCamDetailViewController.h
//  Sentinel
//
//  Created by SentinelTeam on 11/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface UIEditCamDetailViewController : UIViewController{
	IBOutlet UIScrollView *cameraParamsScrollView;
	IBOutlet UITextField *ipaddress;
	IBOutlet UITextField *username;
	IBOutlet UITextField *password;
	IBOutlet UITextField *cameraname;
	IBOutlet UIButton *deleteCamera;
	IBOutlet UILabel *deleteCameraButtonStat;
	IBOutlet UISwitch *alarmEnableSwitch;
	IBOutlet UIButton *setDefaultCamera;
	IBOutlet UIButton *viewPassword;
	NSManagedObjectContext *context;
	NSManagedObjectContext *contextnew;
	NSManagedObjectContext *contextDefaultCam;
	int checkboxSelected;
	int cameraIndex;
	int defCameraFlag;
	int userInputValid[2]; //Only the IP address and Camera name need to be validated
	IBOutlet UILabel *ipaddressHint;
	IBOutlet UILabel *cameranameHint;
}

- (IBAction) ipaddressEntryStart:(id)sender;
- (IBAction) usernameEntryStart:(id)sender;
- (IBAction) passwordEntryStart:(id)sender;
- (IBAction) cameranameEntryStart:(id)sender;

- (IBAction) onTouchOutsideCameraName:(id)sender;
- (IBAction) onTouchOutsidePassword:(id)sender;
- (IBAction) onTouchOutsideIPaddress:(id)sender;
- (IBAction) onTouchOutsideUserName:(id)sender;
- (IBAction) onTouchalarmSwitch:(id)sender;
- (IBAction) onTouchDeleteCamera:(id)sender;

- (IBAction) onTouchDefaultCamera:(id)sender;
- (IBAction) onTouchRemoveDefaultCamera:(id)sender;
- (IBAction) checkboxButton:(id)sender;
- (IBAction) setDefaultCameraToggle:(id)sender;

- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *contextnew;
@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

@end
