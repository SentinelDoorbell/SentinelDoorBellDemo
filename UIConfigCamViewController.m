/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Config Camera View
 * Function: Table view with a list of all the cameras configured. It is used 
 *         : for modifying exiting configuration, adding new cameras or deleting 
 *         : existing ones. (Implementation)
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

#import "UIConfigCamViewController.h"
#import "UIEditCamDetailViewController.h"
#import "AppDelegate_iPhone.h"
#import <CoreData/CoreData.h>
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"
#import "DefaultCamera.h"

@implementation UIConfigCamViewController

@synthesize context;
@synthesize contextnew;
@synthesize contextDefaultCam;

- (void)addCamera:(id)sender 

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
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest 
                                                     error:&error];
	
	if([fetchedObjects count] == 0)
	{
		EditInfoCameraView *mo = 
			[NSEntityDescription insertNewObjectForEntityForName:@"EditInfoCameraView"
						inManagedObjectContext:context];
		
		[mo setValue:[NSNumber numberWithInt:-1] forKey:@"cameraIndex"];
		
		if(![context save:&error])
		{
			NSLog(@"UIConfigCamViewController: addCamera: %@ %@", error, [error userInfo]);
		}
	}
	else 
	{
		EditInfoCameraView *mo = [fetchedObjects objectAtIndex:0];
		[fetchRequest release];
		[mo setValue:[NSNumber numberWithInt:-1] forKey:@"cameraIndex"];
		if(![context save:&error])
		{
			NSLog(@"UIConfigCamViewController: addCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
	}
	
	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: addCamera: setting cameraIndex to -1");
	#endif
	
	/*begin: set isDefaultCamera to -1 when user is adding a new camera*/
	fetchRequest = [[NSFetchRequest alloc] init];
	contextDefaultCam = [appDelegate managedObjectContext];
	entity = [NSEntityDescription entityForName:
			  @"DefaultCamera" inManagedObjectContext:contextDefaultCam];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjectsDC = [contextDefaultCam executeFetchRequest:fetchRequest 
                                                                 error:&error];
	
	if([fetchedObjectsDC count] == 0) {
		NSLog(@"DefaultCamera Empty in EditCam : Save: Add Cam : Default Cam set to -1");
		DefaultCamera *moDC = 
		[NSEntityDescription insertNewObjectForEntityForName:@"DefaultCamera"
									  inManagedObjectContext:contextDefaultCam];
		
		[moDC setValue:[NSNumber numberWithInt:-1] forKey:@"isDefaultCamera"];
		
		if(![contextDefaultCam save:&error])
		{
			NSLog(@"UIEditCamDetailViewController: saveCamera: CoreDataSaveError");
			NSLog(@"%@ and %@", error, [error userInfo]);
		}
		
		[fetchRequest release];
		fetchRequest = nil;
	}
	
	/*End: set isDefaultCamera to -1 when user is adding a new camera*/

	UIEditCamDetailViewController *viewctr = [[UIEditCamDetailViewController alloc] 
                                              initWithNibName:@"UIEditCamDetailView" 
                                              bundle:nil];
	
	
	[UIView  beginAnimations:@"Showinfo" context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[self.navigationController pushViewController:viewctr animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
                           forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
	//[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}

#pragma mark -
#pragma mark View lifecycle



- (void)viewDidLoad {
    [super viewDidLoad];

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Edit Camera";
	//NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  
                             target:self   
                             action:@selector(addCamera:)];
	self.navigationItem.rightBarButtonItem = item; 
	[item release];
	
}


- (void)viewWillAppear:(BOOL)animated {

	self.title = @"Edit Camera";
	// The following section just prints the camera list
	#ifdef DEBUG
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
	
	NSLog(@"UIConfigCamViewController: viewwillappear: printing current camera details");
	
	if(fetchedObjects != NULL)
	{
		for(int i = 0; i <[fetchedObjects count]; i++)
		{
			SentinelInfo *info = [fetchedObjects objectAtIndex:i];
			NSLog(@"ipAddress: %@ | userName: %@ | password: %@ | cameraName: %@", 
				  info.ipAddress, info.userName, info.password, info.cameraName);
		}
		
	}
	else 
	{
		NSLog(@"fetchedObjects is null in viewwillappear of configcamera");
	}

	[fetchRequest release];
	#endif
	
	camList.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];

	[super viewWillAppear:animated];
	[camList reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
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

	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: numberOfRowsInSection %@", fetchedObjects);
	#endif

	if(fetchedObjects != NULL)
	{
		#ifdef DEBUG
		NSLog(@"UIConfigCamViewController: numberOfRowsInSection returning: %d", 
			  [fetchedObjects count]);
		#endif

		return [fetchedObjects count];
	}
	else 
	{
		#ifdef DEBUG
		NSLog(@"UIConfigCamViewController: numberOfRowsInSection returning: 0");
		#endif	

		return 0;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =
		[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier] autorelease];
    }
    
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
	
	SentinelInfo *info = [fetchedObjects objectAtIndex: indexPath.row];
	
	[fetchRequest release];
	
    // Configure the cell...
	cell.textLabel.text = info.cameraName;
	
	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: cellForRowAtIndexPath name: %@ at index %d",
		  cell.textLabel.text, indexPath.row);
	#endif	  

	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: 	didSelectRowAtIndexPath index: %d",
		  indexPath.row);
	#endif
	
	AppDelegate_iPhone *appDelegate =
		(AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	context = [appDelegate managedObjectContext];
	
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
	   entityForName:@"EditInfoCameraView" inManagedObjectContext:context];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setReturnsObjectsAsFaults:NO];
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest 
                                                     error:&error];
	
	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: 	didSelectRowAtIndexPath Editinfocameradetals count = %d %@",
		  [fetchedObjects count], fetchedObjects);
	#endif
	
	for (NSManagedObject *managedObject in fetchedObjects) 
	{
		[context deleteObject:managedObject];
	}
	if(![context save:&error])
	{
		NSLog(@"UIConfigCamViewController: didSelectRowAtIndexPath: CoreDataSaveError");
		NSLog(@"%@ and %@", error, [error userInfo]);
	}

	NSManagedObject *mo;

	mo = [NSEntityDescription insertNewObjectForEntityForName:@"EditInfoCameraView"
				inManagedObjectContext:context];

	unsigned int index = indexPath.row;
	[mo setValue:[NSNumber numberWithInteger:index] forKey:@"cameraIndex"];

	if(![context save:&error])
	{
		NSLog(@"UIConfigCamViewController: didSelectRowAtIndexPath: CoreDataSaveError");
		NSLog(@"%@ and %@", error, [error userInfo]);
	}
	
	#ifdef DEBUG
	NSLog(@"UIConfigCamViewController: 	didSelectRowAtIndexPath setting cameraIndex to %d", index);
	#endif

	[fetchRequest release];
	
	
	UIEditCamDetailViewController *viewctr = [[UIEditCamDetailViewController alloc] 
					initWithNibName:@"UIEditCamDetailView" 
					bundle:nil];
	
	[UIView  beginAnimations:@"Showinfo" context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.75];
	[self.navigationController pushViewController:viewctr animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	
	//[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end