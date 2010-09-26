//
//  OWField.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWField.h"


@implementation OWField

@synthesize style, label, value, accessoryType, accessoryView;

- (id)initWithStyle:(OWFieldStyle)aStyle label:(NSString *)aLabel value:(id)aValue {
	self = [super init];
	
	if (self != nil) {
		self.style = aStyle;
		self.label = aLabel;
		self.value = aValue;
	}
	
	return self;
}

@end
