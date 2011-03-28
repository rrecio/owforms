//
//  NotesViewController.m
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "NotesController.h"
#import "OWField.h"

@implementation NotesController

@synthesize texto, field;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
		
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
	[imageView setImage:[UIImage imageNamed:@"kal_grid_shadow.png"]];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:imageView];	
	[imageView release];
	
	// Title
	self.navigationItem.title = NSLocalizedString(@"Notas", @"");
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", @"")
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
	
	return self;
}

- (void)doneAction:(id)sender {
	[self.field setValue:textView.text];
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableView methods

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 180;
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
	[textView setText:(NSString *)[self.field value]];
	[tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[textView becomeFirstResponder];
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
