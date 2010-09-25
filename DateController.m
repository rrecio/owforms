//
//  DateController.h
//  OWForms
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "DateController.h"

@implementation DateController

@synthesize objetoAtual;
@synthesize maximumDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	// Delegate
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
	[imageView setImage:[UIImage imageNamed:@"kal_grid_shadow.png"]];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:imageView];	
	[imageView release];
	
	// Title
	self.navigationItem.title = NSLocalizedString(@"Data", @"");
	
	// Save Button
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(salvar)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
	
	//UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(slideDown)];
	//self.navigationItem.leftBarButtonItem = cancelButton;
	//[cancelButton release];
	
	return self;
}

#pragma mark IBAction's

- (IBAction)dateAction:(id)sender {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [appDelegate.dateFormatter stringFromDate:datePicker.date];
	[objetoAtual setDate:[appDelegate.dateFormatter dateFromString:cell.detailTextLabel.text]];
}

- (void)salvar {
	[self.navigationController popViewControllerAnimated:YES];
}

/*
- (void)doneAction {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	appDelegate.bebeAtual.dataNascimento = [formatter dateFromString:cell.detailTextLabel.text];
	[self slideDown];
}

- (void)slideDown {
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = datePicker.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	// start the slide down animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	
	// we need to perform some post operations after the animation is complete
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(slideDidDown)];
	
	datePicker.frame = endFrame;
	[UIView commitAnimations];
	
	// grow the table back again in vertical size to make room for the date picker
	//CGRect newFrame = tableView.frame;
	//newFrame.size.height += datePicker.frame.size.height;
	//tableView.frame = newFrame;
}

- (void)slideDidDown {
	[datePicker removeFromSuperview];	
	[self.navigationController popViewControllerAnimated:YES];	
}
 
*/

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"celulaDataHora";
	
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:cellId];

	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId] autorelease];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = NSLocalizedString(@"Data", @"");
	cell.detailTextLabel.text = [appDelegate.dateFormatter stringFromDate:[objetoAtual date]];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Selecione a data", @"");
}

#pragma mark UIView methods

- (void)viewDidAppear:(BOOL)animated {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
	datePicker.date = [appDelegate.dateFormatter dateFromString:targetCell.detailTextLabel.text];

	if (maximumDate != nil)
		datePicker.maximumDate = maximumDate;
	
	// check if our date picker is already on screen
	if (datePicker.superview == nil) {
		[self.view addSubview: datePicker];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		// compute the start frame
		CGRect screenRect = [self.view bounds];
		CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
		CGRect startRect = CGRectMake(0.0,
									  screenRect.origin.y + screenRect.size.height,
									  pickerSize.width, pickerSize.height);
		datePicker.frame = startRect;
		
		// compute the end frame
		CGRect pickerRect = CGRectMake(0.0,
									   screenRect.origin.y + screenRect.size.height - pickerSize.height,
									   pickerSize.width, pickerSize.height);
		// start the slide up animation
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		
		// we need to perform some post operations after the animation is complete
		[UIView setAnimationDelegate:self];
		
		datePicker.frame = pickerRect;
		
		// shrink the table vertical size to make room for the date picker
		//CGRect newFrame = tableView.frame;
		//newFrame.size.height -= datePicker.frame.size.height;
		//tableView.frame = newFrame;
		[UIView commitAnimations];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Personalization
	self.navigationController.navigationBar.tintColor = [appDelegate corParaBebe];
	[tableView setBackgroundColor:[appDelegate backgroundParaBebe]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[datePicker release];
}

- (void)dealloc {
    [super dealloc];
}

@end
