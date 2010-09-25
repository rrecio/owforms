//
//  DateController.h
//  OWForms
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateController : UIViewController <UITableViewDataSource> {
	BabyNotesAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UIDatePicker *datePicker;
	id objetoAtual;
	NSDate *maximumDate;
}

@property (nonatomic, retain) id objetoAtual;
@property (nonatomic, retain) NSDate *maximumDate;

- (IBAction)dateAction:(id)sender;
- (void)salvar;

@end
