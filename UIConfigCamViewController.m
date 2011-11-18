//
//  UIConfigCameraViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/9/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UIConfigCamViewController.h"
#import "UIEditCamDetailViewController.h"
#import "AppDelegate_iPhone.h"
#import <CoreData/CoreData.h>
#import "SentinelInfo.h"
#import "EditInfoCameraView.h"

@implementation UIConfigCamViewController

@synthesize context;
@synthesize contextnew;

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
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
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

	UIEditCamDetailViewController *viewctr = [[UIEditCamDetailViewController alloc] 
                                              initWithNibName:@"UIEditCamDetailView" 
                                              bundle:nil];
	
	
	[self.navigationController pushViewController:viewctr animated:YES];
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

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)saveCredentials:(id)sender
{
    
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
	
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	
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
	
	[self.navigationController pushViewController:viewctr animated:YES];
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