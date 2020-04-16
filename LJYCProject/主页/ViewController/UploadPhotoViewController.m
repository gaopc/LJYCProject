//
//  UploadPhotoViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "MyRegex.h"

@interface UploadPhotoViewController ()

@end

@implementation UploadPhotoViewController
@synthesize _imgArray, _uploadDelegate;
@synthesize keyboardbar, textFieldArray;
@synthesize _imgModelArr,_imgViewArr,_imgAllViewArr;
@synthesize _selfImage;
@synthesize _shopId;
@synthesize _maxPicSelect, _minPicSelect;
@synthesize library;
@synthesize _fieldBackView, _menuBackView;

- (void)dealloc
{
    self._menuBackView = nil;
    self._fieldBackView = nil;
    self._imgArray = nil;
    self.keyboardbar = nil;
    self.textFieldArray = nil;
    self._uploadDelegate = nil;
    self._imgModelArr = nil;
    self._imgViewArr = Nil;
    self._imgAllViewArr = nil;
    [_selfImage release];
    _selfImage = nil;
    self._shopId = nil;
    [library release];
    self.library = nil;
    [myScroll release];
    [super dealloc];
}

-(void)selfImage
{
    [self addToScrollview:self._selfImage];

}
-(void)set_selfImage:(UIImage *)selfImage
{
    if (_selfImage != selfImage) {
        [_selfImage release];
        _selfImage = [selfImage retain];
        PicModel * model = [[PicModel alloc] init];
        model._image = [self imageWithImageSimple:selfImage scaledToSize:selfImage.size];
        model._imgName = @"iphone_upload_pic";
        model._imgType = nil;
        model._imgTypeName = nil;
        [self._imgModelArr addObject:model];
        [self addToScrollview:selfImage];
        [model release];
        
        scrollPgae = self._imgModelArr.count - 1;
    }
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIImage* newImage = image;
    if (newSize.width > 1200) {
        newSize = CGSizeMake(1200, 1200*newSize.height/newSize.width);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this newcontext, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        // End the context
        UIGraphicsEndImageContext();
        // Return the new image.
    }
    if (newImage.size.height > 1600  ) {
        newSize = CGSizeMake(1600 *newImage.size.width/newImage.size.height, 1600);
        UIGraphicsBeginImageContext(newSize);
        // Tell the old image to draw in this newcontext, with the desired
        // new size
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        // Get the new image from the context
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        // End the context
        UIGraphicsEndImageContext();
        // Return the new image.
    }
    return newImage;
}

-(void)addToScrollview:(UIImage *)image {
    
    if (!myScroll) {
        self._imgViewArr = [NSMutableArray array];
        self._imgAllViewArr = [NSMutableArray array];
        myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(60, 0, 200, 200)];
        myScroll.pagingEnabled = YES;
        myScroll.clipsToBounds = NO;
        myScroll.showsHorizontalScrollIndicator = NO;
        myScroll.showsVerticalScrollIndicator = NO;
        myScroll.scrollsToTop = NO;
        myScroll.delegate = self;
        
        addPicBut = [UIButton buttonWithType:UIButtonTypeCustom tag:0 title:@"" backImage:nil frame:CGRectMake(260, 10, 60, 180) font:nil color:nil target:self action:@selector(addPicBut:)];
        [addPicBut setImage:[UIImage imageNamed:@"添加照片.png"] forState:UIControlStateNormal];
        
        [myScroll addSubview:addPicBut];
        [self.view_IOS7 addSubview:myScroll];
        [self.view_IOS7 addSubview:addPicBut];
    }
    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(10 + myScroll.frame.size.width*([self._imgModelArr count] - 1), 10, 180, 180)];
    if (!myScroll.superview) {
        [self.view_IOS7 addSubview:myScroll];
        [self.view_IOS7 addSubview:addPicBut];
    }
