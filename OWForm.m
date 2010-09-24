//
//  OWForm.m
//  OWForms
//
//  Created by Rodrigo Recio on 23/09/10.
//  Copyright 2010 Owera Studio. All rights reserved.
//

#import "OWForm.h"
#import "OWField.h"

@interface OWForm (PrivateMethods)

- (NSString *)classStringForFieldAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation OWForm

@synthesize fields;

#pragma mark -
#pragma mark Initialization

- (id)initWithFields:(NSArray *)fieldsArray {
	self = [self initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.fields = fieldsArray;
	}
	return self;
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.fields count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.fields objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Get field object
	NSArray *section = [self.fields objectAtIndex:indexPath.section];
	OWField *field = [section objectAtIndex:indexPath.row];
	
    //static NSString *CellIdentifier = @"Cell";
	NSString *CellIdentifier = (field.style == OWFieldStyleImage) ? @"OWImageCell" : @"OWTextCell" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		//cell = (field.type == OWFieldStyleImage) ? [[OWImageCell alloc] init] : [[UITableViewCell alloc] 
		//																		initWithStyle:UITableViewCellStyleValue1 
		//																		reuseIdentifier:CellIdentifier];
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	
    // Configure the cell...
	cell.textLabel.text = field.label;
	cell.detailTextLabel.text = field.value;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	OWField *field = [[self.fields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	//UIViewController *detailViewController = nil;
	switch (field.style) {
		case OWFieldStyleString:
			//detailViewController = [[OWStringEditingController alloc] init];
			break;
		case OWFieldStyleNumber:
			//detailViewController = [[OWNumberEditingController alloc] init];
			break;
		case OWFieldStyleDecimal:
			//detailViewController = [[OWNumberEditingController alloc] init];
			break;
		case OWFieldStyleDate:
			//detailViewController = [[OWDateSelectionController alloc] init];
			break;
		case OWFieldStyleImage:
			//detailViewController = [[OWImageSelectionController alloc] init];
		default:
			break;
	}
	//[self.navigationController pushViewController:detailViewController animated:YES];
	NSLog(@"Should call controller for field %@", field);
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

