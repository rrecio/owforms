//
//  AppDelegate_Shared.m
//  OWForms
//
//  Created by Madson on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_Shared.h"


@implementation AppDelegate_Shared

@synthesize imageCache;

- (id)init {
	self = [super init];

	imageCache = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)dealloc {
	[imageCache release];
	[super dealloc];
}

@end
