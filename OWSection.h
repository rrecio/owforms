//
//  OWSection.h
//  OWForms
//
//  Created by Rodrigo Recio on 24/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OWField;

@interface OWSection : NSObject {

}

@property(nonatomic, retain) NSMutableArray *fields;
@property(nonatomic, retain) NSString *headerTitle;
@property(nonatomic, retain) NSString *footerTitle;
@property(nonatomic, retain) NSString *summary;

+ (id)sectionWithField:(id)aField;
+ (id)sectionWithFields:(id)firstField, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)sectionWithArrayOfFields:(NSArray *)fieldsArray;
- (id)initWithFields:(OWField *)field vaList:(va_list)params;

@end
