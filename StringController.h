//
//  EditStringViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyNotesAppDelegate.h"

@interface StringController : UIViewController <UITableViewDataSource> {
	BabyNotesAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextField *textField;
	NSMutableString *texto;
}

@property (nonatomic, retain) NSMutableString *texto;

- (void)doneAction:(id)sender;

@end
