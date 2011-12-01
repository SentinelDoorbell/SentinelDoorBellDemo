//
//  TutorialViewController.m
//  Sentinel
//
//  Created by Guest Account on 11/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TutorialViewController.h"


@implementation TutorialViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.title = @"Tutorial";
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
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
	[self.navigationController popViewControllerAnimated:YES];
	[UIView commitAnimations];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Do any additional setup after loading the view from its nib.
	
    UIScrollView *sView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	
    sView.backgroundColor = [UIColor orangeColor];
	
    
	
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	
    Label1.backgroundColor = [UIColor clearColor];
	
    Label1.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label1.text = @"1. Adding a new camera\n";
	[Label1 setFont:[UIFont fontWithName:@"Arial Black" size:20]];
	
    Label1.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label1];
	
    [Label1 release];
	
    
	
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 35, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Config1.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 385, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Config2.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 735, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Config3.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 1085, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Config4.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	
	UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 1450, 320, 30)];
	
    Label2.backgroundColor = [UIColor clearColor];
	
    Label2.font = [UIFont boldSystemFontOfSize:12.0];
	
	Label2.text = @"2.Viewing Live Feed from a configured camera";
	//[Label2 setFont:[UIFont fontWithName:@"Arial Black" size:12]];
	
    Label2.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label2];
	
    [Label2 release];
	
    
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 1485, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Select1.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 1835, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Select2.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 2185, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Select3.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2550, 320, 30)];
	
    Label1.backgroundColor = [UIColor clearColor];
	
    Label1.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label1.text = @"3.Viewing snapshot images";
	[Label1 setFont:[UIFont fontWithName:@"Arial Black" size:20]];
	
    Label1.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label1];
	
    [Label1 release];
	
    
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 2585, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"SS1.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 2935, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"SS2.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 3285, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"SS3.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	
	Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 3660, 320, 30)];
	
    Label1.backgroundColor = [UIColor clearColor];
	
    Label1.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label1.text = @"4.Surveillance Mode";
	[Label1 setFont:[UIFont fontWithName:@"Arial Black" size:20]];
	
    Label1.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label1];
	
    [Label1 release];
	
    
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 3695, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Sur1.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 4050, 240, 345)];
	
    [imageView1 setImage:[UIImage imageNamed:@"Sur2.png"]];
	
    [sView addSubview:imageView1];
	
    [imageView1 release];
	
	
	/*
    UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 375, 320, 30)];
	
    Label2.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label2.backgroundColor = [UIColor clearColor];
	
    Label2.text = @"Configure Camera";
	
    Label2.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label2];
	
    [Label2 release];
	
    
	
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 405, 240, 345)];
	
    [imageView2 setImage:[UIImage imageNamed:@"iOS Simulator Screen shot Nov 30, 2011 5.31.52 PM.png"]];
	
    [sView addSubview:imageView2];
	
    [imageView2 release];
	
    
	
    UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 750, 320, 30)];
	
    Label3.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label3.backgroundColor = [UIColor clearColor];
	
    Label3.text = @"Play with Camera";
	
    Label3.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label3];
	
    [Label3 release];
	
    
	
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 780, 240, 345)];
	
    [imageView3 setImage:[UIImage imageNamed:@"iOS Simulator Screen shot Nov 30, 2011 5.36.12 PM.png"]];
	
    [sView addSubview:imageView3];
	
    [imageView3 release];
	
    
	
    UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 1125, 320, 30)];
	
    Label4.font = [UIFont boldSystemFontOfSize:12.0];
	
    Label4.backgroundColor = [UIColor clearColor];
	
    Label4.text = @"Multi Camera Control";
	
    Label4.textAlignment = UITextAlignmentCenter;
	
    [sView addSubview:Label4];
	
    [Label4 release];
	
    
	
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 1155, 240, 345)];
	
    [imageView4 setImage:[UIImage imageNamed:@"iOS Simulator Screen shot Nov 30, 2011 5.44.42 PM.png"]];
	
    [sView addSubview:imageView4];
	
    [imageView4 release];
	
    */
	
    
	
    sView.delegate = self;
	
    sView.contentSize = CGSizeMake(0, 4400);
	
    
	
    [self.view addSubview:sView];
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
