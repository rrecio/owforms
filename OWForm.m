//
//  OWForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWForm.h"
#import "OWField.h"
#import "OWSection.h"
#import "OWTableViewCell.h"
#import "DateController.h"
#import "DatetimeController.h"
#import "StringController.h"
#import "NumberController.h"
#import "ImageController.h"
#import "ListController.h"
#import "AppDelegate_iPhone.h"

@interface OWSwitch : UISwitch {
	OWField *field;
}
@property (nonatomic, retain) OWField *field;
@end

@implementation OWSwitch : UISwitch
	@synthesize field;
@end



@implementation OWForm

@synthesize formFields;
@synthesize sections;
@synthesize delegate;
@synthesize showSaveButton;
@synthesize showCancelButton;
@synthesize saveButtonTitle;
@synthesize cancelButtonTitle;

#pragma mark -
#pragma mark Initialization
- (id)initWithFields:(NSArray *)fieldsArray {
	return [self initWithStyle:UITableViewStylePlain andFields:fieldsArray];
}
			
- (id)initWithStyle:(UITableViewStyle)style andFields:(NSArray *)fieldsArray {
	self = [self initWithStyle:style];					
	if (self != nil) {
		self.formFields = fieldsArray;
	}
	return self;
}

- (id)initWithSections:(OWSection *)firstSection, ... {
	va_list args;
	va_start(args, firstSection);
	
	self = [super initWithStyle:UITableViewStylePlain];
	
	sections = [[NSMutableArray alloc] init];
	[sections addObject:firstSection];
	
	OWSection *s = va_arg(args, OWSection *);
	while (s) {
		[sections addObject:s];
		s = va_arg(args, OWSection *);
	}
	
	va_end(args);
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style andSections:(OWSection *)firstSection, ... {
	va_list args;
	va_start(args, firstSection);
	
	self = [super initWithStyle:style];
	
	sections = [[NSMutableArray alloc] init];
	[sections addObject:firstSection];
	
	OWSection *s = va_arg(args, OWSection *);
	while (s) {
		[sections addObject:s];
		s = va_arg(args, OWSection *);
	}
	
	va_end(args);
	return self;
}

#pragma mark -
#pragma mark UIViewController lifecicle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (showSaveButton) {
		if (!saveButtonTitle) saveButtonTitle = @"Save";
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:saveButtonTitle
																	   style:UIBarButtonItemStyleDone
																	  target:self
																	  action:@selector(doSaveAction)];
		self.navigationItem.rightBarButtonItem = saveButton;
		[saveButton release];
	}

	if (showCancelButton) {
		if (!cancelButtonTitle) cancelButtonTitle = @"Cancel";
		UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancelButtonTitle
																	   style:UIBarButtonItemStyleBordered
																	  target:self
																	  action:@selector(doCancelAction)];
		self.navigationItem.leftBarButtonItem = cancelButton;
		[cancelButton release];
	}
	
}

- (void)doSaveAction {
	[delegate saveAction:self];
}
	
- (void)doCancelAction {
	[delegate cancelAction];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[self.sections objectAtIndex:section] fields] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";

    OWTableViewCell *cell = (OWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	
	// Get field object
	OWSection *section = (OWSection *)[self.sections objectAtIndex:indexPath.section];
	OWField *field = (OWField *)[section.fields objectAtIndex:indexPath.row];
	
    // Configure the cell...
	cell.textLabel.text = field.label;
	cell.accessoryType = field.accessoryType;
	cell.accessoryView = field.accessoryView;
	
	switch (field.style) {
		case OWFieldStyleString:
			cell.detailTextLabel.text = field.value;
			break;
		case OWFieldStyleNumber:
			cell.detailTextLabel.text = [(NSNumber *)field.value stringValue];
			break;
		case OWFieldStyleDate:
		{
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterShortStyle];
			[formatter setTimeStyle:NSDateFormatterNoStyle];
			cell.detailTextLabel.text = [formatter stringFromDate:field.value];
			[formatter release];
			break;
		}
		case OWFieldStyleDateTime:
		{
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateStyle:NSDateFormatterShortStyle];
			[formatter setTimeStyle:NSDateFormatterShortStyle];
			cell.detailTextLabel.text = [formatter stringFromDate:field.value];
			[formatter release];
			break;
		}                       
		case OWFieldStyleImage: {
			//cell.imageView.image = field.value;
			break;
		}
		case OWFieldStyleSwitch: {
			OWSwitch *switchView = nil;
			switchView = [[OWSwitch alloc] initWithFrame:CGRectMake(208, 8, 95, 8)];
			switchView.on = [field.value boolValue];
			switchView.field = field;

			[cell setSwitchView:switchView];
			[cell addSubview:switchView];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			[[cell switchView] addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
			break;
		}
		case OWFieldStyleForm: {
			OWForm *form = (OWForm *)field.value;
			cell.textLabel.text = form.title;
			break;
		}
		case OWFieldStyleList: {
			cell.textLabel.text = [field label];
			
			if ([field.value intValue] >= 0)
				cell.detailTextLabel.text = [field.list objectAtIndex:[field.value intValue]];
			else
				cell.detailTextLabel.text = @"Selecione";
			
			break;
		}
		default: {
			//cell.detailTextLabel.text = (NSString *)field.value;
		}
    }																																																										  
    
    return cell;
}

- (void)changeSwitch:(id)sender {
	OWSwitch *obj = (OWSwitch *)sender;
	if (obj.on)
		obj.field.value = [NSNumber numberWithBool:YES];
	else
		obj.field.value = [NSNumber numberWithBool:NO];
}

#pragma mark -
#pragma mark Table view delegate

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
	
	switch (currentField.style) {
		case OWFieldStyleNumber: {
			NumberController *detailView = [[NumberController alloc] initWithDecimalPlaces:2];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleString: {
			StringController *detailView = [[StringController alloc] initWithNibName:@"StringController" bundle:nil];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleDate: {
			DateController *detailView = [[DateController alloc] init];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleDateTime: {
			DatetimeController *detailView = [[DatetimeController alloc] init];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleImage: {
			ImageController *detailView = [[ImageController alloc] init];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleForm: {
			OWForm *detailView = (OWForm *)currentField.value;
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		case OWFieldStyleList: {
			ListController *detailView = [[ListController alloc] initWithField:currentField];
			[self.navigationController pushViewController:detailView animated:YES];
			break;
		}
		default:
			//detailViewController = [[OWNumberEditingController alloc] init];
			break;
	}
	//[self.navigationController pushViewController:detailViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.sections objectAtIndex:section] headerTitle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [[self.sections objectAtIndex:section] footerTitle];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
}

@end
