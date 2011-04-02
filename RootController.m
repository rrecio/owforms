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
#import "OWFieldText.h"
#import "OWFieldNumber.h"
#import "OWFieldDate.h"
#import "OWFieldDateTime.h"
#import "OWFieldImage.h"
#import "OWFieldList.h"
#import "OWFieldForm.h"
#import "OWFieldSwitch.h"

@implementation RootController

@synthesize textView;

- (IBAction)chamaForm1:(id)sender {
	if (!form) {

        OWFieldText *field1 = [[OWFieldText alloc] initWithLabel:@"Hello" andValue:@"World!"];
		//field1.acessoryView = aView;
		
        OWFieldNumber *field2 = [[OWFieldNumber alloc] initWithLabel:@"Number" andValue:[NSNumber numberWithInt:234.0]];
		field2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        OWFieldDate *field3 = [[OWFieldDate alloc] initWithLabel:@"Date" andValue:[NSDate date]];
		field3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        OWFieldDateTime *field4 = [[OWFieldDateTime alloc] initWithLabel:@"DateTime" andValue:[NSDate date]];
		field4.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        OWFieldImage *field5 = [[OWFieldImage alloc] initWithLabel:@"Image" andValue:nil];
		field5.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        OWFieldForm *field6 = [[OWFieldForm alloc] initWithLabel:@"Form2" andValue:[self form2]];
		field6.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		OWFieldSwitch *field7 = [[OWFieldSwitch alloc] initWithLabel:@"É ou não?" andValue:[NSNumber numberWithBool:NO]];
		
        OWFieldList *field8 = [[OWFieldList alloc] initWithLabel:@"Unidade" andValue:[NSNumber numberWithInt:1]];
		field8.list = [NSArray arrayWithObjects:@"kg", @"lb", @"oz", nil];
		
		OWSection *section1 = [OWSection sectionWithFields:field1, field2, field6, field7, field8, nil];
		section1.headerTitle = @"Ki legau!!!";
		section1.summary = @"Isto é um sumario";
		section1.footerTitle = @"Isto eh um rodape";
		OWSection *section2 = [OWSection sectionWithFields:field3, field4, nil];
		section2.headerTitle = @"DIMAIXXX!";
		OWSection *section3 = [OWSection sectionWithFields:field5, nil];
		section3.headerTitle = @"Madson";
		
		form = [[OWForm alloc] initWithStyle:UITableViewStyleGrouped andSections:section1, section2, section3, nil];
		form.title = @"Form Title :)";
		form.delegate = self;
		[form setShowSaveButton:YES];
		[form setShowCancelButton:YES];
	}
	
	[self.navigationController pushViewController:form animated:YES];
}

#pragma mark -
#pragma mark OWForm delegates

- (void)saveAction:(OWForm *)f {	
	NSString *texto = [[NSString alloc] init];
	
	for (OWSection *s in f.sections)
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
				case OWFieldStyleSwitch: {
					texto = [texto stringByAppendingFormat:@"\nSwitch: %@", f.value];
					break;
				}
				default:
					break;
			}
		}
	[textView setText:texto];
	[self.navigationController popViewControllerAnimated:YES];
}

- (OWForm *)form2 {
    OWFieldText *field1 = [[OWFieldText alloc] initWithLabel:@"Nome" andValue:@"Nada"];
	[field1 setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    OWFieldText *field2 = [[OWFieldText alloc] initWithLabel:@"Sobrenome" andValue:@"Dinovo"];
	[field2 setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	OWSection *section1 = [[OWSection alloc] init];
	section1.fields = [NSArray arrayWithObjects:field1, field2, nil];
	
	OWForm *form2 = [[OWForm alloc] initWithStyle:UITableViewStyleGrouped];
	form2.title = @"Novo form";
	form2.sections = [NSArray arrayWithObjects:section1, nil];
	
	return form2;
}

- (void)cancelAction {
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
