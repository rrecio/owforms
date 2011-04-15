//
//  StringController.h
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWFieldText;

@interface StringController : UITableViewController {
	UITableViewCell *tableViewCell;
	UITextField *textField;
	OWFieldText *field;
}

@property (nonatomic, retain) OWFieldText *field;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UITableViewCell *tableViewCell;

- (void)doneAction:(id)sender;

@end
