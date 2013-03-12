//
//  OWFieldText.m
//  OWForms
//
//  Created by Rodrigo Recio on 3/6/13.
//
//

#import "OWFieldText.h"
#import "OWTextField.h"

@implementation OWFieldText

@synthesize textField = _textField;

- (id)initWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue
{
    self = [super initWithLabel:aLabel andValue:aValue];
    self.textField = [[OWTextField alloc] initWithFrame:CGRectZero];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;

    return self;
}

- (UIViewController *)actionController {
    return nil;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    cell.textLabel.text = nil;
    self.textField.text = self.value;
    [self.textField setPlaceholder:self.label];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.textField.background != nil) {
        self.textField.borderStyle = UITextBorderStyleNone;
    }
    return cell;
}

- (OWTableViewCell *)cellInstance
{
    OWTableViewCell *cell = [super cellInstance];
    if (CGRectIsEmpty(self.textField.frame)) {
        self.textField.frame = CGRectMake(cell.frame.size.height * 0.1, cell.frame.size.height * 0.1, cell.frame.size.width-((cell.frame.size.height * 0.1) * 2), cell.frame.size.height * 0.8);
    }
    [cell.contentView addSubview:_textField];
    return cell;
}

@end
