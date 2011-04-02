//
//  OWFieldForm.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldForm.h"

@implementation OWFieldForm

- (UIViewController *)actionController {
    return self.value;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    return cell;
}

@end
