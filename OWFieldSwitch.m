//
//  OWFieldSwitch.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldSwitch.h"

@implementation OWFieldSwitch

@synthesize switchView;

- (UIViewController *)actionController {
    return nil;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (cell.switchView == nil)
    {
        UISwitch *aSwitch = nil;
        aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 8, 95, 8)];
        aSwitch.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        [aSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        
        [cell setSwitchView:aSwitch];
        [cell.contentView addSubview:aSwitch];
        [aSwitch release];
    }

    cell.switchView.on = [self.value boolValue];

    return cell;
}

- (void)changeSwitch:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    self.value = (sw.on) ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
}

@end
