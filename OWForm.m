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

@implementation OWForm

@synthesize formFields, sections;

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
		case OWFieldStyleImage:
			cell.imageView.image = field.value;
			break;
		case OWFieldStyleSwitch:
			[cell showSwitch:YES];
			cell.switchView.on = [field.value boolValue];
			break;
		default:
		{
			cell.detailTextLabel.text = [field.value stringValue];
			break;
		}
    }																																																										  
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    OWField *field = [[section fields] objectAtIndex:indexPath.row];
	
	//UIViewController *detailViewController = nil;
	switch (field.style) {
		case OWFieldStyleString:
			//detailViewController = [[OWStringEditingController alloc] init];
			break;
		case OWFieldStyleDate:
			//detailViewController = [[OWDateSelectionController alloc] init];
			break;
		case OWFieldStyleImage:
			//detailViewController = [[OWImageSelectionController alloc] init];
		default:
			//detailViewController = [[OWNumberEditingController alloc] init];
			break;
	}
	//[self.navigationController pushViewController:detailViewController animated:YES];
	NSLog(@"Should call controller for field style %d", field.style);
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

