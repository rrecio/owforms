//
//  OWTableViewCell.m
//  OWForms
//
//  Created by Rodrigo Recio on 27/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWTableViewCell.h"

@implementation OWTableViewCell

@synthesize switchView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)showSwitch:(BOOL)show {
	if (show) {
		UISwitch *view = [[UISwitch alloc] initWithFrame:CGRectMake(195, 8, 95, 8)];
		self.switchView = view;
		[view release];
		[self.contentView addSubview:self.switchView];
	} else {
		[self.switchView removeFromSuperview];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	self.switchView = nil;
    [super dealloc];
}


@end
