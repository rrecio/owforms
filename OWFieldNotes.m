//
//  OWFieldNotes.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldNotes.h"
#import "NotesController.h"
#import "OWTableViewCell.h"

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
        cell.textLabel.text = self.label;
    } else {
        cell.textLabel.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
        cell.textLabel.text = self.value;
    }
    
    return cell;
}

- (CGFloat)specialRowHeightForString:(NSString *)aString {
	CGSize maximumLabelSize = CGSizeMake(270, 1000);
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:16];
	CGSize size = [aString sizeWithFont:font
                      constrainedToSize:maximumLabelSize
                          lineBreakMode:UILineBreakModeWordWrap];
	return size.height;
}

- (CGFloat)height
{
    CGFloat height = [self specialRowHeightForString:(NSString *)self.value] + 20;
    if (height < 44) {
        height = 44;
    }
    return height;
}

- (OWTableViewCell *)cellInstance
{
    OWTableViewCell *cell = [[[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier] autorelease];
    cell.textLabel.numberOfLines = 1000;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    return cell;
}

@end
