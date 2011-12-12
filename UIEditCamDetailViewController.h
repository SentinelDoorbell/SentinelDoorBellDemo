/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Camera Configuration Editor
 * Function: This UIView is displayed when a user chooses to modify an existing
 *         : camera configuration or add a new camera configuration. (Header)
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

/*
 * Edit camera configuration for modifying or adding new camera configuraiton.
 * It has a configuration input for each configuraiton item. It also performs
 * validation of user input before committing to database.
 */
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
	IBOutlet UIButton *authenticate;
	NSManagedObjectContext *context;
	NSManagedObjectContext *contextnew;
	NSManagedObjectContext *contextDefaultCam;
	int checkboxSelected;
	int cameraIndex;
	int defCameraFlag;
	int userInputValid[2]; //Only the IP address and Camera name need to be validated
	IBOutlet UILabel *ipaddressHint;
	IBOutlet UILabel *cameranameHint;
	
	UIAlertView *connectionStat;
	UIAlertView *authenticationStat;
	UIActivityIndicatorView *indicator;
}

/******************************************************************************
 * A set of handles that are used to handle events associated with the camera
 * configuration inputs. They also validate the input of the user. They also
 * handle deleting a camera configuraion.
 ******************************************************************************/
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
- (IBAction) onTouchAuthenticateCamera:(id)sender;

- (IBAction) onTouchDefaultCamera:(id)sender;
- (IBAction) onTouchRemoveDefaultCamera:(id)sender;
- (IBAction) checkboxButton:(id)sender;
- (IBAction) setDefaultCameraToggle:(id)sender;

- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

-(BOOL)validateUserInput:(int)camIdx;

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *contextnew;
@property (nonatomic, retain) NSManagedObjectContext *contextDefaultCam;

@end

