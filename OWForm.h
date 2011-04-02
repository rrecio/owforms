//
//  OWForm.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OWField.h"
#import "OWSection.h"
#import "OWFieldText.h"
#import "OWFieldNumber.h"
#import "OWFieldDate.h"
#import "OWFieldDateTime.h"
#import "OWFieldImage.h"
#import "OWFieldList.h"
#import "OWFieldForm.h"
#import "OWFieldNotes.h"

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

@property(nonatomic, retain) NSArray *formFields;
@property(nonatomic, retain) NSMutableArray *sections;
@property(nonatomic) BOOL showSaveButton;
@property(nonatomic) BOOL showCancelButton;
@property(nonatomic, retain) NSString *saveButtonTitle;
@property(nonatomic, retain) NSString *cancelButtonTitle;
@property(nonatomic, assign) id <OWFormDataSourceDelegate>delegate;

- (id)initWithFields:(NSArray *)fieldsArray;
- (id)initWithStyle:(UITableViewStyle)style andFields:(NSArray *)fieldsArray;
- (id)initWithSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithStyle:(UITableViewStyle)style andSections:(OWSection *)firstSection, ... NS_REQUIRES_NIL_TERMINATION;
- (CGFloat)specialRowHeightForString:(NSString *)aString;
- (void)doSaveAction;
- (void)doCancelAction;
+ (NSMutableDictionary *)imageCache;

@end


@protocol OWFormDataSourceDelegate
@required
- (void)saveAction:(OWForm *)form;
- (void)cancelAction;
@end
