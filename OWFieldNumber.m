//
//  OWFieldNumber.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldNumber.h"
#import "NumberController.h"

@implementation OWFieldNumber

- (UIViewController *)actionController {
    NumberController *controller = [[NumberController alloc] initWithDecimalPlaces:2];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    cell.detailTextLabel.text = [(NSNumber *)self.value stringValue];
    
    return cell;
}
@end
