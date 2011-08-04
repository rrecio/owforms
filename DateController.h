//
//  DateController.h
//  OWForms
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface DateController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *tableView;
	UIDatePicker *datePicker;
	NSDateFormatter *dateFormatter;
	OWField *field;
}

@property (nonatomic, retain) OWField *field;

- (void)cancelar;
- (void)valueChanged:(id)sender;
- (void)doneAction:(id)sender;

@end