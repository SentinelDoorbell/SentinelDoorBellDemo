//
//  viewLiveFeed.m
//  navS
//
//  Created by Researcher on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "viewLiveFeed.h"
#import "view0.h"
#import "viewSnapshots.h"

@implementation viewLiveFeed

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Live Feed";	
	
	theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://128.238.151.253/"] 	  
								cachePolicy:NSURLRequestUseProtocolCachePolicy						  
							timeoutInterval:60.0];
	
	theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                             target:self   
                             action:@selector(OnSnapshot:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
	
	[theWebView addSubview:tmpview];
	
	UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]   
                             initWithTitle:@"Main Menu" 
							 style:UIBarButtonItemStylePlain  
                             target:self   
                             action:@selector(mainMenu:)];
	self.navigationItem.leftBarButtonItem = leftitem;
	[leftitem release];
}

-(void) OnViewSnapshotsClick:(id) sender
{
	viewSnapshots *viewctr = [[viewSnapshots alloc] initWithNibName:@"viewSnapshots" bundle:nil];
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

-(void) mainMenu:(id)sender
{
	/* This is placed in viewWillDisappear because it takes effect for popped view too	*/
	/* When unpopped, the view does not load*/
	//if([theWebView isLoading])
	//	[theWebView stopLoading];
	
	/* If we get to the live feed because the default camera was set load a new view	*/
	/* Else pop two view controllers													*/
	int count = [self.navigationController.viewControllers count];
	
	if(count > 1)
		[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-3] animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
	if([theWebView isLoading])
		[theWebView stopLoading];
	
}

-(void)viewWillAppear :(BOOL)animated
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphMotionJpeg?Resolution=320x240&Quality=Standard"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[theWebView loadRequest:requestObj];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
	if ([challenge previousFailureCount] == 0)
	{
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:@"kongcao7bl"
												 password:@"Kongcao7BL"
											  persistence:NSURLCredentialPersistenceForSession];
		[[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
		NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphMotionJpeg?Resolution=320x240&Quality=Standard"];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[theWebView loadRequest:requestObj];
		
		NSLog(@"LOL");
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Failure" 
														message:@"Invalid username/password."
													   delegate:nil
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction) onTiltScanClick: (id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=TiltScan&PanTiltMin=1"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	
	NSLog(@"TiltScan");
}

- (IBAction) onPanScanClick: (id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=PanScan&PanTiltMin=1"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"PanScan");
}

- (IBAction) onBrightnessDarker:(id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=Darker"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
}

- (IBAction) onBrightnessReset:(id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=DefaultBrightness"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
}

- (IBAction) onBrightnessBrighter:(id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=Brighter"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
}


- (IBAction) OnNightModeSwitch: (id) sender
{
	UISwitch *nightSwitch = (UISwitch *) sender;
	
	
	
	if ([nightSwitch isOn] )
	{
		NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=BacklightOn"];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	}
	else 
	{
		NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=BacklightOff"];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	}
	
	NSLog(@"NightMode");
}

- (IBAction) OnAlarmClick: (id) sender
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=Sound"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	
	NSLog(@"Alarm");
}

- (IBAction) OnSnapshot: (id) sender
{
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyyMMMdd_HH_mm_ss"];
	
	NSDate *now = [NSDate date];
	
	NSString *dateString = [format stringFromDate:now];
	
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/SnapshotJPEG?Resolution=320x240&Quality=Motion&Count=0"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *str = [[NSString alloc] initWithFormat:@"/%@.jpg", dateString];
	path = [path stringByAppendingString:str];
	[str release];
	
	[data writeToFile:path atomically:YES];
	
}

- (IBAction) OnImagesClick: (id) sender
{
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
	NSArray *onlyJPGs = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg'"]];
	
	for(NSString* image in onlyJPGs)
	{
		NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@",path, image];
		
		UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
		
		if (image)
		{
			NSLog(@"Image is good");
		}
		
		[theImageView setImage:image];
		
		[fullPath release];
	}
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


@implementation SentinelTouchView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startLocation = [(UITouch*)[touches anyObject] locationInView:self];
	
	double x = startLocation.x;
	double y = startLocation.y;
	
	NSLog(@"%f %f", x, y);
	
	if(x >= 100 && x <= 210 && y >= 80 && y <= 160)
	{
		[self homePosition];
	}
	
	if (y >= 0 && y <= 80)
	{
		[self tiltUp];
	}
	else if(y >= 160 && y <= 240)
	{
		[self tiltDown];
	}
	
	if (x >= 0 & x <= 110)
	{
		[self PanLeft];
	}
	else if(x >= 210 && x <= 320)
	{
		[self PanRight];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startLocation = [(UITouch*)[touches anyObject] locationInView:self];
	
	double x = startLocation.x;
	double y = startLocation.y;
	
	NSLog(@"Ended: %f %f", x, y);
}

- (void) homePosition
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=HomePosition"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"TiltUp");
}

- (void) tiltUp
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=TiltUp"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"TiltUp");
}

- (void) tiltDown
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=TiltDown"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"TiltDown");
}

- (void) PanLeft
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=PanLeft"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"Pan Left");
}

- (void) PanRight
{
	NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/nphControlCamera?Direction=PanRight"];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	NSLog(@"Pan Right");
}

@end


