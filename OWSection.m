//
//  OWSection.m
//  OWForms
//
//  Created by Rodrigo Recio on 24/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWSection.h"
#import "OWField.h"

@implementation OWSection

@synthesize title, summary, fields;

+ (id)sectionWithField:(id)aField {
	return self;
}


+ (id)sectionWithFields:(id)firstField, ... {
	va_list args;
	va_start(args, firstField);
	
	id s = [[[self alloc] initWithFields:firstField vaList:args] autorelease];
	
	va_end(args);
	return s;
}

- (id)initWithFields:(OWField *)field vaList:(va_list)params
{
	if (self = [super init]) {
		fields = [[NSMutableArray alloc] init];
		[fields addObject:field];

		OWField *f = va_arg(params, OWField *);
		while( f ) {
			[fields addObject:f];
			f = va_arg(params, OWField *);
		}
	}
	return self;
}

@end
