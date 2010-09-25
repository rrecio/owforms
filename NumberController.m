//
//  EditStringViewController.m
//  BabyNotes
//
//  Created by Madson on 10/11/09.
//  Copyright 2009 Owera. All rights reserved.
//

#import "NumberController.h"
#import "BabyNotesAppDelegate.h"

@implementation NumberController

- (id)initWithObject:(id)aObject property:(SEL)aProperty decimalPlaces:(int)aDecimalPlaces{
	self = [super init];
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	currentObject = [aObject retain];
	currentProperty = aProperty;
	decimalPlaces = aDecimalPlaces;
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
	[imageView setImage:[UIImage imageNamed:@"kal_grid_shadow.png"]];
	[imageView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
	[self.view addSubview:imageView];	
	[imageView release];
	
	// Title
	self.navigationItem.title = NSLocalizedString(@"Editando", nil);
	
	// Done Button
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil)
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	// Hides Back Button
	self.navigationItem.hidesBackButton = YES;
	
	return self;
}

- (id)initWithObject:(id)aObject property:(SEL)aProperty {
	return [self initWithObject:aObject property:aProperty decimalPlaces:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	[textField resignFirstResponder];
	
	[self doneAction:tf];
	//NSLog(@"%@", [NSString stringWithFormat:@"set%@:", [NSStringFromSelector(currentProperty) capitalizedString]]);3
	//SEL propriedade = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [NSStringFromSelector(currentProperty) capitalizedString]]);
	//[currentObject performSelector:propriedade withObject:[NSNumber numberWithFloat:[textField.text floatValue]]];

	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)valueChanged:(id)sender {
	// POR ENQUANTO, ESSE METODO NAO ESTA EM UTILIZACAO, POR ISSO O RETURN
	return;
	
	//NSLog(@"Antes de processar: %@", textField.text);
	NSString *fieldString = [textField.text copy];
	NSString *newString = [textField.text copy];
	
	if (decimalPlaces > 0) {
		NSString *stringConcatenada;
		NSRange range = [fieldString rangeOfString:@","];
		
		if ([fieldString hasPrefix:@","]) {
			fieldString = [NSString stringWithFormat:@"0%@", fieldString];
			NSString *depoisDaVirgula = [fieldString substringFromIndex:1];
			if ([depoisDaVirgula length] < decimalPlaces)
				fieldString = [fieldString stringByAppendingString:@"0"];
			textField.text = fieldString;
			return;
		}
		
		while (range.location != NSNotFound) {
			NSString *antesDaVirgula = [fieldString substringToIndex:range.location];
			NSString *depoisDaVirgula = [fieldString substringFromIndex:range.location+1];
			stringConcatenada = [NSString stringWithFormat:@"%@%@", antesDaVirgula, depoisDaVirgula];
			newString = [stringConcatenada copy];
			range = [newString rangeOfString:@","];
		}
		
		NSRange range2;
		range2.location = [newString length] - decimalPlaces;
		range2.length = decimalPlaces;
		NSString *doisUltimosCaracteres = [newString substringFromIndex:range2.location];
		NSString *doisUltimosCaracteresComVirgula = [NSString stringWithFormat:@",%@", doisUltimosCaracteres];
		newString = [newString stringByReplacingCharactersInRange:range2 withString:doisUltimosCaracteresComVirgula];
		
		if ([newString hasPrefix:@"0"]) {
			NSString *newTempString = [newString substringFromIndex:1];
			if (decimalPlaces == 0) {
				if (([newTempString length] == 0)) {
					return;
				}
			} else {
				if (([newTempString length] <= decimalPlaces + 1)) {
					return;
				}
			}
			newString = newTempString;
		}
		
		//NSLog(@"Nova string (antes de atribuir): %@", newString);
		
	} else {
		while ([newString hasPrefix:@"0"]) {
			NSString *newTempString = [fieldString substringFromIndex:1];
			if ([newTempString length] == 0) {
				return;
			}
			newString = newTempString;
		}
	}

	if (![textField.text isEqualToString:newString])
		textField.text = newString;
}

- (void)doneAction:(id)sender {
	NSRange range = [textField.text rangeOfString:@","];
	NSString *texto = textField.text;
	
	if (range.location != NSNotFound)
		texto = [texto stringByReplacingCharactersInRange:range withString:@"."];
	
	//NSLog(@"Valor: %0.3f", [texto floatValue]);
	
	SEL propriedade = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [NSStringFromSelector(currentProperty) capitalizedString]]);
	[currentObject performSelector:propriedade withObject:[NSNumber numberWithFloat:[texto floatValue]]];

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

	//textField.text = @"0";
	if (decimalPlaces > 0) {
		while ([textField.text length] <= decimalPlaces + 1) {
			if ([textField.text isEqualToString:@"0"]) {
				textField.text = [textField.text stringByAppendingString:@","];
			} else {
				textField.text = [textField.text stringByAppendingString:@"0"];
			}
		}
	}
	
	[tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[textField becomeFirstResponder];
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
	[super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

@end
