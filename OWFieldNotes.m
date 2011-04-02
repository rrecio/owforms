//
//  OWFieldNotes.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldNotes.h"
#import "NotesController.h"

@implementation OWFieldNotes

- (UIViewController *)actionController {
    NotesController *controller = [[NotesController alloc] initWithNibName:@"NotesController" bundle:nil];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];

    if (self.value == nil || [self.value isEqualToString:@""]) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.text = NSLocalizedString(@"Description", @"");
    } else {
        cell.textLabel.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
        cell.textLabel.text = self.value;
    }
    
    return cell;
}

@end
