//
//  ImageController.m
//  OWForms
//
//  Created by Madson on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageController.h"
#import "AppDelegate_iPhone.h"
#import "OWField.h"

@implementation ImageController

@synthesize imageView;
@synthesize imageButton;
@synthesize field;
@synthesize actionButton;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	
	self.navigationItem.title = @"Imagem";	
}

- (void)setupImage {
	UIImage *imagem = [self imagemForField];
	
	[imageView setImage:imagem];
	[imageButton setHidden:YES];
	
	self.navigationItem.rightBarButtonItem = actionButton;
	//self.navigationController.navigationBar.hidden = YES;
}

- (UIImage *)imagemForField {
	UIImage *imagem = [appDelegate.imageCache objectForKey:field.value];
	if (!imagem) {
		[self fazCacheDeImagem];
		imagem = [appDelegate.imageCache objectForKey:field.value];
	}
	return imagem ? imagem : [UIImage imageNamed:NSLocalizedString(@"adicionar_foto.png", @"")];
}

- (void)fazCacheDeImagem {
	UIImage *imagem = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(field.value)];
	if (imagem)
		[appDelegate.imageCache setObject:imagem forKey:field.value];
}

- (IBAction)takePicture:(id)sender {
	NSString *lastOption;
	
	if (!imagePickerController) {
		imagePickerController = [[UIImagePickerController alloc] init];
		[imagePickerController setDelegate:self];		
	}
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		lastOption = @"Da câmera";
	else
		lastOption = nil;
	
	if (field.value == nil) {
		if (!sheetImage)
			sheetImage = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
													 delegate:self
											cancelButtonTitle:@"Cancelar"
									   destructiveButtonTitle:nil
											otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[sheetImage showInView:self.view];
	} else {
		if (!sheetImageDelete)
			sheetImageDelete = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
														   delegate:self
												  cancelButtonTitle:@"Cancelar"
											 destructiveButtonTitle:@"Remover imagem"
												  otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[sheetImageDelete showInView:self.view];		
	}	
}

#pragma mark -
#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// Gera ID
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	field.value = (NSString *)newUniqueIDString;
	
	// Libera o ID gerado
	CFRelease(newUniqueID);
	CFRelease(newUniqueIDString);
	
	// Pega a imagem
	UIImage *thumbnail = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	// Adiciona a imagem ao cache
	[appDelegate.imageCache setObject:thumbnail forKey:field.value];
	[self setupImage];	
	
	// Salva a imagem do bebe
	NSString *thumbnailPath = pathInDocumentDirectory(field.value);
	[UIImageJPEGRepresentation(thumbnail, 1.0) writeToFile:thumbnailPath atomically:YES];
	
	// Fecha a view do ImagePicker
	[self dismissModalViewControllerAnimated:YES];	
}

#pragma mark -
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (sheetImage == actionSheet) {
		switch (buttonIndex) {
			case 0:
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			case 1:
			{
				if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
				{
					[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
					[self presentModalViewController:imagePickerController animated:YES];
					break;
				}
			}
			default:
				break;
		}
	} else {
		switch (buttonIndex) {
			case 0:
				field.value = nil;
				self.navigationItem.rightBarButtonItem = nil;
				[imageView setImage:nil];
				[imageButton setHidden:NO];
				break;
			case 1:
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			case 2:
			{
				if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
				{
					[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
					[self presentModalViewController:imagePickerController animated:YES];
					break;
				}
			}
			default:
				break;
		}
	}
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
