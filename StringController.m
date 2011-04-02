//
//  StringController.m
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import "StringController.h"
#import "OWField.h"

@implementation StringController

@synthesize field;
@synthesize textField;
@synthesize tableViewCell;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = field.label;
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
}

- (void)doneAction:(id)sender {
    NSLog(@"doneAction");
	field.value = textField.text;
	[self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellId = @"celulaPersonalizada";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellId];
	
	if (nil == cell)
		cell = tableViewCell;
	
	return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    field.value = textField.text;
    NSLog(@"viewWillDisappear");
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[textField setText:(NSString *)field.value];
	textField.placeholder = NSLocalizedString(@"Digite aqui", nil);
	
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[textField becomeFirstResponder];
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
