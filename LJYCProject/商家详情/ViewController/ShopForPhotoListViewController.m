//
//  ShopForPhotoListViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-25.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "ShopForPhotoListViewController.h"
#import "MemberPhotoDetailViewController.h"
#import "UploadPhotoViewController.h"
#import "MemberLoginViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

#define selectColor [UIColor colorWithRed:0x7C/255.0 green:0xD0/255.0 blue:0xEF/255.0 alpha:1];
#define unSelectColor [UIColor colorWithRed:0x29/255.0 green:0xA7/255.0 blue:0xD5/255.0 alpha:1];

@interface ShopForPhotoListViewController ()

@end

@implementation ShopForPhotoListViewController
@synthesize _shopId, _shopName;
@synthesize library;

- (void)dealloc
{
    self._shopId = nil;
    self._shopName = nil;
    [library release];
    self.library = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"商家照片";
    self.library = [[ALAssetsLibrary alloc] init];
    
    but1 = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"环境" frame:CGRectMake(20, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but2 = [UIButton buttonWithType:UIButtonTypeCustom tag:1 title:@"住宿" frame:CGRectMake(20 + 70, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but3 = [UIButton buttonWithType:UIButtonTypeCustom tag:2 title:@"餐饮" frame:CGRectMake(20 + 70*2, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    but4 = [UIButton buttonWithType:UIButtonTypeCustom tag:3 title:@"其它" frame:CGRectMake(20 + 70*3, 10, 70, 27) font:FontSize24 color:FontColorFFFFFF target:self action:@selector(photoType:)];
    
    UIImageView *line = [UIImageView ImageViewWithFrame:CGRectMake(25, 47, 270, 1) image:[UIImage imageNamed:@"横向分割线.png"]];
    
    [self selectPhotoTpye:0];
    
    [self.view_IOS7 addSubview:but1];
    [self.view_IOS7 addSubview:but2];
    [self.view_IOS7 addSubview:but3];
    [self.view_IOS7 addSubview:but4];
    [self.view_IOS7 addSubview:line];

    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(uploadPicture) title:@"上传"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

#pragma mark - self
- (void)photoType:(UIButton *)sender
{
    [self selectPhotoTpye:sender.tag];
    
}

- (void)selectPhotoTpye:(int)index
{
    [self setButColor:index];
    
    [listView1 removeFromSuperview];
    [listView2 removeFromSuperview];
    [listView3 removeFromSuperview];
    [listView4 removeFromSuperview];
    
    switch (index) {
        case 0:
            if (!listView1) {
                listView1 = [self setWaterFlowView:index];
            }
            [self.view_IOS7 addSubview:listView1];
            break;
            
        case 1:
            if (!listView2) {
                listView2 = [self setWaterFlowView:index];
            }
            [self.view_IOS7 addSubview:listView2];
            break;
            
        case 2:
            if (!listView3) {
                listView3 = [self setWaterFlowView:index];
            }
            [self.view_IOS7 addSubview:listView3];
            break;
            
        case 3:
            if (!listView4) {
                listView4 = [self setWaterFlowView:index];
            }
            [self.view_IOS7 addSubview:listView4];
            break;
            
        default:
            break;
    }
}

- (void)setButColor:(int)index
{
    but1.backgroundColor = unSelectColor;
    but2.backgroundColor = unSelectColor;
    but3.backgroundColor = unSelectColor;
    but4.backgroundColor = unSelectColor;
    
    switch (index) {
        case 0:
            but1.backgroundColor = selectColor;
            break;
        case 1:
            but2.backgroundColor = selectColor;
            break;
        case 2:
            but3.backgroundColor = selectColor;
            break;
        case 3:
            but4.backgroundColor = selectColor;
            break;
            
        default:
            break;
    }
}

- (PictureListView *)setWaterFlowView:(NSInteger)index
{
    PictureListView *view = [[PictureListView alloc] initWithFrame:CGRectMake(0, 53, ViewWidth, ViewHeight - 45 - 60)];
	view._delegate = self;
    view._picType = [NSString stringWithFormat:@"%d", index + 1];
    view._shopId = self._shopId;
	view.backgroundColor = [UIColor clearColor];
    [view showView];
    
    return view;
}

- (void)selectedPic:(NSArray *)sender :(NSString *)selectIndex
{
    NSLog(@"选择相片");
    
    MemberPhotoDetailViewController *detailVC = [[MemberPhotoDetailViewController alloc] init];
    detailVC._picArray = sender;
    detailVC._picIndex = selectIndex;
    detailVC._detailData = [sender objectAtIndex:[selectIndex intValue]];
    detailVC._detailData._shopName = self._shopName;
    detailVC._isMember = NO;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)uploadPicture
{
    if (NO == [self setUserLogin:ShopForUpload]) {
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照上传" otherButtonTitles:@"上传手机中的相片", nil];
    actionSheet.tag = 0;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

#pragma mark - UIActionSheet UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self startCamera];
    }
    else if (buttonIndex == 1) {
        
        [self showImagePickerForPhotoPicker];
        
    }
}

-(void)startCamera {
    
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
	
	camera.delegate = self;
	camera.allowsEditing = NO;
	
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		//UI 显示样式，显示的格式确定
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
		//mediaTypes用来确定再picker里显示那些类型的多媒体文件，图片？视频？
		//camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	//拍摄照片的清晰度，只有在照相机模式下可用
	camera.videoQuality = UIImagePickerControllerQualityTypeHigh;
	[self presentViewController:camera animated:YES completion:nil];
	[camera release];
}

- (void)showImagePickerForPhotoPicker
{
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.delegate = self;
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    imagePicker.allowsEditing = NO;
//    [self presentModalViewController:imagePicker animated:YES];
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    //    {
    //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    //    }
    //    [self performSelector:@selector(saveImage:)
    //               withObject:image
    //               afterDelay:0.5];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self.library saveImage:image toAlbum:@"辣郊游" withCompletionBlock:^(NSError *error) {
            if (error!=nil) {
                NSLog(@"保存图片失败: %@", [error description]);
            }
        }];
    }
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._selfImage = image;
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = self._shopId;
    uploadVC._maxPicSelect = 10;
    uploadVC._minPicSelect = 0;
    
    [uploadVC release];
    
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    UploadPhotoViewController *uploadVC = [[UploadPhotoViewController alloc] init];
    uploadVC._uploadDelegate = self;
    [self.navigationController pushViewController:uploadVC animated:YES];
    uploadVC._imgModelArr = [NSMutableArray array];
    uploadVC._imgArray = [NSMutableArray array];
    uploadVC._shopId = self._shopId;
    uploadVC._minPicSelect = 0;
    uploadVC._maxPicSelect = 10;
    
    for (int i=0; i<assets.count; i++) {
        
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            uploadVC._selfImage = tempImg;
        });
    }
    [uploadVC release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (BOOL)setUserLogin:(ShopClickType)type
{
    if (![UserLogin sharedUserInfo].userID)
    {
        MemberLoginViewController *memberLoginVC = [[MemberLoginViewController alloc] init];
        memberLoginVC.delegate = self;
        memberLoginVC._clickType = type;
        [self.navigationController pushViewController:memberLoginVC animated:YES];
        [memberLoginVC release];
        return NO;
    }
    return YES;
}

-(void) loginSuccessFul:(ShopClickType)type
{
    NSLog(@"type:%d", type);
    if (type == ShopForUpload) {
        
        [self performSelector:@selector(uploadPicture)
                   withObject:nil
                   afterDelay:0.1];
    }
}

@end
