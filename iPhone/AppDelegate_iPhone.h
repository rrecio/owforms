//
//  AppDelegate_iPhone.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSNumber *boolean;
}

@property(nonatomic, retain) NSNumber *boolean;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

