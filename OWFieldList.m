//
//  OWFieldList.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldList.h"
#import "ListController.h"

@implementation OWFieldList

- (UIViewController *)actionController {
    ListController *controller = [[ListController alloc] initWithField:self];
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
        
    if (self.value != nil)
        if ([self.value intValue] < [self.list count])
            cell.detailTextLabel.text = [self.list objectAtIndex:[self.value intValue]];
        else
            cell.detailTextLabel.text = nil;
    else
        cell.detailTextLabel.text = nil;

    return cell;
}

@end
