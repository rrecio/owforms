//
//  RootController.m
//  OWForms
//
//  Created by Madson on 13/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootController.h"
#import "OWField.h"
#import "OWSection.h"

@implementation RootController

@synthesize textView;

- (IBAction)chamaForm1:(id)sender {
	OWField *field1 = [[OWField alloc] initWithStyle:OWFieldStyleString label:@"Hello" value:@"World!"];
	field1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	//field1.acessoryView = aView;
	
	OWField *field2 = [[OWField alloc] initWithStyle:OWFieldStyleNumber label:@"Number" value:[NSNumber numberWithInt:235.12]];
	field2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	OWField *field3 = [[OWField alloc] initWithStyle:OWFieldStyleDate label:@"Date" value:[NSDate date]];
	field3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	OWField *field4 = [[OWField alloc] initWithStyle:OWFieldStyleDateTime label:@"DateTime" value:[NSDate date]];
	field4.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	OWField *field5 = [[OWField alloc] initWithStyle:OWFieldStyleImage label:@"Image" value:nil];
	field5.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	OWSection *section1 = [OWSection sectionWithFields:field1, field2, nil];
    section1.headerTitle = @"Ki legau!!!";
	section1.summary = @"Isto é um sumario";
	section1.footerTitle = @"Isto eh um rodape";
    OWSection *section2 = [OWSection sectionWithFields:field3, field4, nil];
    section2.headerTitle = @"DIMAIXXX!";
    OWSection *section3 = [OWSection sectionWithFields:field5, nil];
    section3.headerTitle = @"Madson";
	
    OWForm *form = [[OWForm alloc] initWithStyle:UITableViewStyleGrouped andSections:section1, section2, section3, nil];
	form.title = @"Form Title :)";
	form.delegate = self;
	[form setShowSaveButton:YES];
	[form setShowCancelButton:YES];
	
	[self.navigationController pushViewController:form animated:YES];
}

#pragma mark -
#pragma mark OWForm delegates

- (void)saveAction:(OWForm *)form {
	NSString *texto = [[NSString alloc] init];
	
	NSLog(@"Save action!");
	for (OWSection *s in form.sections)
		for (OWField *f in s.fields) {
			switch (f.style) {
				case OWFieldStyleNumber: {
					texto = [texto stringByAppendingFormat:@"\n%@", [(NSNumber *)f.value stringValue]];
					break;
				}
				case OWFieldStyleDate: {
					NSDateFormatter *df = [[NSDateFormatter alloc] init];
					[df setDateStyle:NSDateFormatterShortStyle];
					[df setTimeStyle:NSDateFormatterNoStyle];
					texto = [texto stringByAppendingFormat:@"\n%@", [df stringFromDate:(NSDate *)f.value]];
					[df release];
					break;
				}
				case OWFieldStyleDateTime: {
					NSDateFormatter *df = [[NSDateFormatter alloc] init];
					[df setDateStyle:NSDateFormatterShortStyle];
					[df setTimeStyle:NSDateFormatterShortStyle];
					texto = [texto stringByAppendingFormat:@"\n%@", [df stringFromDate:(NSDate *)f.value]];
					[df release];
					break;
				}
				case OWFieldStyleString: {
					texto = [texto stringByAppendingFormat:@"\n%@", (NSString *)f.value];
					break;
				}
				case OWFieldStyleImage: {
					texto = [texto stringByAppendingFormat:@"\n%@", (NSString *)f.value];
					break;
				}
				default:
					break;
			}
		}
	[textView setText:texto];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelAction {
	NSLog(@"Cancel action!");
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
