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
	
    NSString *CellIdentifier = (field.style == OWFieldStyleNotes) ? @"Notes" : @"Cell";

    OWTableViewCell *cell = (OWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
		if (field.style == OWFieldStyleNotes) {
			cell = [[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.textLabel.numberOfLines = 1000;
			cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
		} else {
			cell = [[OWTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
		}
    }
		
    // Configure the cell...
	cell.textLabel.text = field.label;

	if (field.selectable) {
		cell.accessoryType = (field.accessoryType) ? field.accessoryType : UITableViewCellAccessoryNone;
		cell.accessoryView = field.accessoryView;
	} else {
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
    switch (field.style) {
		case OWFieldStyleString:
			NSLog(@"name cell identifier: %@, setting detail to: %@", CellIdentifier, field.value);
			cell.detailTextLabel.text = field.value;
			break;
		case OWFieldStyleNotes:
			if (field.value == nil || [field.value isEqualToString:@""]) {
				cell.textLabel.textColor = [UIColor grayColor];
				cell.textLabel.text = NSLocalizedString(@"Description", @"");
			} else {
				cell.textLabel.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
				cell.textLabel.text = field.value;
			}
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
            switchView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

			[cell setSwitchView:switchView];
			[cell addSubview:switchView];
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			[[cell switchView] addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
			break;
		}
		case OWFieldStyleForm: {
			cell.textLabel.text = field.label;
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
	if (!currentField.selectable) return;
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
		case OWFieldStyleNotes: {
			NotesController *notesController = [[NotesController alloc] initWithNibName:@"NotesController" bundle:nil];
			notesController.field = currentField;
			[self.navigationController pushViewController:notesController animated:YES];
			[notesController release];
			break;
		}
		case OWFieldStyleDate: {
            /*
			DateController *detailView = [[DateController alloc] init];
			detailView.field = currentField;
			[self.navigationController pushViewController:detailView animated:YES];
             */
            CGRect pickerFrame = CGRectMake(0, 0, 300, 180);
            UIViewController *tempDateViewController = [[UIViewController alloc] init];
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
            [datePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
            [tempDateViewController.view addSubview:datePicker];
            tempDateViewController.contentSizeForViewInPopover = CGSizeMake(300, 180);

            if(!currentPopover)
            {
                currentPopover = [[UIPopoverController alloc] initWithContentViewController:tempDateViewController];
            } else {
                [currentPopover setContentViewController:tempDateViewController animated:YES];
            }
            
            [datePicker release];
            [tempDateViewController release];
            CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
            [currentPopover presentPopoverFromRect:cellRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown|UIPopoverArrowDirectionUp animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	[_imageCache release];
    [super dealloc];
}

@end
