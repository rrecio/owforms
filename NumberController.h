//
//  EditStringViewController.h
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface NumberController : UITableViewController {
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextField *textField;
	
	int decimalPlaces;
	
	OWField *field;
}

@property (nonatomic, retain) OWField *field;

- (id)initWithDecimalPlaces:(int)aDecimalPlaces;

- (IBAction)valueChanged:(id)sender;
- (void)doneAction:(id)sender;

@end
