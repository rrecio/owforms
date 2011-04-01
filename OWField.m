//
//  OWField.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWField.h"


@implementation OWField

@synthesize style;
@synthesize label;
@synthesize value;
@synthesize accessoryType;
@synthesize accessoryView;
@synthesize startDate;
@synthesize endDate;
@synthesize list;
@synthesize selectable;

- (id)initWithStyle:(OWFieldStyle)aStyle label:(NSString *)aLabel value:(id)aValue {
	self = [super init];
	
	if (self != nil) {
		self.style = aStyle;
		self.label = aLabel;
		self.value = aValue;
		self.selectable = (aStyle != OWFieldStyleSwitch);
        
        if (aStyle == OWFieldStyleString || aStyle == OWFieldStyleList || aStyle == OWFieldStyleForm)
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	return self;
}

@end
