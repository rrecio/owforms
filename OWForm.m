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
@synthesize cellsBackgroundView;
@synthesize tableViewStyle;

- (void)addDataFromDictionary:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];

    for (NSString *aLabel in keys)
    {
        OWField *field = [self fieldForLabel:aLabel];
        field.value = [dict objectForKey:aLabel];
    }
}

- (NSDictionary *)fieldsDictionary {
    NSMutableDictionary *fieldsDict = [NSMutableDictionary dictionary];
    for (OWSection *aSection in self.sections)
        for (OWField *aField in aSection.fields)
            if (aField.value != nil)
                [fieldsDict setObject:aField.value forKey:aField.label];
    return fieldsDict;
}

+ (NSArray *)keys {
    NSMutableArray *arr = [[NSArray array] mutableCopy];
    OWForm *form = [[self alloc] init];
    
    for (OWSection *aSection in form.sections)
        for (OWField *aField in aSection.fields)
            [arr addObject:[aField label]];
    
    [form release];
    return arr;
}

+ (NSMutableDictionary *)imageCache {
	if (_imageCache == nil) _imageCache = [[NSMutableDictionary alloc] init];
	return _imageCache;
}

#pragma mark - 
#pragma mark Fields and Sections management

- (void)addSection:(OWSection *)section {
    OWSection *lastSection = [self.sections lastObject];
    [self addSection:section atIndexPath:[NSIndexPath indexPathForRow:[lastSection.fields count] inSection:[self.sections count]-1]];
}

- (void)addSection:(OWSection *)section 
       atIndexPath:(NSIndexPath *)indexPath 
{
    if (self.sections == nil) {
        self.sections = [[NSMutableArray alloc] init];
        [self.sections addObject:section];
    } else {
        [self.sections addObject:section];
    }
    [self.tableView insertSections:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];    
}

- (void)addField:(OWField *)aField {
    OWSection *lastSection = [self.sections lastObject];
    [self addField:aField atIndexPath:[NSIndexPath indexPathForRow:[lastSection.fields count] inSection:[self.sections count]-1]];
}

- (void)addField:(OWField *)aField 
     atIndexPath:(NSIndexPath *)indexPath 
{
    if (self.sections == nil) {
        self.sections = [[NSMutableArray alloc] init];
        [self.sections addObject:[OWSection sectionWithField:aField]];
    } else {
        if (indexPath.section < [self.sections count]) {
            OWSection *section = [self.sections objectAtIndex:indexPath.section];
            [section.fields addObject:aField];
        } else {
            [self.sections addObject:[OWSection sectionWithField:aField]];
        }
    }
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)removeFieldAtIndexPath:(NSIndexPath *)indexPath {
    OWSection *section = [self.sections objectAtIndex:indexPath.section];
    if ([section.fields count] != 0) {
        [section.fields removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (OWField *)fieldForLabel:(NSString *)aLabel {
    for (OWSection *section in self.sections) {
        for (OWField *field in section.fields) {
            if ([field.label isEqualToString:aLabel]) return field;
        }
    }
    return nil;
}

- (OWField *)fieldAtIndexPath:(NSIndexPath *)indexPath {
    OWField *field = nil;
    if ([self.sections count] > indexPath.section) {
        OWSection *section = [self.sections objectAtIndex:indexPath.section];
        if ([section.fields count] > indexPath.row) {
            field = [section.fields objectAtIndex:indexPath.row];
        }
    }
    return field;
}

#pragma mark -
#pragma mark View actions

- (void)doSaveAction {
	[delegate saveAction:self];
}

- (void)doCancelAction {
	[delegate cancelAction];
}

#pragma mark -
#pragma mark Initializers

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
#pragma mark UIView lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	    
	if (showSaveButton) {
		if (!saveButtonTitle) saveButtonTitle = @"Salvar";
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:saveButtonTitle
																	   style:UIBarButtonItemStyleDone
																	  target:self
																	  action:@selector(doSaveAction)];
		self.navigationItem.rightBarButtonItem = saveButton;
		[saveButton release];
	}

	if (showCancelButton) {
		if (!cancelButtonTitle) cancelButtonTitle = @"Cancelar";
		UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:cancelButtonTitle
																	   style:UIBarButtonItemStyleBordered
																	  target:self
																	  action:@selector(doCancelAction)];
		self.navigationItem.leftBarButtonItem = cancelButton;
		[cancelButton release];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        OWSection *section = [self.sections objectAtIndex:indexPath.section];
        currentField = [[section fields] objectAtIndex:indexPath.row];
        currentField.value = nil;
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Apagar informação";
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
	
    OWTableViewCell *cell = (OWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:field.cellIdentifier];

    // Instantiate cell if needed, depending on the field type
    if (cell == nil) cell = [field cellInstance];
    
    // Set up the cell's backgroundView
    if (field.backgroundView) {
        cell.backgroundView = field.backgroundView;
    } else {
        if (self.cellsBackgroundView) {
            cell.backgroundView = self.cellsBackgroundView;
        }
    }

    return [field customizedCell:cell];
}

#pragma mark -
#pragma mark Helper methods


#pragma mark -
#pragma mark Table view delegate

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
    return currentField.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
    UIViewController *controller = [currentField actionController];
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
    }
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

- (void)dealloc {
	[_imageCache release];
    [super dealloc];
}

@end
