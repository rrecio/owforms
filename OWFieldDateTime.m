//
//  OWFieldDateTime.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldDateTime.h"
#import "DatetimeController.h"

@implementation OWFieldDateTime

- (UIViewController *)actionController {
    DatetimeController *controller = [[DatetimeController alloc] init];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [formatter stringFromDate:self.value];
    [formatter release];

    return cell;
}
@end
