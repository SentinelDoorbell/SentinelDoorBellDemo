//
//  viewSnapshots.m
//  navS
//
//  Created by Guest Account on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UISnapshotsViewController.h"


@implementation UISnapshotsViewController


#pragma mark -
#pragma mark View lifecycle

@synthesize theSnapshotsArray;
@synthesize theSnapshotsRootDir;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
	self.title = @"Snapshots";
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    [self loadSnapshotsArray];

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section 
{
    if (([theSnapshotsArray count] % 3) == 0)
    {
        return ([theSnapshotsArray count] / 3);
    }
    else
    {
        return (([theSnapshotsArray count] / 3) + 1);
    }

    return [theSnapshotsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"UISnapCell";

    int row = indexPath.row;
    
    UISnapshotViewCell *cell = (UISnapshotViewCell *)
                   [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"UISnapCell" 
                                                     owner:self options:nil];
        
        for (id ob in arr)
        {
            if ([ob isKindOfClass:[UISnapshotViewCell class]])
            {
                cell = (UISnapshotViewCell *) ob;
                break;
            }
        }
    } 

    int index = row * 3;
                          
    if (index < [theSnapshotsArray count])
    {
        NSString* str = [theSnapshotsArray objectAtIndex:index];
  
        NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@", 
                              theSnapshotsRootDir, str];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        [fullPath release];

        cell.imageView1.image = image;
    }
    
    index++;
    
    if (index < [theSnapshotsArray count])
    {
        NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@", 
                              theSnapshotsRootDir, 
                              [theSnapshotsArray objectAtIndex:index]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        [fullPath release];
        
        cell.imageView2.image = image;
    }
    
    index ++;

    if (index < [theSnapshotsArray count])
    {
        NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@", 
                              theSnapshotsRootDir, 
                              [theSnapshotsArray objectAtIndex:index]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        [fullPath release];
        cell.imageView3.image = image;
    }
    
    return cell;
}

- (void) loadSnapshotsArray
{
    if (!theSnapshotsArray)
    {
        self.theSnapshotsRootDir = 
            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                 NSUserDomainMask, 
                                                 YES)
                          objectAtIndex:0];

        NSArray *dirContents = [[NSFileManager defaultManager] 
                                contentsOfDirectoryAtPath:theSnapshotsRootDir 
                                error:nil];

    
        self.theSnapshotsArray = [[NSArray alloc] 
                                  initWithArray:[dirContents 
                                        filteredArrayUsingPredicate:[NSPredicate 
                                   predicateWithFormat:@"self ENDSWITH '.jpg'"]] 
                                  copyItems:YES];
    }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [theSnapshotsRootDir release];
    [theSnapshotsArray release];
    [super dealloc];
}


@end

@implementation UISnapshotViewCell

@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;

@end

