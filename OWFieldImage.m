//
//  OWFieldImage.m
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWFieldImage.h"
#import "ImageController.h"

@implementation OWFieldImage

- (UIViewController *)actionController {
    ImageController *controller = [[ImageController alloc] init];
    controller.field = self;
    return [controller autorelease];
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    
    cell.imageView.image = self.value;

    return cell;
}

@end
