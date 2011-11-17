//
//  SentinelInfo.h
//  Sentinel
//
//  Created by SentinelTeam on 11/16/11.
//  Copyright 2011 Self. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface SentinelInfo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * ipAddress;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * cameraName;
@property (nonatomic, retain) NSString * userName;

@end



