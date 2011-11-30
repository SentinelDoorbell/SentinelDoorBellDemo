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
#import "DefaultCamera.h"

@implementation UIEditCamDetailViewController

@synthesize context;
@synthesize contextnew;
@synthesize contextDefaultCam;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

-(BOOL)validateUserInput:(int)camIdx
{
	// validate IP address
	int state = 0;
	int index = 0;
	userInputValid[0] = 0;
	userInputValid[1] = 0;
	while (index < [ipaddress.text length]) {
		char ch = [ipaddress.text characterAtIndex:index];
		index++;
		
		if(state == 0 && ch >= '0' && ch <= '9') state = 1;
		else if(state == 1 && ch >= '0' && ch <= '9') state = 2;
		else if(state == 1 && ch == '.') state = 4;
		else if(state == 2 && ch >= '0' && ch <= '9') state = 3;
		else if(state == 2 && ch == '.') state = 4;
		else if(state == 3 && ch == '.') state = 4;
		
		else if(state == 4 && ch >= '0' && ch <= '9') state = 5;
		else if(state == 4 && ch == '.') state = 8;
		else if(state == 5 && ch >= '0' && ch <= '9') state = 6;
		else if(state == 5 && ch == '.') state = 8;
		else if(state == 6 && ch >= '0' && ch <= '9') state = 7;
		else if(state == 6 && ch == '.') state = 8;
		else if(state == 7 && ch == '.') state = 8;
		
		else if(state == 8 && ch >= '0' && ch <= '9') state = 9;
		else if(state == 8 && ch == '.') state = 12;
		else if(state == 9 && ch >= '0' && ch <= '9') state = 10;
		else if(state == 9 && ch == '.') state = 12;
		else if(state == 10 && ch >= '0' && ch <= '9') state = 11;
		else if(state == 10 && ch == '.') state = 12;
		else if(state == 11 && ch == '.') state = 12;
		
		else if(state == 12 && ch >= '0' && ch <= '9') state = 13;
		else if(state == 13 && ch >= '0' && ch <= '9') state = 14;
		else if(state == 14 && ch >= '0' && ch <= '9') state = 15;
		else{
			NSLog(@"ch = %c and state = %d and index = %d", ch, state, index);
			state = -1;
			break;
		}

	}
	NSLog(@"State = %d", state);
	if(state < 13)
		userInputValid[0] = 1;
	
	//validate camera name
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
	[fetchRequest release];

	index = 0;
	
	while (index < [fetchedObjects count]) 
	{
		SentinelInfo *sinfo = [fetchedObjects objectAtIndex:index];
		NSLog(@"sinfo.cameraName = %@ and cameraname.text = %@", sinfo.cameraName, cameraname.text);
		
		if([cameraname.text isEqualToString:@""])
		{
			userInputValid[1] = 2;
			break;
		}
		
		if(camIdx != -1 && camIdx == index)
		{
			index++;
			continue;
		}
		
		if([sinfo.cameraName isEqualToString:cameraname.text])
		{
			userInputValid[1] = 1;
			break;
		}
		index++;
	}
	if([fetchedObjects count] == 0 && [cameraname.text isEqualToString:@""])
		userInputValid[1] = 2;
		
	if(userInputValid[0] == 1)
	{
		ipaddressHint.text = @"(Invalid IP! ex: 192.168.3.4)";
		ipaddressHint.textColor = [UIColor redColor];
	}
	else 
	{
		ipaddressHint.text = @"(ex: 192.168.55.3)";
		ipaddressHint.textColor = [UIColor blackColor];
	}
	
	if(userInputValid[1] == 1)
	{
		cameranameHint.text = @"(Conflicting camera name)";
		cameranameHint.textColor = [UIColor redColor];
	}
	else if(userInputValid[1] == 2)
	{
		cameranameHint.text = @"(Camera name empty!!)";
		cameranameHint.textColor = [UIColor redColor];
	}
	else 
	{
		cameranameHint.text = @"(Should be Unique)";
		cameranameHint.textColor = [UIColor blackColor];
	}
	if(userInputValid[0] != 0 || userInputValid[1] != 0)
		return FALSE;
	else
		return TRUE;
}

