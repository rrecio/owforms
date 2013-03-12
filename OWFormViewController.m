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

- (void)loadForm
{
    self.delegate = self;
}

- (BOOL)formShouldCancel:(OWForm *)form
{
    
}

- (BOOL)formShouldEndWithSuccess:(OWForm *)form
{
    
}

- (void)formDidCancel:(OWForm *)form
{
    
}

- (void)formDidEndWithSuccess:(OWForm *)form
{
    
}

@end
