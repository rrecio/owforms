//
//  OWFieldSwitch.h
//  OWForms
//
//  Created by Madson on 02/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OWField.h"

@interface OWFieldSwitch : OWField {
    UISwitch *switchView;
}

@property (nonatomic, retain) UISwitch *switchView;

@end