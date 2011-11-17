//
//  UIEditCamDetailViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UIEditCamDetailViewController.h"
#import "AppDelegate_iPhone.h"
#import <CoreData/CoreData.h>
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"

@implementation UIEditCamDetailViewController

@synthesize context;
@synthesize contextnew;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

-(void)saveCamera:(id)sender
{
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
		entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	EditInfoCameraView *obj = [fetchedObjects objectAtIndex:0];
	NSNumber *index = [NSNumber numberWithInteger:[obj.cameraIndex intValue]];
	
	[fetchRequest release];
	fetchRequest = nil;
	
	#ifdef DEBUG
	NSLog(@"UIEditCameraViewController: saveCamera: index: %d", [index intValue]);
	#endif
	
	fetchRequest = [[NSFetchRequest alloc] init];
	contextnew = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
				@"SentinelInfo" inManagedObjectContext:contextnew];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if([index intValue] == -1)
	{
		#ifdef DEBUG 
		NSLog(@"UIEditCameraViewController: saveCamera: newCamera");
		#endif

		SentinelInfo *mo = [NSEntityDescription 
							insertNewObjectForEntityForName:@"SentinelInfo"
							inManagedObjectContext:contextnew];
		
		[mo setValue:ipaddress.text forKey:@"ipAddress"];
		[mo setValue:password.text forKey:@"password"];
		[mo setValue:cameraname.text forKey:@"cameraName"];
		[mo setValue:username.text forKey:@"userName"];
		
		if(![contextnew save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
	}
	else if([index intValue] < [fetchedObjects count])
	{
		SentinelInfo *mo = [fetchedObjects objectAtIndex:[index intValue]];

		#ifdef DEBUG
		NSLog(@"UIEditCameraViewController: saveCamera: editing camera at index: %d",
				[index intValue]);
		#endif

		[mo setValue:ipaddress.text forKey:@"ipAddress"];
		[mo setValue:password.text forKey:@"password"];
		[mo setValue:cameraname.text forKey:@"cameraName"];
		[mo setValue:username.text forKey:@"userName"];

		if(![contextnew save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
	}
	[fetchRequest release];
	fetchRequest = nil;

	#ifdef DEBUG
	NSLog(@"UIEditCameraViewController: saveCamera: Done Saving");
	#endif
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) onTouchDeleteCamera:(id)sender
{
	if(cameraIndex != -1)
	{
		AppDelegate_iPhone *appDelegate =
			(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
		context = [appDelegate managedObjectContext];
		
		NSError *error;
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription 
			entityForName:@"SentinelInfo" inManagedObjectContext:context];
		
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
		
		NSManagedObject *mo = [fetchedObjects objectAtIndex:cameraIndex];
		[context deleteObject:mo];
		
		if(![context save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: onTouchDeleteCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
		[fetchRequest release];
		
	}
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

- (IBAction) onTouchalarmSwitch:(id)sender
{
	UISwitch *alarmSwitch = (UISwitch *) sender;
	
	if ([alarmSwitch isOn] )
	{
		NSLog(@"Switching alarm on");
		NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/CgiAlarmSound"];
		NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
		[requestObj setHTTPMethod: @"POST"];
		
		NSString *authValue = [[[NSString stringWithFormat:@"%@:%@", @"kongcao7bl", @"Kongcao7BL"] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
		
		[requestObj setValue:@"multipart/form-data, boundary=AaB03x" forHTTPHeaderField: @"Content-type"];
		
		[requestObj setValue:@"128.238.151.253" forHTTPHeaderField: @"Host"];
		[requestObj setValue:@"keep-alive" forHTTPHeaderField: @"Connection"];
		//[requestObj setValue:@"51" forHTTPHeaderField: @"Content-Length"];
		[requestObj setValue:@"max-age=0" forHTTPHeaderField: @"Cache-Control"];
		[requestObj setValue:authValue forHTTPHeaderField: @"Authorization"];
		[requestObj setValue:@"http://128.238.151.253" forHTTPHeaderField: @"Origin"];
		[requestObj setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2" forHTTPHeaderField: @"User-Agent"];
		[requestObj setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
		[requestObj setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField: @"Accept"];
		[requestObj setValue:@"http://128.238.151.253/CgiAlarmSound?Language=0" forHTTPHeaderField: @"Referer"];
		[requestObj setValue:@"gzip,deflate,sdch" forHTTPHeaderField: @"Accept-Encoding"];
		[requestObj setValue:@"en-US,en;q=0.8" forHTTPHeaderField: @"Accept-Language"];
		[requestObj setValue:@"ISO-8859-1,utf-8;q=0.7,*;q=0.3" forHTTPHeaderField: @"Accept-Charset"];
		
		NSMutableData *postBody = [NSMutableData data];
		NSData* boundary = [@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding];
		[postBody appendData: boundary];
		[postBody appendData: [@"Form Data\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"Language: 0\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutSw: 1\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutVol: 1\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutType: 2\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"Save: ++Save++\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		[requestObj setValue:[NSString stringWithFormat:@"%d", [postBody length]] forHTTPHeaderField: @"Content-Length"];
		
		[requestObj setHTTPBody:postBody];
		
		/*
		NSMutableData *body = [NSMutableData data];
		NSString *boundary = [NSString stringWithString:@"---------------------------7d44e178b0434"];
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; Language=\"0\"; OutSw=\"1\" OutVol=\"1\"; OutType=\"2\"; Save=\"Save\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		
		NSString* contentType = @"multipart/form-data, boundary=AaB03x";
		[requestObj setValue:contentType forHTTPHeaderField: @"Content-type"];
		
		NSData* boundary = [@"\r\n--AaB03x\r\n" dataUsingEncoding:NSUTF8StringEncoding];
		NSMutableData *postBody = [NSMutableData data];
		
		[postBody appendData: boundary];
		[postBody appendData: [@"Content-Disposition: form-data; Language=\"0\"; OutSw=\"1\" OutVol=\"1\"; OutType=\"2\"; Save=\"Save\"; " dataUsingEncoding:NSUTF8StringEncoding]];
		[requestObj setHTTPBody:body];
		*/
		[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
	}
	else 
	{
		NSLog(@"Switching alarm off");
		NSURL *url = [NSURL URLWithString:@"http://128.238.151.253/CgiAlarmSound"];
		NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
		[requestObj setHTTPMethod: @"POST"];
		
		NSString *authValue = [[[NSString stringWithFormat:@"%@:%@", @"kongcao7bl", @"Kongcao7BL"] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
		
		[requestObj setValue:@"multipart/form-data, boundary=AaB03x" forHTTPHeaderField: @"Content-type"];
		
		[requestObj setValue:@"128.238.151.253" forHTTPHeaderField: @"Host"];
		[requestObj setValue:@"keep-alive" forHTTPHeaderField: @"Connection"];
		[requestObj setValue:@"max-age=0" forHTTPHeaderField: @"Cache-Control"];
		[requestObj setValue:authValue forHTTPHeaderField: @"Authorization"];
		[requestObj setValue:@"http://128.238.151.253" forHTTPHeaderField: @"Origin"];
		[requestObj setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.106 Safari/535.2" forHTTPHeaderField: @"User-Agent"];
		[requestObj setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
		[requestObj setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField: @"Accept"];
		[requestObj setValue:@"http://128.238.151.253/CgiAlarmSound?Language=0" forHTTPHeaderField: @"Referer"];
		[requestObj setValue:@"gzip,deflate,sdch" forHTTPHeaderField: @"Accept-Encoding"];
		[requestObj setValue:@"en-US,en;q=0.8" forHTTPHeaderField: @"Accept-Language"];
		[requestObj setValue:@"ISO-8859-1,utf-8;q=0.7,*;q=0.3" forHTTPHeaderField: @"Accept-Charset"];
		
		NSMutableData *postBody = [NSMutableData data];
		NSData* boundary = [@"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding];
		[postBody appendData: boundary];
		[postBody appendData: [@"Form Data\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"Language: 0\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutSw: 4\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutVol: 1\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"OutType: 2\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData: [@"Save: ++Save++\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		[requestObj setValue:[NSString stringWithFormat:@"%d", [postBody length]] forHTTPHeaderField: @"Content-Length"];
		
		[requestObj setHTTPBody:postBody];
		/*
		[requestObj setHTTPMethod: @"POST"];
		
		NSMutableData *body = [NSMutableData data];
		NSString *boundary = [NSString stringWithString:@"---------------------------7d44e178b0434"];
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[@"Content-Disposition: form-data; Language=\"0\"; OutSw=\"4\" OutVol=\"1\"; OutType=\"2\"; Save=\"Save\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
		
		
		 NSString* contentType = @"multipart/form-data, boundary=AaB03x";
		 [requestObj setValue:contentType forHTTPHeaderField: @"Content-type"];
		 
		 NSData* boundary = [@"\r\n--AaB03x\r\n" dataUsingEncoding:NSUTF8StringEncoding];
		 NSMutableData *postBody = [NSMutableData data];
		 
		 [postBody appendData: boundary];
		 [postBody appendData: [@"Content-Disposition: form-data; Language=\"0\"; OutSw=\"4\" OutVol=\"1\"; OutType=\"2\"; Save=\"Save\"; " dataUsingEncoding:NSUTF8StringEncoding]];
		 
		[requestObj setHTTPBody:body];
		*/
		[NSURLConnection sendSynchronousRequest:requestObj returningResponse:nil error:nil];
		NSLog(@"Disable Alarm");
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Camera Details";
	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
		   entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	EditInfoCameraView *info = [fetchedObjects objectAtIndex:0];
	[fetchRequest release];
	
	NSNumber *index = [NSNumber numberWithInt:[info.cameraIndex intValue]];
	cameraIndex = [index intValue];
	if([index intValue] != -1)
	{
		#ifdef DEBUG
		NSLog(@"UIEditCamDetailViewController viewDidLoad: loading view at index %d",
			  [index intValue]);
		#endif

		deleteCamera.enabled = YES;
		deleteCameraButtonStat.text = @"";
		AppDelegate_iPhone *appDelegate =
			(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
		contextnew = [appDelegate managedObjectContext];
		
		NSError *error;
		NSFetchRequest *fetchRequestnew = [[NSFetchRequest alloc] init];
		NSEntityDescription *entitynew = [NSEntityDescription 
		   entityForName:@"SentinelInfo" inManagedObjectContext:contextnew];
		
		[fetchRequestnew setEntity:entitynew];
		[fetchRequestnew setReturnsObjectsAsFaults:NO];
	
		NSArray *fetchedObjectsnew =
			[context executeFetchRequest:fetchRequestnew error:&error];
	
		SentinelInfo *infoS = [fetchedObjectsnew objectAtIndex:[index intValue]];
		[fetchRequestnew release];
	
		ipaddress.text = infoS.ipAddress;
		username.text = infoS.userName;
		password.text = infoS.password;
		cameraname.text = infoS.cameraName;
	}
	else 
	{
		#ifdef DEBUG
		NSLog(@"UIEditCamDetailViewController viewDidLoad: loading new view");
		#endif

		deleteCamera.enabled = NO;
		deleteCameraButtonStat.text = @"(Disabled)";
		
	}

}

- (void) viewWillAppear:(BOOL)animated
{
	
}

- (IBAction) ipaddressEntry:(id)sender
{
	
}

- (IBAction) usernameEntry:(id)sender
{
}

- (IBAction) passwordEntryStart:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,200) animated:YES];
}

- (IBAction) cameranameEntryStart:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,200) animated:YES];
}

- (IBAction) onTouchOutsideCameraName:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsidePassword:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsideIPaddress:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsideUserName:(id)sender
{
	//[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
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
