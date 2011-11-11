//
//  enterCameraParams.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "enterCameraParams.h"
#import "configureCamera.h"

@implementation enterCameraParams

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


- (void)saveCredentials:(id)sender {
	NSLog(@"Saving credentials");
	//configureCamera *viewctr = [[configureCamera alloc] initWithNibName:@"configureCamera" bundle:nil];
	//[self.navigationController pushViewController:viewctr animated:YES];
	//[viewctr release];
	[self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"Configure Camera";
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemSave  
                             target:self   
                             action:@selector(saveCredentials:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"Editing done");
	[textField resignFirstResponder];
	return NO;
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
