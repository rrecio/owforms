//
//  MyForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 10/05/12.
//  Copyright (c) 2012 Owera Software. All rights reserved.
//

#import "MyForm.h"

@interface MyForm ()

@end

@implementation MyForm

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self loadForm];
    }
    return self;
}

- (void)loadForm
{
}

@end
