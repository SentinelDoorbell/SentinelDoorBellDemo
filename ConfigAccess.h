/*
 * Copyright 2011 SentinelTeam. All rights reserved.
 *
 * Title   : Configuration Access
 * Function: This is a singleton object that is shared by all the components in 
 *         : the application. It reads xml file which has the configurations for
 *         : camera models supported by the app. (Header)
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

#import <Foundation/Foundation.h>

#define DEBUG 1

/*
 * Config access which contains the dictionary of the supported configuration
 * read from the xml file shipped with the app. It also has a reference to the
 * current camera being used.
 *
 * This is a singleton class so only one object will be created in the app.
 */
@interface ConfigAccess : NSObject 
{
    NSDictionary* theDctRoot;
    
    NSDictionary* theCurrentCam;
}

@property (retain) NSDictionary* theDctRoot;

@property (retain) NSDictionary* theCurrentCam;

/*
 * Initialize the config access object using the passed xml file. 
 */
- (ConfigAccess *) initWithFile:(NSString *)fileName;

/*
 * static helper method that given the base url and an action, it will return
 * NSURL object representing the request that should be used to perform
 * the action.
 */
+ (NSURL *) urlForAction:(NSString*) baseUrl action:(NSString *) action;

/*
 * static helper method that given the base url and an action, it will perform
 * the action using the config access which has the mapping between actions and
 * urls.
 */
+ (void) performAction:(NSString *)baseUrl action:(NSString *) action;

/*
 * Singleton instance.
 */
+ (ConfigAccess *) instance;

@end