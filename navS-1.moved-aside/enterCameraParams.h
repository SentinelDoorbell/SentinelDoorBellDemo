//
//  enterCameraParams.h
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface enterCameraParams : UIViewController {
	IBOutlet UITextField *ipaddress;
	IBOutlet UITextField *username;
	IBOutlet UITextField *password;
	IBOutlet UITextField *cameraName;
}
- (void)saveCredentials:(id)sender;
- (IBAction)textFieldShouldReturn:(id)sender;

@end
