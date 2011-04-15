//
//  OWFieldText.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldText.h"
#import "StringController.h"

@implementation OWFieldText

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
