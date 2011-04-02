//
//  OWFieldSwitch.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldSwitch.h"

@implementation OWFieldSwitch

- (UIViewController *)actionController {
    return nil;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (cell.switchView == nil)
    {
        UISwitch *switchView = nil;
        switchView = [[UISwitch alloc] initWithFrame:CGRectMake(208, 8, 95, 8)];
        switchView.on = [self.value boolValue];
        switchView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [switchView addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        
        [cell setSwitchView:switchView];
        [cell addSubview:switchView];
    }

    return cell;
}

- (void)changeSwitch:(id)sender {
    UISwitch *sw = (UISwitch *)sender;
    self.value = (sw.on) ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
}

@end
