//
//  OWFieldForm.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldForm.h"
#import "OWForm.h"

@implementation OWFieldForm

- (UIViewController *)actionController {
    return self.value;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    return cell;
}

- (BOOL)isEmpty {
    BOOL result = NO;
    OWForm *form = self.value;
    for (OWSection *section in form.sections) {
        for (OWField *field in section.fields) {
            if ([field isEmpty]) result = YES;
        }
    }
    return result;
}

@end
