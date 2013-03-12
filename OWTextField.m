//
//  OWTextField.m
//  OWForms
//
//  Created by Rodrigo Recio on 3/12/13.
//
//

#import "OWTextField.h"

@implementation OWTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 10 );
}

@end
