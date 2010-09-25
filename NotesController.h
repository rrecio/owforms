//
//  NotesViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesController : UIViewController <UITableViewDataSource> {
	BabyNotesAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextView *textView;
	NSMutableString *texto;
}

@property (nonatomic, retain) NSMutableString *texto;

- (void)doneAction:(id)sender;

@end
