//
//  OWFieldText.m
//  OWForms
//
//  Created by Rodrigo Recio on 3/6/13.
//
//

#import "OWFieldText.h"

@implementation OWFieldText

- (id)initWithLabel:(NSString *)aLabel andValue:(NSObject *)aValue
{
    self = [super initWithLabel:aLabel andValue:aValue];
    
    return self;
}

- (UIViewController *)actionController {
    return nil;
}

- (OWTableViewCell *)customizedCell:(OWTableViewCell *)cell {
    cell = [super customizedCell:cell];
    cell.detailTextLabel.text = self.value;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
