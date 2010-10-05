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
#import "DateController.h"
#import "DatetimeController.h"
#import "StringController.h"
#import "NumberController.h"
#import "AppDelegate_iPhone.h"

@implementation OWForm

@synthesize formFields, sections;

#pragma mark -
#pragma mark Initialization

- (void)viewDidLoad {
	[super viewDidLoad];
	appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWSection *section = [self.sections objectAtIndex:indexPath.section];
    currentField = [[section fields] objectAtIndex:indexPath.row];
	
	//UIViewController *detailViewController = nil;
	switch (currentField.style) {
		case OWFieldStyleNumber: {
			NumberController *detailViewController = [[NumberController alloc] initWithDecimalPlaces:2];
			detailViewController.field = currentField;
			[self.navigationController pushViewController:detailViewController animated:YES];
			break;
		}
		case OWFieldStyleString: {
			StringController *detailViewController = [[StringController alloc] initWithNibName:@"StringController" bundle:nil];
			detailViewController.field = currentField;
			[self.navigationController pushViewController:detailViewController animated:YES];
			break;
		}
		case OWFieldStyleDate: {
			DateController *detailViewController = [[DateController alloc] init];
			detailViewController.field = currentField;
			[self.navigationController pushViewController:detailViewController animated:YES];
			break;
		}
		case OWFieldStyleDateTime: {
			DatetimeController *detailViewController = [[DatetimeController alloc] init];
			detailViewController.field = currentField;
			[self.navigationController pushViewController:detailViewController animated:YES];
			break;
		}
		case OWFieldStyleImage: {
			
			if (!imagePickerController) {
				imagePickerController = [[UIImagePickerController alloc] init];
				[imagePickerController setAllowsEditing:YES];
				//[imagePickerController setAllowsImageEditing:YES];
				[imagePickerController setDelegate:self];		
			}
			
			[self owFieldStyleImageTapped];
			
			break;
		}
		default:
			//detailViewController = [[OWNumberEditingController alloc] init];
			break;
	}
	//[self.navigationController pushViewController:detailViewController animated:YES];
	NSLog(@"Should call controller for field style %d", currentField.style);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.sections objectAtIndex:section] headerTitle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [[self.sections objectAtIndex:section] footerTitle];
}

#pragma mark -
#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// Gera ID
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	currentField.value = (NSString *)newUniqueIDString;
	
	// Libera o ID gerado
	CFRelease(newUniqueID);
	CFRelease(newUniqueIDString);
	
	// Pega a imagem
	UIImage *thumbnail = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	
	// Adiciona a imagem ao cache
	[appDelegate.imageCache setObject:thumbnail forKey:currentField.value];
	//[headerController setUpPhotoButton];	
	
	// Salva a imagem do bebe
	NSString *thumbnailPath = pathInDocumentDirectory(currentField.value);
	[UIImageJPEGRepresentation(thumbnail, 1.0) writeToFile:thumbnailPath atomically:YES];
	
	// Fecha a view do ImagePicker
	[self dismissModalViewControllerAnimated:YES];	
}

#pragma mark -
#pragma mark UIActionSheet delegate

- (void)owFieldStyleImageTapped {
	NSString *lastOption;
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		lastOption = @"Da câmera";
	else
		lastOption = nil;
	
	if (currentField.value == nil) {
		if (!sheetImage)
		sheetImage = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
												 delegate:self
										cancelButtonTitle:@"Cancelar"
								   destructiveButtonTitle:nil
										otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[sheetImage showInView:self.view];
	} else {
		if (!sheetImageDelete)
		sheetImageDelete = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
													   delegate:self
											  cancelButtonTitle:@"Cancelar"
										 destructiveButtonTitle:@"Remover imagem"
											  otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[sheetImageDelete showInView:self.view];		
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (sheetImage == actionSheet) {
		switch (buttonIndex) {
			case 0:
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			case 1:
			{
				if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
				{
					[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
					[self presentModalViewController:imagePickerController animated:YES];
					break;
				}
			}
			default:
				break;
		}
	} else {
		switch (buttonIndex) {
			case 0:
				currentField.value = nil;
				break;
			case 1:
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			case 2:
			{
				if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
				{
					[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
					[self presentModalViewController:imagePickerController animated:YES];
					break;
				}
			}
			default:
				break;
		}
	}
	
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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

