//
//  EditDataHoraViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consulta.h"
#import "BabyNotesAppDelegate.h"

@interface DatetimeController : UIViewController <UITableViewDataSource> {
	BabyNotesAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UIDatePicker *datePicker;
	id objetoAtual;
}

@property (nonatomic, retain) id objetoAtual;

- (IBAction)dateAction:(id)sender;
- (void)doneAction;

@end
