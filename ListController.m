//
//  ListController.m
//  OWForms
//
//  Created by Madson on 23/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListController.h"
#import "OWField.h"

@implementation ListController


#pragma mark -
#pragma mark Initialization

- (id)initWithField:(OWField *)field {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
		currentField = [field retain];
		list = currentField.list;
		selectedIndex = [(NSNumber *)currentField.value intValue];
    }
    return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = currentField.label;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
	
	if (indexPath.row == selectedIndex)
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	selectedIndex = indexPath.row;
	currentField.value = [NSNumber numberWithInt:selectedIndex];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
	[currentField release];
    [super dealloc];
}


@end

