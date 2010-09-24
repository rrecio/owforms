//
//  OWForm.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWField.h"

@interface OWForm : UITableViewController {
}

@property(nonatomic, retain) NSArray *fields;

- (id)initWithFields:(NSArray *)fieldsArray;

@end
