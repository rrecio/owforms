//
//  StringController.h
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface StringController : UITableViewController {
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextField *textField;
	OWField *field;
}

@property (nonatomic, retain) OWField *field;

- (void)doneAction:(id)sender;

@end