-(void)saveCamera:(id)sender
{
	//BOOL
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
	[ipaddress resignFirstResponder];
	[username resignFirstResponder];
	[password resignFirstResponder];
	[cameraname resignFirstResponder];
	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	int totalCameraCnt = -1;
	
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
	
	//#ifdef DEBUG
	NSLog(@"UIEditCameraViewController: saveCamera: index: %d", [index intValue]);
	//#endif
	
	fetchRequest = [[NSFetchRequest alloc] init];
	contextnew = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
				@"SentinelInfo" inManagedObjectContext:contextnew];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	totalCameraCnt = [fetchedObjects count]-1;
	
	if([self validateUserInput:[index intValue]] == FALSE)
		return;
	
	if([index intValue] == -1)
	{
		//#ifdef DEBUG 
		NSLog(@"UIEditCameraViewController: saveCamera: newCamera");
		//#endif

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
		totalCameraCnt++;
	}
	else if([index intValue] < [fetchedObjects count])
	{
		SentinelInfo *mo = [fetchedObjects objectAtIndex:[index intValue]];

		//#ifdef DEBUG
		NSLog(@"UIEditCameraViewController: saveCamera: editing camera at index: %d",
				[index intValue]);
		//#endif

		[mo setValue:ipaddress.text forKey:@"ipAddress"];
		[mo setValue:password.text forKey:@"password"];
		[mo setValue:cameraname.text forKey:@"cameraName"];
		[mo setValue:username.text forKey:@"userName"];

		if(![contextnew save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
		totalCameraCnt = [index intValue];
	}
	[fetchRequest release];
	fetchRequest = nil;

	//#ifdef DEBUG
	NSLog(@"UIEditCameraViewController: saveCamera: Done Saving");
	//#endif
	
	/*set isDefaultCamera to -1 when user adds a camera*/
	
	fetchRequest = [[NSFetchRequest alloc] init];
	contextDefaultCam = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
			  @"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjectsDC = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	
	if([fetchedObjectsDC count] == 0) {
		
		DefaultCamera *moDC = 
		[NSEntityDescription insertNewObjectForEntityForName:@"DefaultCamera"
									  inManagedObjectContext:contextDefaultCam];
		
		if(defCameraFlag == 0)
		{
			//[moDC setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
			//NSLog(@"DefaultCamera Empty in EditCam : Save: New Cam : Default Cam set to -1");
		}
		else
		{
			[moDC setValue:[NSNumber numberWithInt:totalCameraCnt] forKey:@"isDefaultCamera"];
			NSLog(@"DefaultCamera Empty in EditCam : Save: New Cam : Default Cam set to %d", totalCameraCnt);
		}
		if(![contextDefaultCam save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
	}
	else
	{
		fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
		DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
		
		if(defCameraFlag == 0 && totalCameraCnt == [mo.isDefaultCamera intValue])
		{
			[mo setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
			NSLog(@"DefaultCamera Not Empty in EditCam : Save: New Cam : Default Cam set to -1");
		}
		else if(defCameraFlag == 1) 
		{
			[mo setValue:[NSNumber numberWithInt:totalCameraCnt] forKey:@"isDefaultCamera"];
			NSLog(@"DefaultCamera Not Empty in EditCam : Save: New Cam : Default Cam set to %d", totalCameraCnt);
		}
			 
		 if(![contextDefaultCam save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
	}
	/*End: set isDefaultCamera to -1 when user adds a camera*/
	[fetchRequest release];
	fetchRequest = nil;
	[self.navigationController popViewControllerAnimated:YES];
}

/*set default camera*/
- (IBAction) onTouchDefaultCamera:(id)sender
{
	
	NSLog(@"onTouchDefaultCamera being called");
	
	//removeDefaultCamera.hidden = YES;
	
	AppDelegate_iPhone *appDelegate =
	(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];	
	
	/*get index*/
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
	
	NSLog(@"UIEditCameraViewController: DefaultCamera: index: %d", [index intValue]);
	
	[fetchRequest release];
	fetchRequest = nil;
	
#ifdef DEBUG
	NSLog(@"UIEditCameraViewController: DefaultCamera: index: %d", [index intValue]);
#endif
	/*get index end*/
	
	/*get camera obj count*/
	
	fetchRequest = [[NSFetchRequest alloc] init];
	contextnew = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
			  @"SentinelInfo" inManagedObjectContext:contextnew];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
	NSNumber *camCount = [NSNumber numberWithInteger:[fetchedObjects count]];
	NSLog(@"UIEditCameraViewController: DefaultCamera: Camera: %d", [camCount intValue]);
	
	[fetchRequest release];
	fetchRequest = nil;	
	
	/*get camera obj count end*/
	
	/*set the default camera value*/
	
	fetchRequest = [[NSFetchRequest alloc] init];
	contextDefaultCam = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
			  @"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	
	/*
	 fetchRequest = [[NSFetchRequest alloc] init];
	 contextDefaultCam = [appDelegate managedObjectContext];
	 */
	
	if([fetchedObjects count] == 1) {
		
		DefaultCamera *defaultCameraObj = [fetchedObjects objectAtIndex:0];
		NSNumber *currentDefaultCamera = [NSNumber numberWithInteger:[defaultCameraObj.isDefaultCamera intValue]];
		
		/*reset previous default camera*/
		if([currentDefaultCamera intValue] == [index intValue]) {
			DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
			[mo setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
		}
		
		/*for the new camera*/
		if([index intValue] == -1) {
			
			NSLog(@"New default cam index %d",[camCount intValue]);
			
			DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
			[mo setValue:[NSNumber numberWithInt:[camCount intValue]] forKey:@"isDefaultCamera"];
			
			if(![contextDefaultCam save:&error])
			{
				NSLog(@"Error Saving contextDefaultCam");
			}
			
			NSLog(@"UIEditCameraViewController: isDefaultCamera: index: %d", [camCount intValue]);
			
		}
		
		/*for the existing camera*/
		else if([index intValue] < [camCount intValue]) {
			
			
			DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
			[mo setValue:[NSNumber numberWithInt:[index intValue]] forKey:@"isDefaultCamera"];
			
			if(![contextDefaultCam save:&error])
			{
				NSLog(@"Error Saving contextDefaultCam");
			}
			
			NSLog(@"UIEditCameraViewController: isDefaultCamera: index: %d", [index intValue]);
		}
	}
	
	//setDefaultCamera.hidden = YES;
	//removeDefaultCamera.hidden = NO;
	
	[fetchRequest release];
	fetchRequest = nil;
}

-(void)checkboxButton:(id)sender
{
	if (checkboxSelected == 0){
		[viewPassword setSelected:YES];
		checkboxSelected = 1;
		password.secureTextEntry = NO;
	} else {
		[viewPassword setSelected:NO];
		checkboxSelected = 0;
		password.enabled = NO;
		password.secureTextEntry = YES;
		password.enabled = YES;
		[password becomeFirstResponder];
	}
}

-(void)setDefaultCameraToggle:(id)sender
{
	if (defCameraFlag == 0){
		[setDefaultCamera setSelected:YES];
		defCameraFlag = 1;
	} else {
		[setDefaultCamera setSelected:NO];
		defCameraFlag = 0;
	}
}
/*set default camera end*/

/*Begin: Remove Default Camera*/
- (IBAction) onTouchRemoveDefaultCamera:(id)sender
{
	NSLog(@"onTouchzRemoveDefaultCamera being called");
	
	AppDelegate_iPhone *appDelegate =
	(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];	
	
	/*get index*/
	contextDefaultCam = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
	
	if([fetchedObjects count] > 0) {
		
		DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
		//NSNumber *currentDefaultCamera = [NSNumber numberWithInteger:[mo.isDefaultCamera intValue]];
		//if([currentDefaultCamera intValue] != -1) {
		[mo setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
		
		if(![contextDefaultCam save:&error])
		{
			NSLog(@"Error Saving contextDefaultCam");
		}
	}
	
	//removeDefaultCamera.hidden = YES;
	//setDefaultCamera.hidden = NO;
}
/*End: Remove Default Camera*/

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
		
		/*Begin: handle delete default camera*/
		fetchRequest = [[NSFetchRequest alloc] init];
		contextDefaultCam = [appDelegate managedObjectContext];
		entity = [NSEntityDescription entityForName:
				  @"DefaultCamera" inManagedObjectContext:contextDefaultCam];
		
		[fetchRequest setEntity:entity];
		[fetchRequest setReturnsObjectsAsFaults:NO];
		
		fetchedObjects = [contextDefaultCam executeFetchRequest:fetchRequest error:&error];
		DefaultCamera *defaultCameraObj = [fetchedObjects objectAtIndex:0];
		NSNumber *index = [NSNumber numberWithInteger:[defaultCameraObj.isDefaultCamera intValue]];
		
		NSLog(@"Camera getting deleted: %d and Default Camera: %d",cameraIndex,[index intValue]);
		
		if([index intValue] == cameraIndex) {
			DefaultCamera *mo = [fetchedObjects objectAtIndex:0];
			[mo setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
			
			if(![contextDefaultCam save:&error])
			{
				NSLog(@"Error Saving contextDefaultCam");
			}
		}
		/*End: handle delete default camera*/
		
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
	checkboxSelected = 0;
    [super viewDidLoad];
	self.title = @"Camera Details";
	
	//removeDefaultCamera.hidden = YES;
	
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

		deleteCamera.hidden = NO;
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

		deleteCamera.hidden = YES;
	}
	
	/*hide setDefaultCamera button if selected camera is already a default camera*/
	
	AppDelegate_iPhone *appDelegateDC =
	(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	
	contextDefaultCam = [appDelegateDC managedObjectContext];
	
	NSFetchRequest *fetchRequestDC = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDC = [NSEntityDescription 
									 entityForName:@"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequestDC setEntity:entityDC];
	[fetchRequestDC setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjectsDC = [contextDefaultCam executeFetchRequest:fetchRequestDC error:&error];
	
	if([fetchedObjectsDC count] > 0) {
		
		DefaultCamera *defaultCameraObj = [fetchedObjectsDC objectAtIndex:0];
		NSNumber *currentDefaultCamera = [NSNumber numberWithInteger:[defaultCameraObj.isDefaultCamera intValue]];
		
		if([currentDefaultCamera intValue] == [index intValue] && [index intValue] != -1) {
				[setDefaultCamera setSelected:YES];
				defCameraFlag = 1;
		}
	}
	else {
		[setDefaultCamera setSelected:NO];
		defCameraFlag = 0;
	}

	
	[fetchRequestDC release];
	fetchRequestDC = nil;

}

-(IBAction)backgroundTouched:(id)sender
{
	[ipaddress resignFirstResponder];
	[username resignFirstResponder];
	[password resignFirstResponder];
	[cameraname resignFirstResponder];
}

- (void) viewWillAppear:(BOOL)animated
{
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];
}

- (IBAction) ipaddressEntryStart:(id)sender
{
	
}

- (IBAction) usernameEntryStart:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,60) animated:YES];
}

- (IBAction) passwordEntryStart:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,100) animated:YES];
}

- (IBAction) cameranameEntryStart:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,180) animated:YES];
}

- (IBAction) onTouchOutsideCameraName:(id)sender
{
	NSLog(@"onTouchOutsideCameraName called");
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsidePassword:(id)sender
{
	[cameraParamsScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction) onTouchOutsideIPaddress:(id)sender
{
	NSLog(@"onTouchOutsideIPaddress called");
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
