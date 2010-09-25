//
//  AppDelegate_iPhone.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "OWForm.h"
#import "OWField.h"
#import "OWSection.h"

@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	OWField *field1 = [[OWField alloc] initWithStyle:OWFieldStyleString label:@"Hello" value:@"World!"];
	OWField *field2 = [[OWField alloc] initWithStyle:OWFieldStyleNumber label:@"Number" value:[NSNumber numberWithInt:235.12]];
	OWField *field3 = [[OWField alloc] initWithStyle:OWFieldStyleDate label:@"Date" value:[NSDate date]];
	OWField *field4 = [[OWField alloc] initWithStyle:OWFieldStyleDateTime label:@"DateTime" value:[NSDate date]];
	
	OWSection *section1 = [OWSection sectionWithFields:field1, field2, nil];
    section1.title = @"Ki legau!!!";
    OWSection *section2 = [OWSection sectionWithFields:field3, field4, nil];
    section2.title = @"DIMAIXXX!";
    NSLog(@"Quantidade de campos: %i", [section1.fields count]);
               
    OWForm *form = [[OWForm alloc] initWithTitle:@"AKKAKAK" style:UITableViewStyleGrouped andSections:section1, section2, nil];

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:form];
    [window addSubview:navController.view];
	[window makeKeyAndVisible];
//	[navController release];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
