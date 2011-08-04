//
//  StringController.m
//  OWForms
//
//  Created by Madson on 25/09/10.
//  Copyright 2009 Owera. All rights reserved.
//

#import "StringController.h"
#import "OWFieldText.h"

@implementation StringController

@synthesize field;
@synthesize textField;
@synthesize tableViewCell;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = field.label;
    self.tableView.allowsSelection = NO;
    
    if (field.keyboardType == UIKeyboardTypeDefault)
        textField.keyboardType = UIKeyboardTypeDefault;
    else
        textField.keyboardType = field.keyboardType;

    if (field.capitalizationType == UITextAutocapitalizationTypeWords)
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    else
        textField.autocapitalizationType = field.capitalizationType;
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelar)] autorelease];

	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", @"") style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.navigationItem.hidesBackButton = YES;
}

- (void)cancelar {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)doneAction:(id)sender {
    
    NSString *texto = textField.text;
    
    [texto stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (texto == nil || [texto isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Campos nulos", nil)
														message:NSLocalizedString(@"Você precisa preencher os campos para continuar.", nil)
													   delegate:self
											  cancelButtonTitle:nil
											  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
		[alert show];
		[alert release];
    }else{
        field.value = textField.text;
        [textField resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }

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
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[textField setText:(NSString *)field.value];
	textField.placeholder = NSLocalizedString(@"Digite aqui", nil);
	if (field.isPassword) textField.secureTextEntry = YES;
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
