//
//  OWTableViewCell.m
//  OWForms
//
//  Created by Rodrigo Recio on 27/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWTableViewCell.h"

@implementation OWTableViewCell

@synthesize switchView;
@synthesize textField;

- (void)showSwitch:(BOOL)show
{
	if (show) {
		UISwitch *view = [[UISwitch alloc] initWithFrame:CGRectMake(195, 8, 95, 8)];
		self.switchView = view;
		[view release];
		[self.contentView addSubview:self.switchView];
	} else {
		[self.switchView removeFromSuperview];
	}
}

- (void)dealloc {
	self.switchView = nil;
    [super dealloc];
}


@end
