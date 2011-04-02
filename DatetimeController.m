//
//  DatetimeController.h
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import "DatetimeController.h"
#import "OWField.h"

@implementation DatetimeController

@synthesize field;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	tableView = [[UITableView alloc] initWithFrame:[self.view bounds] style:UITableViewStyleGrouped];
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	
	datePicker = [[UIDatePicker alloc] init];
	datePicker.datePickerMode = UIDatePickerModeDateAndTime;
	[datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

	if ([field endDate] != nil)
		datePicker.maximumDate = [field endDate];
	
	if ([field startDate] != nil)
		datePicker.minimumDate = [field startDate];
	
	
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	// Save Button
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
		
	return self;
}

- (void)valueChanged:(id)sender {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = [dateFormatter stringFromDate:datePicker.date];
	field.value = datePicker.date;
}

- (void)doneAction:(id)sender {
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
	cell.textLabel.text = NSLocalizedString(@"Data", @"");
	cell.detailTextLabel.text = [dateFormatter stringFromDate:field.value];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)section {
	return NSLocalizedString(@"Selecione a data", @"");
}

#pragma mark UIView methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Title
	self.navigationItem.title = field.label;
}

- (void)viewDidAppear:(BOOL)animated {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
	datePicker.date = [dateFormatter dateFromString:targetCell.detailTextLabel.text];
	
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[datePicker release];
	[dateFormatter release];
    [super dealloc];
}

@end
