//
//  NotesViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;
@interface NotesController : UIViewController <UITableViewDataSource> {
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextView *textView;
	NSMutableString *texto;
}

@property (nonatomic, retain) NSMutableString *texto;
@property (nonatomic, retain) OWField *field;

- (void)doneAction:(id)sender;

@end
