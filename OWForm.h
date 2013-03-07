//
//  OWForm.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWField.h"
#import "OWSection.h"
#import "OWFieldTextDedicated.h"
#import "OWFieldNumber.h"
#import "OWFieldDate.h"
#import "OWFieldDateTime.h"
#import "OWFieldImage.h"
#import "OWFieldList.h"
#import "OWFieldForm.h"
#import "OWFieldNotes.h"
#import "OWFieldSwitch.h"
#import "OWFieldText.h"

@protocol OWFormDataSourceDelegate;

@interface OWForm : UITableViewController  {
	OWField *currentField;
	BOOL showSaveButton;
	BOOL showCancelButton;
	NSString *saveButtonTitle;
	NSString *cancelButtonTitle;
    UIPopoverController *currentPopover;
	id <OWFormDataSourceDelegate>delegate;
}

@property(nonatomic, retain)    NSArray *formFields;
@property(nonatomic, retain)    NSMutableArray *sections;
@property(nonatomic)            BOOL showSaveButton;
@property(nonatomic)            BOOL showCancelButton;
@property(nonatomic, retain)    NSString *saveButtonTitle;
@property(nonatomic, retain)    NSString *cancelButtonTitle;
@property(nonatomic, assign)    id <OWFormDataSourceDelegate>delegate;
@property(nonatomic, retain)    UIImage *cellsBackgroundImage;
@property(assign)               UITableViewStyle tableViewStyle;

- (void)addDataFromDictionary:(NSDictionary *)dict;
- (NSDictionary *)fieldsDictionary;
+ (NSArray *)keys;
- (void)addSection:(OWSection *)section;
- (void)addSection:(OWSection *)section atIndexPath:(NSIndexPath *)indexPath;
- (void)addField:(OWField *)aField;
- (void)addField:(OWField *)aField atIndexPath:(NSIndexPath *)indexPath;
- (void)removeFieldAtIndexPath:(NSIndexPath *)indexPath;
- (id)initWithFields:(NSArray *)fieldsArray;
- (id)initWithStyle:(UITableViewStyle)style andFields:(NSArray *)fieldsArray;
- (id)initWithSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithStyle:(UITableViewStyle)style andSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (void)doSaveAction;
- (void)doCancelAction;
+ (NSMutableDictionary *)imageCache;
- (OWField *)fieldForLabel:(NSString *)aLabel;

- (BOOL)callActionControllerForField:(OWField *)selectedField selectedAtIndexPath:(NSIndexPath *)indexPath;
@end


@protocol OWFormDataSourceDelegate
@required
- (void)saveAction:(OWForm *)form;
- (void)cancelAction;
@end
