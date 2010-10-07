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
@synthesize scrollView;
@synthesize button;
@synthesize field;
@synthesize actionButton;

#pragma mark -
#pragma mark Application logic methods

- (void)setupImage {
	image = nil;
	
	image = [appDelegate.imageCache objectForKey:(NSString *)field.value];
	
	if (!image) {
		image = [UIImage imageWithContentsOfFile:pathInDocumentDirectory((NSString *)field.value)];
		if (image) {
			[appDelegate.imageCache setObject:image forKey:(NSString *)field.value];
			image = [appDelegate.imageCache objectForKey:(NSString *)field.value];
		}
	}
	
	if (image) {

		// Initialize the scroll view.
		CGSize imageSize = [image size];
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		[scrollView setDelegate:self];
		[scrollView setContentSize:imageSize];
		[scrollView setBackgroundColor:[UIColor blackColor]];
		[scrollView setShowsHorizontalScrollIndicator:NO];
		[scrollView setShowsVerticalScrollIndicator:NO];
		[scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin];
		
		// Create the image view.
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, imageSize.width, imageSize.height)];
		[imageView setImage:image];
		[scrollView addSubview:imageView];
		
		// Configure zooming.
		CGSize screenSize = [[UIScreen mainScreen] bounds].size;
		CGFloat widthRatio = screenSize.width / imageSize.width;
		CGFloat heightRatio = screenSize.height / imageSize.height;
		CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
		[scrollView setMaximumZoomScale:5.0];
		[scrollView setMinimumZoomScale:initialZoom];
		[scrollView setZoomScale:initialZoom];
		[scrollView setBouncesZoom:YES];
		
		// Center the photo.
		CGFloat topInset = (screenSize.height - imageSize.height * initialZoom) / 2.0;
		if (topInset > 0.0) {
			[scrollView setContentInset:UIEdgeInsetsMake(topInset - 44, 0.0, 0.0, 0.0)];
		}
		
		[button removeFromSuperview];
		self.navigationItem.rightBarButtonItem = actionButton;
		[self.view addSubview:scrollView];
	}

	self.navigationItem.rightBarButtonItem = actionButton;
}

- (void)takePicture:(id)sender {
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
		if (!actionSheetImage)
			actionSheetImage = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
													 delegate:self
											cancelButtonTitle:@"Cancelar"
									   destructiveButtonTitle:nil
											otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[actionSheetImage showInView:self.view];
	} else {
		if (!actionSheetImageDelete)
			actionSheetImageDelete = [[UIActionSheet alloc] initWithTitle:@"Nova imagem"
														   delegate:self
												  cancelButtonTitle:@"Cancelar"
											 destructiveButtonTitle:@"Remover imagem"
												  otherButtonTitles:@"Da biblioteca", lastOption, nil];
		[actionSheetImageDelete showInView:self.view];		
	}	
}

#pragma mark -
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheetImage == actionSheet) {
		switch (buttonIndex) {
			case 0: {
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			}
			case 1: {
				BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
				
				if (result) {
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
			case 0: {
				NSString *path = pathInDocumentDirectory((NSString *)field.value);
				
				if ([fileManager isDeletableFileAtPath:path])
					[fileManager removeItemAtPath:path error:nil];
				
				field.value = nil;
				
				self.navigationItem.rightBarButtonItem = nil;
				[imageView setImage:nil];
				[self.view addSubview:button];
				[scrollView removeFromSuperview];
				break;
			}
			case 1: {
				[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
				[self presentModalViewController:imagePickerController animated:YES];
				break;
			}
			case 2: {
				BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
				
				if (result) {
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

#pragma mark -
#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	// Gera ID
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	NSString *path = nil;
	
	if (field.value != nil) {
		path = pathInDocumentDirectory((NSString *)field.value);
		
		if ([fileManager isDeletableFileAtPath:path])
			[fileManager removeItemAtPath:path error:nil];
		
		field.value = nil;
	}
	
	field.value = (NSString *)newUniqueIDString;
	path = pathInDocumentDirectory((NSString *)field.value);
	
	// Libera o ID gerado
	CFRelease(newUniqueID);
	CFRelease(newUniqueIDString);
	
	// Pega a imagem
	image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	// Adiciona a imagem ao cache
	[appDelegate.imageCache setObject:image forKey:(NSString *)field.value];
	
	// Exibe a imagem
	[self setupImage];	
	
	// Salva a imagem
	[UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
	
	// Fecha a view do ImagePicker
	[self dismissModalViewControllerAnimated:YES];	
}

#pragma mark -
#pragma mark UIView lifecicle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
	
	fileManager = [[NSFileManager alloc] init];

	actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
																 target:self
																 action:@selector(takePicture:)];
	
	button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[button addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
	[button setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin];
	
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	self.navigationItem.title = @"Imagem";

	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (field.value != nil)
		[self setupImage];

	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)sv {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGSize imageSize = [image size];
    CGFloat topInset = (screenSize.height - imageSize.height * [sv zoomScale]) / 2.0;
	
    if (topInset < 0.0)
        topInset = 0.0;
	
    [sv setContentInset:UIEdgeInsetsMake(topInset, 0.0, -topInset, 0.0)];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[actionSheetImage release];
	[actionSheetImageDelete release];
	[imagePickerController release];
	[fileManager release];
    [super dealloc];
}

@end
