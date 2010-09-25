//
//  EditStringViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberController : UIViewController <UITableViewDataSource> {
	BabyNotesAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextField *textField;
	
	id currentObject;
	SEL currentProperty;
	int decimalPlaces;
}

- (id)initWithObject:(id)aObject property:(SEL)aProperty decimalPlaces:(int)aDecimalPlaces;
- (id)initWithObject:(id)aObject property:(SEL)aProperty;

- (IBAction)valueChanged:(id)sender;
- (void)doneAction:(id)sender;

@end
