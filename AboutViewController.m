/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : About View
 * Function: View to display a small description about Sentinel and its team.
 *         : (Header)
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

#import "AboutViewController.h"

@implementation AboutViewController
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"About Sentinel";
		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
    }
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
			initWithTitle:@"Back" 
			style:UIBarButtonItemStyleBordered target:self action:@selector(backPressed:)];
	self.navigationItem.leftBarButtonItem = item; 
	[item release];
	
    return self;
}

-(void)backPressed:(id)sender
{
	[UIView  beginAnimations: @"Showinfo"context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp 
                           forView:self.navigationController.view 
                             cache:NO];
	[self.navigationController popViewControllerAnimated:YES];
	[UIView commitAnimations];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}

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