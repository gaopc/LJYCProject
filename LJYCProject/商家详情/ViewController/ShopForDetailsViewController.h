//
//  ShopForDetailsViewController.h
//  LJYCProject
//
//  Created by gaopengcheng on 13-10-24.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopForDataInfo.h"
#import "ShopFindProperty.h"
#import "ShopForCommentData.h"
#import "ShopForQuestionData.h"
#import "ShopFindViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZYQAssetPickerController.h"

@class ShopFindProperty;
@class ShopFindDataResponse;
@interface ShopForDetailsViewController : RootViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, ZYQAssetPickerControllerDelegate>
{
    UITableView *myTable;
    UIView *bottomView;
    ShopFindDataResponse *shopFindDataResponse;
    ShopForQuestionData *questData;
    ShopForCommentData *commentData;
    BOOL isMoreRow;
    CGSize introSize;
    CGSize serviceSize;
    BOOL notLoadQusetion;
    BOOL isOrder;       //团购标示 YES:有团购信息
    BOOL isOpen;        //代金券信息是否展开
    
    UIButton *rightBut;
}
@property (nonatomic ,retain) ShopForDataInfo *_detailData;
@property (nonatomic, retain) Shops *shops;
@property (nonatomic, retain) ShopFindProperty *shopFindProperty;
@property (nonatomic, retain) ShopFindViewController *shopListVC;
@property (nonatomic, assign) BOOL _isSign;

@property (strong, atomic) ALAssetsLibrary * library;
@property (nonatomic, retain) NSString *_orderId;

@end
