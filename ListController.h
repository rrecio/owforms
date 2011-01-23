//
//  ListController.h
//  OWForms
//
//  Created by Madson on 23/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface ListController : UITableViewController {
	OWField *currentField;
	NSArray *list;
	int selectedIndex;
}

- (id)initWithField:(OWField *)field;

@end
