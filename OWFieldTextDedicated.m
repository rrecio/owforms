//
//  OWFieldText.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldTextDedicated.h"
#import "StringController.h"

@implementation OWFieldTextDedicated

@synthesize isPassword;

- (UIViewController *)actionController {
    StringController *controller = [[StringController alloc] initWithNibName:@"StringController" bundle:nil];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    cell.detailTextLabel.text = self.value;

    return cell;
}

@end
