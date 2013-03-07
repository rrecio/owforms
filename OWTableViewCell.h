//
//  OWTableViewCell.h
//  OWForms
//
//  Created by Rodrigo Recio on 27/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OWField;

@interface OWTableViewCell : UITableViewCell {
}

@property (nonatomic, retain) UISwitch *switchView;
@property (nonatomic, retain) UITextField *textField;

- (void)showSwitch:(BOOL)show;

@end
