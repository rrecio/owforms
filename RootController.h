//
//  RootController.h
//  OWForms
//
//  Created by Madson on 13/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWForm.h"

@interface RootController : UIViewController <OWFormDataSourceDelegate> {
	UITextView *textView;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)chamaForm1:(id)sender;
- (OWForm *)form2;

@end
