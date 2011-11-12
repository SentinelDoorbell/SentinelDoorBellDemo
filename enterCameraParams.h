//
//  enterCameraParams.h
//  navS
//
//  Created by Guest Account on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface enterCameraParams : UIViewController {
	IBOutlet UIScrollView *cameraParamsScrollView;
	IBOutlet UITextField *ipaddress;
	IBOutlet UITextField *username;
	IBOutlet UITextField *password;
	IBOutlet UITextField *cameraname;
	IBOutlet UISwitch *alarmEnableSwitch;
}

- (IBAction) ipaddressEntry:(id)sender;
- (IBAction) usernameEntry:(id)sender;
- (IBAction) passwordEntryStart:(id)sender;
- (IBAction) cameranameEntryStart:(id)sender;

- (IBAction) onTouchOutsideCameraName:(id)sender;
- (IBAction) onTouchOutsidePassword:(id)sender;
- (IBAction) onTouchOutsideIPaddress:(id)sender;
- (IBAction) onTouchOutsideUserName:(id)sender;
- (IBAction) onTouchalarmSwitch:(id)sender;

@end
