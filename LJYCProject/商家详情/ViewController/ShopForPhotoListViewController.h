//
//  ShopForPhotoListViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureListView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZYQAssetPickerController.h"

@interface ShopForPhotoListViewController : RootViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate>
{
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIButton *but4;
    
    PictureListView *listView1;
    PictureListView *listView2;
    PictureListView *listView3;
    PictureListView *listView4;
}
@property (nonatomic, retain) NSString *_shopId;
@property (nonatomic, retain) NSString *_shopName;
@property (strong, atomic) ALAssetsLibrary * library;
@end
