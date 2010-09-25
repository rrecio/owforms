//
//  EditStringViewController.m
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "StringController.h"

@implementation StringController

@synthesize texto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	// Shadow
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
	[imageView setImage:[UIImage imageNamed:@"kal_grid_shadow.png"]];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:imageView];
	[imageView release];
	
	// Delegate
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	[[self navigationItem] setTitle:NSLocalizedString(@"Editando", @"")];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
	
	return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	[textField resignFirstResponder];
	[texto setString:textField.text];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)doneAction:(id)sender {
	[texto setString:textField.text];
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[textField setText:(NSString *)[self texto]];
	textField.placeholder = NSLocalizedString(@"Digite aqui", nil);
	
	// Personalization
	self.view.backgroundColor = [appDelegate backgroundParaBebe];
	tableView.backgroundColor = [UIColor clearColor];

	[tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
