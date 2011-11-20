//
//  UIViewSnapshotsViewController.m
//  Sentinel
//
//  Created by SentinelTeam on 11/10/11.
//  Copyright 2011 Self. All rights reserved.
//

#import "UISnapshotsViewController.h"
#import "UISnapImageViewController.h"

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

- (void)viewWillAppear:(BOOL)animated 
{
    self.view.backgroundColor = 
        [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainviewbg.png"]];

    [self loadSnapshotsArray];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
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
                
                [cell.imageButton1 addTarget:self 
                                      action:@selector(onImageClick:) 
                            forControlEvents:UIControlEventTouchUpInside];
                [cell.imageButton2 addTarget:self 
                                      action:@selector(onImageClick:) 
                            forControlEvents:UIControlEventTouchUpInside];
                [cell.imageButton3 addTarget:self 
                                      action:@selector(onImageClick:) 
                            forControlEvents:UIControlEventTouchUpInside];
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

        [cell.imageButton1 setImage:image forState:UIControlStateNormal];
        cell.imageButton1.imagePath = fullPath;
        
        [image release];
        [fullPath release];
    }
    
    index++;
    
    if (index < [theSnapshotsArray count])
    {
        NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@", 
                              theSnapshotsRootDir, 
                              [theSnapshotsArray objectAtIndex:index]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        
        [cell.imageButton2 setImage:image forState:UIControlStateNormal];
        cell.imageButton2.imagePath = fullPath;
        
        [image release];
        [fullPath release];
    }
    
    index ++;

    if (index < [theSnapshotsArray count])
    {
        NSString* fullPath = [[NSString alloc] initWithFormat:@"%@/%@", 
                              theSnapshotsRootDir, 
                              [theSnapshotsArray objectAtIndex:index]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];

        [cell.imageButton3 setImage:image forState:UIControlStateNormal];
        cell.imageButton3.imagePath = fullPath;
        
        [fullPath release];
        [image release];
    }
    
    return cell;
}

- (void) loadSnapshotsArray
{
    if (!theSnapshotsArray)
    {
        [theSnapshotsArray release];
        [self.theSnapshotsRootDir release];
    }
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


- (void) onImageClick:(id) sender
{
    UISnapshotImageButton *button = (UISnapshotImageButton *)sender;
    
    UIImageView *imageView = [[UIImageView alloc] 
                               initWithImage:button.imageView.image];
	
	[self.view addSubview:imageView];
    
    UISnapImageViewController *viewctr = [[UISnapImageViewController alloc] 
                                          initWithNibName:@"UISnapImageViewController" 
                                          bundle:nil];
    [viewctr.view addSubview:imageView];
    viewctr.imagePath = button.imagePath;
    
	[self.navigationController pushViewController:viewctr animated:YES];
	[viewctr release];
	[imageView release];
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

@synthesize imageButton1;
@synthesize imageButton2;
@synthesize imageButton3;

@end

@implementation UISnapshotImageButton

@synthesize imagePath;


- (void) dealloc
{
    [imagePath release];
    [super dealloc];
}
@end

