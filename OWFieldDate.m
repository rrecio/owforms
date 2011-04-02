//
//  OWFieldDate.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldDate.h"
#import "DateController.h"

@implementation OWFieldDate

- (UIViewController *)actionController {
    DateController *controller = [[DateController alloc] init];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    cell.detailTextLabel.text = [formatter stringFromDate:self.value];
    [formatter release];
    
    return cell;
}

@end
