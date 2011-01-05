//
//  ImageController.h
//  OWForms
//
//  Created by Madson on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate_iPhone;
@class OWField;

@interface ImageController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIScrollViewDelegate> {
	UIImage *image;
	UIImageView *imageView;
	UIScrollView *scrollView;
	
	UIButton *button;
	UIBarButtonItem *actionButton;
	UIImagePickerController *imagePickerController;
	
	UIActionSheet *actionSheetImage;
	UIActionSheet *actionSheetImageDelete;
	
	NSFileManager *fileManager;
	
	AppDelegate_iPhone *appDelegate;
	OWField *field;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIBarButtonItem *actionButton;
@property (nonatomic, retain) OWField *field;

- (void)takePicture:(id)sender;
- (void)setupImage;

@end
