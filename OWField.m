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

@synthesize label;
@synthesize value;
@synthesize accessoryType;
@synthesize accessoryView;
@synthesize startDate;
@synthesize endDate;
@synthesize list;
@synthesize required;

+ (id)fieldWithLabel:(NSString *)aLabel {
    return [self fieldWithLabel:aLabel andValue:nil];
}

+ (id)fieldWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue {
    return [[[self alloc] initWithLabel:aLabel andValue:aValue] autorelease];
}

- (id)initWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue {
    self = [super init];
    if (self != nil) {
        self.label = aLabel;
        self.value = aValue;
        self.required = NO;
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

- (BOOL)isEmpty {
    if (self.value != nil && [self.value isKindOfClass:[NSString class]]) {
        NSString *aValue = [self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return (aValue == nil || [aValue isEqualToString:@""]);
    }
    return self.value == nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
