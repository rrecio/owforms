//
//  DateController.h
//  OWForms
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "DateController.h"
#import "OWField.h"

@implementation DateController

@synthesize field;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
		
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
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
    [super viewDidAppear:animated];

	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
	datePicker.date = [dateFormatter dateFromString:targetCell.detailTextLabel.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelar)] autorelease];
    
    CGRect screenRect = CGRectMake(0, 0, 768, 1024);
    
	tableView = [[UITableView alloc] initWithFrame:screenRect style:UITableViewStyleGrouped];
	tableView.delegate = self;
	tableView.dataSource = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:tableView];
	
	datePicker = [[UIDatePicker alloc] init];
	datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	[datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (field.value == nil) {
        if (field.startDate) {
            field.value = field.startDate;
        }
        else {
            field.value = [NSDate date];
        }
    }

	if ([field startDate] != nil)
		datePicker.minimumDate = [field startDate];
	
	if ([field endDate] != nil)
		datePicker.maximumDate = [field endDate];
	
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    //CGRect screenRect = CGRectMake(0, 0, 768, 768);
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0, screenRect.size.height - pickerSize.height, screenRect.size.width, pickerSize.height);
    [self.view addSubview: datePicker];
    
	// Save Button
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
}

- (void)cancelar {
    field.value = nil;
	[self.navigationController popViewControllerAnimated:YES];
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