//    else
    {
        
    }

    
    imageView.tag = [self._imgModelArr count] + 99;
    
	
    UIImageView *editView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 0, 0) image:image];
    editView.userInteractionEnabled = YES;
    editView.frame = [self returnImageFrame:image withWidth:180 withHeight:180];
    UIButton *imageDel = [UIButton buttonWithTag:([self._imgModelArr count] - 1) frame:CGRectMake(editView.frame.size.width - 40, 2, 38, 38) target:self action:@selector(deletePic:)];
    [imageDel setImage:[UIImage imageNamed:@"报错.png"] forState:UIControlStateNormal];
    [imageDel setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 20, 0)];

    [editView addSubview:imageDel];
    [imageView addSubview:editView];
    [myScroll addSubview:imageView];
    
    [self._imgViewArr addObject:imageView];
    
    if ([self._imgAllViewArr count]>imageDel.tag) {
        [self._imgAllViewArr replaceObjectAtIndex:imageDel.tag withObject:imageView];
    }
    else
    {
        [self._imgAllViewArr addObject:imageView];
    }
    
    myScroll.contentSize = CGSizeMake(myScroll.frame.size.width*[self._imgModelArr count], myScroll.frame.size.height);
    [myScroll setContentOffset:CGPointMake(myScroll.frame.size.width*([self._imgModelArr count] - 1), 0) animated:YES];
    [imageView release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"上传照片";
//    scrollPgae = 0;
    self.library = [[ALAssetsLibrary alloc] init];
    
    UIButton *rightBut = [CoustomButton buttonWithBlueBorder:CGRectMake(10, 7, 52, 30) target:self action:@selector(uploadImage) title:@"完成"];
	UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    
    self._fieldBackView = [UIImageView ImageViewWithFrame:CGRectMake(20, 200, 280, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    nameField = [UISubTextField TextFieldWithFrame:CGRectMake(40, 200, 250, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:@"请输入照片名称" font:FontSize24];
    nameField.delegate = self;
    nameField.clearButtonMode = YES;
    nameField.text = @"iphone_upload_pic";
    
    self._menuBackView = [UIImageView ImageViewWithFrame:CGRectMake(20, 240, 280, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    downView = [[CoustormPullDownMenuView alloc] initWithFrame:CGRectMake(20, 240, 280, 30)];
    downView.delegate = self;
    downView.array = [NSArray arrayWithObjects:@"环境", @"住宿", @"餐饮", @"其它", nil];
    downView.placeStr = @"请选择照片类型";

    
    [self.view_IOS7 addSubview:self._fieldBackView];
    [self.view_IOS7 addSubview:self._menuBackView];
    [self.view_IOS7 addSubview:nameField];
    [self.view_IOS7 addSubview:downView];
    
    [downView release];
    
    self.textFieldArray = [NSArray array];
    
//    [self addToScrollview:self._selfImage];

    if (!myScroll.superview) {
        [self.view_IOS7 addSubview:myScroll];
        [self.view_IOS7 addSubview:addPicBut];

    }
}

- (void)viewDidUnload
{
    self._selfImage = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [myScroll setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)uploadImage
{
    [downView closeView];
    [keyboardbar HiddenKeyBoard];
    
    if (self._imgModelArr.count == 0) {
        [UIAlertView alertViewWithMessage:@"请添加照片"];
        return;
    }
    
    if (self._imgModelArr.count < self._minPicSelect) {
        [UIAlertView alertViewWithMessage:@"请添加至少2张照片"];
        return;
    }
    NSLog(@"scrollPgae %d", scrollPgae);
    PicModel * picModel = [self._imgModelArr objectAtIndex:scrollPgae];
    picModel._imgTypeName = downView.selectedString;
    picModel._imgName = nameField.text;
    
    NSArray *typeNameArr = [NSArray arrayWithObjects:@"环境", @"住宿", @"餐饮", @"其它", nil];
    [self._imgArray removeAllObjects];
    
    for (int i = 0; i < [self._imgModelArr count]; i ++) {
        
        PicModel * model = [self._imgModelArr objectAtIndex:i];
        [self._imgArray addObject:model._image];
        
        if (model._imgName.length == 0) {
            [UIAlertView alertViewWithMessage:@"请输入照片名称"];
            return;
        }
        
        NSString *errStr = [model._imgName stringByReplacingOccurrencesOfString:@"-" withString:@"0"];
        NSArray *errArr = [errStr componentsSeparatedByRegex:PHOTO_NAME];
        
        if (errArr.count > 0) {
            [UIAlertView alertViewWithMessage:@"照片名称可以输入中文、字母、数字、“_”和“-”"];
            return;
        }
        
        if (model._imgTypeName.length == 0) {
            model._imgType = @"4";
        }
        else {
            int type = [typeNameArr indexOfObject:model._imgTypeName];
            model._imgType = [NSString stringWithFormat:@"%d", type + 1];
        }
    }
    
    [WaitView showWaitView];
    [self performSelectorInBackground:@selector(setZipRequest:) withObject:self._imgArray];
}

- (void)setZipRequest:(NSMutableArray *)array
{
    ASIFormDataRequest * theRequest = [InterfaceClass uploadPicture:array];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredUploadImageResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredUploadImageResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message];
        return;
    }
    NSArray *picArr = [dic objectForKey:@"picture"];
    for (NSDictionary *picDic in picArr) {
        
        NSLog(@"图片名称匹配！！！！！！！！");
        int picIndex = [[picDic objectForKey:@"name"] intValue];
        PicModel *model = [self._imgModelArr objectAtIndex:picIndex];
        model._imgId = [picDic objectForKey:@"id"];
    }
    
    ASIFormDataRequest * theRequest = [InterfaceClass uploadPicture:[UserLogin sharedUserInfo].userID withShopId:self._shopId withImageArr:self._imgModelArr];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredUploadShopImageResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredUploadShopImageResult:(NSDictionary *)dic
{
    NSString *statusCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"statusCode"]];
    NSString *message = [NSString stringWithFormat:@"%@", [dic objectForKey:@"message"]];
    if (![statusCode isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:message];
        return;
    }
    else {
        [UIAlertView alertViewWithMessage:message tag:1 delegate:self];
    }
}


#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7];
		self.keyboardbar = _keyboardbar;
		[_keyboardbar release];
	}
	[self.keyboardbar showBar:textField];  //显示工具条
	
	return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString * textFieldStr = [[textField.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSInteger textFieldStrLength = textFieldStr.length;
	int textFieldMaxLenth = 0;
    
//    NSArray *errArr = [textFieldStr componentsSeparatedByRegex:PHOTO_NAME];
//    if ([errArr count] != 0) {
//        return NO;
//    }
	
	if (nameField == textField) {
		
		textFieldMaxLenth = 20;
	}
    
	if(textFieldStrLength >= textFieldMaxLenth)
	{
		textField.text = [textFieldStr substringToIndex:textFieldMaxLenth];
		return NO;
	}
	else {
		return YES;
	}
}

- (CGRect)returnImageFrame:(UIImage *)image withWidth:(int)viewWidth withHeight:(int)viewHeight
{
    int width = 0;
	int height = 0;
	if (image.size.width > viewWidth)
	{
		width = viewWidth;
		height =  viewWidth * image.size.height / image.size.width;
		
		if (height > viewHeight) {
			height = viewHeight;
			width = viewHeight * image.size.width / image.size.height;
		}
		
	}else if (image.size.height > viewHeight) {
		height = viewHeight;
		width = viewHeight * image.size.width / image.size.height;
	}
	else
	{
		width = image.size.width;
		height = image.size.height;
	}
	
	int imageQidianX = (viewWidth - width) / 2;
	int imageQidianY = (viewHeight - height) / 2;
    
    CGRect imgFrame;
    imgFrame.size.width = width;
    imgFrame.size.height = height;
    imgFrame.origin.x = imageQidianX;
    imgFrame.origin.y = imageQidianY;
    
    return imgFrame;
}

- (void)addPicBut:(UIButton *)sender
{
    if (self._imgModelArr.count >= self._maxPicSelect) {
        [UIAlertView alertViewWithMessage:@"您添加的相片已达到上限！"];
        return;
    }
    if (self._imgModelArr.count > 0) {
        PicModel * picModel = [self._imgModelArr objectAtIndex:scrollPgae];
        picModel._imgTypeName = downView.selectedString;
        picModel._imgName = nameField.text;
    }
    
    [downView closeView];
    [keyboardbar HiddenKeyBoard];
    
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
	camera.videoQuality = UIImagePickerControllerQualityTypeLow;
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
//    [imagePicker release];
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = self._maxPicSelect - self._imgModelArr.count;
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
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self.library saveImage:image toAlbum:@"辣郊游" withCompletionBlock:^(NSError *error) {
            if (error!=nil) {
                NSLog(@"保存图片失败: %@", [error description]);
            }
        }];
    }
    
    self._fieldBackView.hidden = NO;
    self._menuBackView.hidden = NO;
    nameField.hidden = NO;
    downView.hidden = NO;
    
    self._selfImage = image;
    nameField.text = @"iphone_upload_pic";
    downView.selectedString = nil;
    
    if (self._imgModelArr.count == 1) {
        addPicBut.frame = CGRectMake(260, 10, 60, 180);
    }
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    self._fieldBackView.hidden = NO;
    self._menuBackView.hidden = NO;
    nameField.hidden = NO;
    downView.hidden = NO;
    
    for (int i=0; i<assets.count; i++) {
        
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            self._selfImage = tempImg;
        });
    }
    nameField.text = @"iphone_upload_pic";
    downView.selectedString = nil;
    
    if (self._imgModelArr.count == 1) {
        addPicBut.frame = CGRectMake(260, 10, 60, 180);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    addPicBut.hidden = YES;
    PicModel * picModel = [self._imgModelArr objectAtIndex:scrollPgae];
    picModel._imgTypeName = downView.selectedString;
    picModel._imgName = nameField.text;

    [downView closeView];
    [keyboardbar HiddenKeyBoard];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = myScroll.frame.size.width;
    scrollPgae = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    if (scrollPgae < [self._imgModelArr count]) {
        
        if (scrollPgae == self._imgModelArr.count - 1) {
            addPicBut.hidden = NO;
        }
        
        PicModel * picModel = [self._imgModelArr objectAtIndex:scrollPgae];
        nameField.text = picModel._imgName;
        downView.selectedString = picModel._imgTypeName;
    }
}

