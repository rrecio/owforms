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

@interface OWForm : UITableViewController {

}

@property(nonatomic, retain) NSArray *formFields;
@property(nonatomic, retain) NSMutableArray *sections;

- (id)initWithTitle:(NSString *)aTitle andFields:(NSArray *)fieldsArray;
- (id)initWithTitle:(NSString *)aTitle style:(UITableViewStyle)style andFields:(NSArray *)fieldsArray;
- (id)initWithTitle:(NSString *)aTitle andSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString *)aTitle style:(UITableViewStyle)style andSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;

@end
