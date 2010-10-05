//
//  AppDelegate_Shared.h
//  OWForms
//
//  Created by Madson on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate_Shared : NSObject <UIApplicationDelegate> {
	NSMutableDictionary *imageCache;
}

@property (nonatomic, retain) NSMutableDictionary *imageCache;

@end

NSString *pathInDocumentDirectory(NSString *fileName);