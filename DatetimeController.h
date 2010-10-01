//
//  DatetimeController.h
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface DatetimeController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *tableView;
	UIDatePicker *datePicker;
	NSDateFormatter *dateFormatter;
	OWField *field;
}

@property (nonatomic, retain) OWField *field;

- (void)valueChanged:(id)sender;
- (void)doneAction:(id)sender;

@end