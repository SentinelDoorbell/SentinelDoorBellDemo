//
//  enterCameraParams.m
//  navS
//
//  Created by Guest Account on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "enterCameraParams.h"


@implementation enterCameraParams

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


-(void)saveCamera:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                             target:self   
                             action:@selector(saveCamera:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
	
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Camera Details";
}

- (IBAction) ipaddressEntry:(id)sender
{
	
}

- (IBAction) usernameEntry:(id)sender
{
}

- (IBAction) passwordEntryStart:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,200) animated:YES];
}

- (IBAction) cameranameEntryStart:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,200) animated:YES];
}

- (IBAction) onTouchOutsideCameraName:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsidePassword:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsideIPaddress:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsideUserName:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
