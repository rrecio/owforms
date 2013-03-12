//
//  OWFormViewController.m
//  OWForms
//
//  Created by Rodrigo Recio on 3/12/13.
//
//

#import "OWFormViewController.h"

@interface OWFormViewController ()

@end

@implementation OWFormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.delegate = self;
    return self;
}

- (void)loadForm
{
}

- (BOOL)formShouldCancel:(OWForm *)form
{
    return YES;
}

- (BOOL)formShouldEndWithSuccess:(OWForm *)form
{
    return YES;
}

- (void)formDidCancel:(OWForm *)form
{
    
}

- (void)formDidEndWithSuccess:(OWForm *)form
{
    
}

- (BOOL)form:(OWForm *)form shouldEditField:(OWField *)field
{
    return YES;
}

@end
