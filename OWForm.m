//
//  OWForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWForm.h"
#import "OWTableViewCell.h"
#import "DateController.h"
#import "DatetimeController.h"
#import "StringController.h"
#import "NumberController.h"
#import "ImageController.h"
#import "ListController.h"
#import "NotesController.h"


static NSMutableDictionary *_imageCache;

@implementation OWForm

@synthesize formFields;
@synthesize sections;
@synthesize delegate;
@synthesize showSaveButton;
@synthesize showCancelButton;
@synthesize saveButtonTitle;
@synthesize cancelButtonTitle;

+ (NSMutableDictionary *)imageCache {
	if (_imageCache == nil) _imageCache = [[NSMutableDictionary alloc] init];
	return _imageCache;
}

#pragma mark -
#pragma mark Initialization

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Initialization

- (id)initWithFields:(NSArray *)fieldsArray {
	return [self initWithStyle:UITableViewStylePlain andFields:fieldsArray];
}
			
- (id)initWithStyle:(UITableViewStyle)style andFields:(NSArray *)fieldsArray {
	self = [self initWithStyle:style];					
	if (self != nil) {
		self.sections = [[NSMutableArray alloc] init];
		[self.sections addObject:[OWSection sectionWithArrayOfFields:fieldsArray]];
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
	// Get field object
	OWSection *section = (OWSection *)[self.sections objectAtIndex:indexPath.section];
	OWField *field = (OWField *)[section.fields objectAtIndex:indexPath.row];	
	
    NSString *CellIdentifier;
    
    if (field.style == OWFieldStyleNotes)
        CellIdentifier = @"Notes";
    else if (field.style == OWFieldStyleSwitch)
        CellIdentifier = @"CellSwitch";
    else
        CellIdentifier = @"Cell";

    OWTableViewCell *cell = (OWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
		if ([field isKindOfClass:[OWFieldNotes class]])
        {
			cell = [[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.textLabel.numberOfLines = 1000;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
		}
        else
        {
			cell = [[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
		}
    }
		
    // Configure the cell...

    return [field customizedCell:cell];
}

#pragma mark Helper methods

- (CGFloat)specialRowHeightForString:(NSString *)aString {
	CGSize maximumLabelSize = CGSizeMake(270, 1000);
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:16];
	CGSize size = [aString sizeWithFont:font
				   constrainedToSize:maximumLabelSize
					   lineBreakMode:UILineBreakModeWordWrap];
	return size.height;
}

#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat altura;
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
	
    if (currentField.style == OWFieldStyleNotes) {
		altura = [self specialRowHeightForString:(NSString *)currentField.value] + 20;
    } else {
        altura = 44;
    }
	
	if (altura < 44) {
		altura = 44;
	}
	
	return altura;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[currentField actionController] animated:YES];
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
	[_imageCache release];
    [super dealloc];
}

@end