- (void)deletePic:(UIButton *)sender
{
    delButTag = sender.tag;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除照片" message:@"确认删除当前选中照片？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 2;
    [alertView show];
    [alertView release];
}

- (void)deleteImage:(int)buttonTag
{
    NSLog(@"删除图片%d", buttonTag);
    
    UIView * delView = [self._imgAllViewArr objectAtIndex:buttonTag];
    int index = [self._imgViewArr indexOfObject:delView ];
    [delView removeFromSuperview];
    NSLog(@"%@,%d",delView,delView.tag);
    [self._imgModelArr removeObjectAtIndex:index];
    [self._imgViewArr removeObject:delView];
    
//    if ([self._imgViewArr count]==0) {
//        [self._imgAllViewArr removeAllObjects];
//    }

    
    for (int i = 0; i < [self._imgViewArr count]; i++) {
        UIView * view = [self._imgViewArr objectAtIndex:i];
        view.frame = CGRectMake(10 + myScroll.frame.size.width*i, 10, 180, 180);
    }
    
    myScroll.contentSize = CGSizeMake(myScroll.frame.size.width*[self._imgModelArr count], myScroll.frame.size.height);
    
    if (index == [self._imgViewArr count]) {
        scrollPgae --;
        [myScroll setContentOffset:CGPointMake(myScroll.frame.size.width*([self._imgViewArr count] - 1), 0) animated:YES];
    }
    
    if (scrollPgae == self._imgModelArr.count - 1) {
        addPicBut.hidden = NO;
    }
    
    if (self._imgModelArr.count > 0) {
        PicModel * picModel = [self._imgModelArr objectAtIndex:scrollPgae];
        nameField.text = picModel._imgName;
        downView.selectedString = picModel._imgTypeName;
    }
    else {
        nameField.text = nil;
        downView.selectedString = nil;
        self._fieldBackView.hidden = YES;
        self._menuBackView.hidden = YES;
        nameField.hidden = YES;
        downView.hidden = YES;
        
        addPicBut.frame = CGRectMake(70, 10, 180, 180);
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag == 1) {
        
        if (self._uploadDelegate && [self._uploadDelegate respondsToSelector:@selector(uploadPhotos:)]) {
            [self._uploadDelegate performSelector:@selector(uploadPhotos:) withObject:self._imgModelArr];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (alertView.tag == 2) {
        
        if (buttonIndex == 1) {
            [self deleteImage:delButTag];
        }
    }
}
@end