//
//  OWField.h
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	OWFieldStyleString,
	OWFieldStyleNumber,
	OWFieldStyleDate,
	OWFieldStyleDateTime,
	OWFieldStyleImage,
	OWFieldStyleToggle,			// implementar
	OWFieldStyleNotes,			// implementar
	OWFieldStylePicker			// implementar
} OWFieldStyle;

@interface OWField : NSObject {
}

@property(nonatomic) OWFieldStyle style;
@property(nonatomic, retain) NSString *label;
@property(nonatomic, retain) id value;
@property(nonatomic) UITableViewCellAccessoryType accessoryType;
@property(nonatomic, retain) UIView *accessoryView;

- (id)initWithStyle:(OWFieldStyle)aStyle label:(NSString *)aLabel value:(id)aValue;

@end
