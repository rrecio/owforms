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
        form = [[OWForm alloc] initWithStyle:UITableViewStyleGrouped];
        form.title = @"Form Title :)";
		form.delegate = self;
		[form setShowSaveButton:YES];
		[form setShowCancelButton:YES];

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
		        
        [form addField:field1];
        [form addField:field2];
        [form addField:field3];
        [form addField:field4];
        [form addField:field5];
        [form addField:field6];
        [form addField:field7];
        [form addField:field8];
        
        OWSection *section1 = [form.sections lastObject];
		section1.headerTitle = @"Ki legau!!!";
		section1.summary = @"Isto é um sumario";
		section1.footerTitle = @"Isto eh um rodape";
        
        [field1 release];
        [field2 release];
        [field3 release];
        [field4 release];
        [field5 release];
        [field6 release];
        [field7 release];
        [field8 release];
    }
	
	[self.navigationController pushViewController:form animated:YES];
}

#pragma mark -
#pragma mark OWForm delegates

- (void)saveAction:(OWForm *)f {	
	NSString *texto = @"";
	
	for (OWSection *s in f.sections)
		for (OWField *f in s.fields) {
            texto = [texto stringByAppendingFormat:@"%@ \n", [f.value description]];
		}
	[textView setText:texto];
	[self.navigationController popViewControllerAnimated:YES];
}

- (OWForm *)form2 {
    OWFieldText *field1 = [[[OWFieldText alloc] initWithLabel:@"Nome" andValue:@"Nada"] autorelease];
	[field1 setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    OWFieldText *field2 = [[[OWFieldText alloc] initWithLabel:@"Sobrenome" andValue:@"Dinovo"] autorelease];
	[field2 setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	OWSection *section1 = [[[OWSection alloc] init] autorelease];
	section1.fields = [NSArray arrayWithObjects:field1, field2, nil];
	
	OWForm *form2 = [[[OWForm alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
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
