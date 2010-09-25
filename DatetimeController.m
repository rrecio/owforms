//
//  EditDataHoraViewController.m
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "DatetimeController.h"

@implementation DatetimeController

@synthesize objetoAtual;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
	[imageView setImage:[UIImage imageNamed:@"kal_grid_shadow.png"]];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:imageView];	
	[imageView release];
	
	// Delegate
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	// Title
	self.navigationItem.title = NSLocalizedString(@"Data e Hora", @"");
	
	// Done Button
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	// Hides Back Button
	self.navigationItem.hidesBackButton = YES;
	
	// Google Analytics
	//[appDelegate gaTrackPageview:@"EditConsultaViewController"];
	
	return self;
}

#pragma mark IBAction's

- (IBAction)dateAction:(id)sender {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [appDelegate.dateTimeFormatter stringFromDate:datePicker.date];
	[objetoAtual setDataHora:[appDelegate.dateTimeFormatter dateFromString:cell.detailTextLabel.text]];
}

- (void)doneAction {
	[self.navigationController popViewControllerAnimated:YES];
}

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
	cell.textLabel.text = NSLocalizedString(@"Data e Hora", @"");
	cell.detailTextLabel.text = [appDelegate.dateTimeFormatter stringFromDate:[objetoAtual dataHora]];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Selecione a data e hora", @"");
}

#pragma mark UIView methods

- (void)viewDidAppear:(BOOL)animated {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
	datePicker.date = [appDelegate.dateTimeFormatter dateFromString:targetCell.detailTextLabel.text];
	
	// check if our date picker is already on screen
	if (datePicker.superview == nil) {
		[self.view addSubview: datePicker];
		
		// size up the picker view to our screen and compute the start/end frame origin for our slide up animation
		//
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
									   pickerSize.width,
									   pickerSize.height);
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

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// Personalization
	self.view.backgroundColor = [appDelegate backgroundParaBebe];
	tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

@end
