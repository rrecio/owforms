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
        
    if ([self.value intValue] >= 0)
        cell.detailTextLabel.text = [self.list objectAtIndex:[self.value intValue]];
    else
        cell.detailTextLabel.text = @"Selecione";

    return cell;
}

@end
