//
//  AddShopsViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-29.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardTopBar.h"
#import "CoustomPickerView.h"
#import "coustomActionSheetView.h"
#import "AddShopsData.h"
#import "BaiduMKMapView.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import "ZYQAssetPickerController.h"


@interface AddShopsViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate ,BaiduMKMapViewDelegate,BaiduMKMapViewAddShopDelegate, ZYQAssetPickerControllerDelegate>
{
    UITableView *myTable;
    NSArray *rowArray;
    
    CoustormPullDownMenuView *downView1;
    CoustormPullDownMenuView *downView2;
    CoustormPullDownMenuView *downView3;
    UISubLabel *introduceNum;
    UISubLabel *noticeNum;
    
    AddShopsData *shopData;
    UITextField *nameField;
    UITextField *phoneField;
    
    UITextView *noticeView;
}
@property (nonatomic, retain) NSArray *textFieldArray;
@property (nonatomic, retain) KeyBoardTopBar *keyboardbar;
@property (nonatomic, retain) NSMutableArray *_imgArray;
@property (nonatomic, retain) NSMutableArray *_itemArr;
@property (nonatomic, retain) BaiduMKMapView *bMKMapView;

@property (nonatomic, retain) NSString *_shopType;
@property (nonatomic, retain) NSString *_cityName;
@property (nonatomic, retain) NSString *_district;
@property (nonatomic, retain) NSString *_address;
@property (nonatomic, retain) NSString *_longitude;
@property (nonatomic, retain) NSString *_latitude;

@property (nonatomic, assign) BOOL _textViewEdit;
@property (nonatomic, retain) UITextView *_introduceView;
@property (strong, atomic) ALAssetsLibrary * library;

- (void)clearViews;
@end
