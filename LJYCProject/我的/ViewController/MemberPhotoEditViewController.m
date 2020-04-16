//
//  MemberPhotoEditViewController.m
//  LJYCProject
//
//  Created by gaopengcheng on 13-11-14.
//  Copyright (c) 2013年 longcd. All rights reserved.
//

#import "MemberPhotoEditViewController.h"
#import "MemberPhotoListViewController.h"

@interface MemberPhotoEditViewController ()

@end

@implementation MemberPhotoEditViewController
@synthesize _editImage;
@synthesize keyboardbar, textFieldArray;
@synthesize _picData;
@synthesize _delegate;

- (void)dealloc
{
    self._editImage = nil;
    self.textFieldArray = nil;
    self.keyboardbar = nil;
    self._picData = nil;
    self._delegate = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"编辑照片";
    
    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(70, 10, 180, 180)];
	
    UIImageView *editView = [UIImageView ImageViewWithFrame:CGRectMake(0, 0, 0, 0) image:self._editImage];
    editView.frame = [self returnImageFrame:self._editImage withWidth:180 withHeight:180];
    
    UIImageView *textView = [UIImageView ImageViewWithFrame:CGRectMake(20, 200, 280, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    nameField = [UISubTextField TextFieldWithFrame:CGRectMake(40, 200, 250, 30) borderStyle:UITextBorderStyleNone textAlignment:NSTextAlignmentLeft placeholder:nil font:FontSize24];
    nameField.delegate = self;
    nameField.text = self._picData._imgName;
    
    UIImageView *textView1 = [UIImageView ImageViewWithFrame:CGRectMake(20, 240, 280, 30) image:[[UIImage imageNamed:@"输入框.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    downView = [[CoustormPullDownMenuView alloc] initWithFrame:CGRectMake(20, 240, 280, 30)];
    downView.delegate = self;
    downView.array = [NSArray arrayWithObjects:@"环境", @"住宿", @"餐饮", @"其它", nil];
    downView.selectedString = [downView.array objectAtIndex:[self._picData._imgType intValue] - 1];
    
    UIButton *delBut = [CoustomButton buttonWithOrangeColor:CGRectMake(25, 290, 110, 30) target:self action:@selector(deleteImage) title:@"删除"];
    delBut.titleLabel.font = FontSize26;
    delBut.backgroundColor = [UIColor purpleColor];
    
    UIButton *editBut = [CoustomButton buttonWithOrangeColor:CGRectMake(165, 290, 110, 30) target:self action:@selector(editImage) title:@"完成"];
    editBut.titleLabel.font = FontSize26;
    
    [imageView addSubview:editView];
    [self.view_IOS7 addSubview:imageView];
    [self.view_IOS7 addSubview:textView];
    [self.view_IOS7 addSubview:nameField];
    [self.view_IOS7 addSubview:delBut];
    [self.view_IOS7 addSubview:editBut];
    [self.view_IOS7 addSubview:textView1];
    [self.view_IOS7 addSubview:downView];
    
    [downView release];
    
    self.textFieldArray = [NSArray array];
}

- (void)deleteImage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除相片" message:@"确定要删除该相片吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 0;
    [alert show];
    [alert release];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        ASIFormDataRequest * theRequest = [InterfaceClass userPhotoDelete:[UserLogin sharedUserInfo].userID withId:self._picData._imgId];
        [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredDelImageResult:) Delegate:self needUserType:Default];
    }
}

- (void)onPaseredDelImageResult:(NSDictionary *)dic
{
    if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(deletePic)]) {
        [self._delegate performSelector:@selector(deletePic)];
    }
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i ++) {
        if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberPhotoListViewController class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
}

- (void)editImage
{
    if (nameField.text.length == 0) {
        [UIAlertView alertViewWithMessage:@"请添加相片的名称！"];
        return;
    }
    NSString *picType = [NSString stringWithFormat:@"%d", downView.selectedIndex + 1];
    
    self._picData._imgName = nameField.text;
    self._picData._imgType = picType;
    
    ASIFormDataRequest * theRequest = [InterfaceClass userPhotoEdit:self._picData._imgId withUserId:[UserLogin sharedUserInfo].userID withName:nameField.text withType:picType];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onPaseredEditImageResult:) Delegate:self needUserType:Default];
}

- (void)onPaseredEditImageResult:(NSDictionary *)dic
{
    if (![[dic objectForKey:@"statusCode"] isEqualToString:@"0"]) {
        
        [UIAlertView alertViewWithMessage:[dic objectForKey:@"message"]];
        return;
    }
    
    if (self._delegate && [self._delegate respondsToSelector:@selector(editPic:)]) {
        [self._delegate performSelector:@selector(editPic:) withObject:self._picData];
    }
    
    for (int i = 0; i < [self.navigationController.viewControllers count]; i ++) {
        if ([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MemberPhotoListViewController class]]) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
        }
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

- (void)selectedSelf:(CoustormPullDownMenuView *)sender
{
    
}

#pragma mark - textField UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (self.keyboardbar == nil) {
		
		KeyBoardTopBar * _keyboardbar = [[KeyBoardTopBar alloc] init:self.textFieldArray view:self.view_IOS7 ];
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
	
	if (nameField == textField) {
		
		textFieldMaxLenth = 30;
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
@end
