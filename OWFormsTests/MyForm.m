//
//  MyForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 10/05/12.
//  Copyright (c) 2012 Owera Software. All rights reserved.
//

#import "MyForm.h"

@interface MyForm ()
{
}
@end

@implementation MyForm

- (void)loadForm
{
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    OWFieldText *userName = [OWFieldText fieldWithLabel:@"User Name"];
    userName.textField.background = [UIImage imageNamed:@"form-field-bg@2x.png"];

    [self addField:userName];
    [self addField:[OWFieldText fieldWithLabel:@"E-mail"]];
    [self addField:[OWFieldText fieldWithLabel:@"Password"]];
}

@end
