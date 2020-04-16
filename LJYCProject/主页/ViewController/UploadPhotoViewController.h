//
//  UploadPhotoViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "PhotoData.h"
#import "PicModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZYQAssetPickerController.h"

@interface UploadPhotoViewController : RootViewController <UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate, ZYQAssetPickerControllerDelegate>
{
    UISubTextField *nameField;
    PhotoData *photoData;
    CoustormPullDownMenuView *downView;
    UIScrollView *myScroll;
    UIButton *addPicBut;
    int scrollPgae;
    int delButTag;
}
@property (nonatomic, retain) NSMutableArray *_imgArray;
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) id _uploadDelegate;
@property (nonatomic, retain) NSMutableArray *_imgModelArr;
@property (nonatomic, retain) NSMutableArray * _imgViewArr;
@property (nonatomic, retain) NSMutableArray * _imgAllViewArr;
@property (nonatomic, retain) UIImage *_selfImage;
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, assign) NSInteger _minPicSelect;
@property (nonatomic, assign) NSInteger _maxPicSelect;
@property (strong, atomic) ALAssetsLibrary * library;

@property (nonatomic, retain) UIImageView *_fieldBackView;
@property (nonatomic, retain) UIImageView *_menuBackView;
@end
