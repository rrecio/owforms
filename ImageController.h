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

@interface ImageController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate> {
	UIImagePickerController *imagePickerController;
	UIImageView *imageView;
	UIButton *imageButton;
	UIBarButtonItem *actionButton;

	UIActionSheet *sheetImage;
	UIActionSheet *sheetImageDelete;
	
	AppDelegate_iPhone *appDelegate;
	OWField *field;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *imageButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic, retain) OWField *field;

- (IBAction)takePicture:(id)sender;
- (UIImage *)imagemForField;
- (void)setupImage;
- (void)fazCacheDeImagem;

@end
