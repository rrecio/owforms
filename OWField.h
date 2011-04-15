//
//  OWField.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWTableViewCell.h"

@interface OWField : NSObject {
}

@property(nonatomic, retain)    NSString *label;
@property(nonatomic, retain)    id value;
@property(nonatomic)            UITableViewCellAccessoryType accessoryType;
@property(nonatomic, retain)    UIView *accessoryView;
@property(nonatomic, retain)    NSDate *startDate;
@property(nonatomic, retain)    NSDate *endDate;
@property(nonatomic, retain)    NSArray *list;
@property(nonatomic)            BOOL required;

+ (id)fieldWithLabel:(NSString *)aLabel;
+ (id)fieldWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue;
- (id)initWithLabel:(NSString *)aLabel andValue:(NSObject *)numberValue;
- (UIViewController *)actionController;
- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell;
- (BOOL)isEmpty;

@end
