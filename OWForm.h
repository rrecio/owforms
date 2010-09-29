//
//  OWForm.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWSection;
@class OWField;

@class OWSection;
@interface OWForm : UITableViewController {

}

@property(nonatomic, retain) NSArray *formFields;
@property(nonatomic, retain) NSMutableArray *sections;

- (id)initWithFields:(NSArray *)fieldsArray;
- (id)initWithStyle:(UITableViewStyle)style andFields:(NSArray *)fieldsArray;
- (id)initWithSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithStyle:(UITableViewStyle)style andSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;

@end
