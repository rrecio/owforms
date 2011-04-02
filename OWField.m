//
//  OWField.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWField.h"
#import "OWForm.h"

@implementation OWField

@synthesize style;
@synthesize label;
@synthesize value;
@synthesize accessoryType;
@synthesize accessoryView;
@synthesize startDate;
@synthesize endDate;
@synthesize list;

- (id)initWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue {
    self = [super init];
    if (self != nil) {
        self.label = aLabel;
        self.value = aValue;
    }
    return self;
}

- (UIViewController *)actionController {
    // subclass must implement this
    return nil;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell.textLabel.text = self.label;

    cell.accessoryType = (self.accessoryType) ? self.accessoryType : UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = self.accessoryView;

    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end
