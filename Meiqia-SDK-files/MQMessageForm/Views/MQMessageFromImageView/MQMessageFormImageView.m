//
//  MQMessageFormImageView.m
//  MeiQiaSDK
//
//  Created by bingoogolapple on 16/5/4.
//  Copyright © 2016年 MeiQia Inc. All rights reserved.
//

#import "MQMessageFormImageView.h"
#import "MQAssetUtil.h"
#import "MQBundleUtil.h"
#import "MQMessageFormConfig.h"
#import "MQImageViewerViewController.h"

static CGFloat const kMQMessageFormSpacing   = 16.0;
static CGFloat const kMQMessageFormMaxPictureItemLength = 116;

@implementation MQMessageFormImageView {
    UILabel *addPictureLabel;
    
    UIView *pictureOneItem;
    UIImageView *pictureOneIv;
    UIImageView *deleteOneIv;
    
    UIView *pictureTwoItem;
    UIImageView *pictureTwoIv;
    UIImageView *deleteTwoIv;
    
    UIView *pictureThreeItem;
    UIImageView *pictureThreeIv;
    UIImageView *deleteThreeIv;
    
    CGFloat pictureItemLength;
    CGFloat pictureLength;
    
    NSMutableArray *images;
    UIImage *deleteIconImage;
    UIImage *addIconImage;
    
    CGFloat deleteIconLength;
}

- (instancetype)initWithScreenWidth:(CGFloat)screenWidth {
    self = [super init];
    if (self) {
        images = [NSMutableArray arrayWithCapacity:3];
        deleteIconImage = [MQMessageFormConfig sharedConfig].messageFormViewStyle.deleteImage;
        addIconImage = [MQMessageFormConfig sharedConfig].messageFormViewStyle.addImage;
        
        [self calculatePictureAndPictureItemLengthWithScreenWidth:screenWidth];
        
        [self initAddPictureLabel];
        [self initPictureOneItem];
        [self initPictureTwoItem];
        [self initPictureThreeItem];
        
        [self handlePictureCount];
    }
    return self;
}

/**
 *  根据屏幕宽度计算图片宽度和图片条目宽度
 *
 *  @param screenWidth 屏幕宽度
 */
- (void)calculatePictureAndPictureItemLengthWithScreenWidth:(CGFloat)screenWidth {
    pictureItemLength = (screenWidth - 4 * kMQMessageFormSpacing) / 3;
    pictureItemLength = pictureItemLength > kMQMessageFormMaxPictureItemLength ? kMQMessageFormMaxPictureItemLength : pictureItemLength;
    deleteIconLength = 24;
    pictureLength = pictureItemLength - deleteIconLength / 2;
}

- (void)initAddPictureLabel {
    addPictureLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMQMessageFormSpacing, 0, 0, 0)];
    addPictureLabel.text = [MQBundleUtil localizedStringForKey:@"add_picture"];
    addPictureLabel.textColor = [MQMessageFormConfig sharedConfig].messageFormViewStyle.addPictureTextColor;
    addPictureLabel.font = [UIFont systemFontOfSize:14.0];
    [addPictureLabel sizeToFit];
    [self addSubview:addPictureLabel];
}

- (void)initPictureOneItem {
    pictureOneItem = [[UIView alloc] init];
    
    pictureOneIv = [[UIImageView alloc] init];
    pictureOneIv.contentMode = UIViewContentModeScaleAspectFill;
    pictureOneIv.clipsToBounds = YES;
    pictureOneIv.userInteractionEnabled = YES;
    [pictureOneIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPictureOne)]];
    
    deleteOneIv = [[UIImageView alloc] init];
    deleteOneIv.image = deleteIconImage;
    deleteOneIv.userInteractionEnabled = YES;
    [deleteOneIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteOne)]];
    
    [pictureOneItem addSubview:pictureOneIv];
    [pictureOneItem addSubview:deleteOneIv];
    
    [self refreshPictureOneFrame];
    [self addSubview:pictureOneItem];
}

- (void)refreshPictureOneFrame {
    CGFloat addPictureLabelMaxY = CGRectGetMaxY(addPictureLabel.frame);
    pictureOneItem.frame = CGRectMake(kMQMessageFormSpacing, addPictureLabelMaxY, pictureItemLength, pictureItemLength);
    pictureOneIv.frame = CGRectMake(0, deleteIconLength / 2, pictureLength, pictureLength);
    deleteOneIv.frame = CGRectMake(pictureItemLength - deleteIconLength, 0, deleteIconLength, deleteIconLength);
}

- (void)initPictureTwoItem {
    pictureTwoItem = [[UIView alloc] init];
    
    pictureTwoIv = [[UIImageView alloc] init];
    pictureTwoIv.contentMode = UIViewContentModeScaleAspectFill;
    pictureTwoIv.clipsToBounds = YES;
    pictureTwoIv.userInteractionEnabled = YES;
    [pictureTwoIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPictureTwo)]];
    
    deleteTwoIv = [[UIImageView alloc] init];
    deleteTwoIv.image = deleteIconImage;
    deleteTwoIv.userInteractionEnabled = YES;
    [deleteTwoIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteTwo)]];
    
    [pictureTwoItem addSubview:pictureTwoIv];
    [pictureTwoItem addSubview:deleteTwoIv];
    [self refreshPictureTwoFrame];
    [self addSubview:pictureTwoItem];
}

- (void)refreshPictureTwoFrame {
    CGFloat addPictureLabelMaxY = CGRectGetMaxY(addPictureLabel.frame);
    pictureTwoItem.frame = CGRectMake(CGRectGetMaxX(pictureOneItem.frame) + kMQMessageFormSpacing - deleteIconLength / 2, addPictureLabelMaxY, pictureItemLength, pictureItemLength);
    pictureTwoIv.frame = CGRectMake(0, deleteIconLength / 2, pictureLength, pictureLength);
    deleteTwoIv.frame = CGRectMake(pictureItemLength - deleteIconLength, 0, deleteIconLength, deleteIconLength);
}

- (void)initPictureThreeItem {
    pictureThreeItem = [[UIView alloc] init];
    
    pictureThreeIv = [[UIImageView alloc] init];
    pictureThreeIv.contentMode = UIViewContentModeScaleAspectFill;
    pictureThreeIv.clipsToBounds = YES;
    pictureThreeIv.userInteractionEnabled = YES;
    [pictureThreeIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPictureThree)]];
    
    deleteThreeIv = [[UIImageView alloc] init];
    deleteThreeIv.image = deleteIconImage;
    deleteThreeIv.userInteractionEnabled = YES;
    [deleteThreeIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteThree)]];
    
    [pictureThreeItem addSubview:pictureThreeIv];
    [pictureThreeItem addSubview:deleteThreeIv];
    [self refreshPictureThreeFrame];
    [self addSubview:pictureThreeItem];
}

- (void)refreshPictureThreeFrame {
    CGFloat addPictureLabelMaxY = CGRectGetMaxY(addPictureLabel.frame);
    pictureThreeItem.frame = CGRectMake(CGRectGetMaxX(pictureTwoItem.frame) + kMQMessageFormSpacing - deleteIconLength / 2, addPictureLabelMaxY, pictureItemLength, pictureItemLength);
    pictureThreeIv.frame = CGRectMake(0, deleteIconLength / 2, pictureLength, pictureLength);
    deleteThreeIv.frame = CGRectMake(pictureItemLength - deleteIconLength, 0, deleteIconLength, deleteIconLength);
}

- (void)tapDeleteOne {
    [images removeObjectAtIndex:0];
    [self handlePictureCount];
}

- (void)tapDeleteTwo{
    [images removeObjectAtIndex:1];
    [self handlePictureCount];
}

- (void)tapDeleteThree {
    [images removeObjectAtIndex:2];
    [self handlePictureCount];
}

- (void)tapPictureOne {
    if (images.count < 1) {
        [self showChoosePictureActionSheet];
    } else {
        [self showImageViewerFromRect:[pictureOneIv.superview convertRect:pictureOneIv.frame toView:[UIApplication sharedApplication].keyWindow] withIndex:0];
    }
}

- (void)tapPictureTwo {
    if (images.count < 2) {
        [self showChoosePictureActionSheet];
    } else {
        [self showImageViewerFromRect:[pictureTwoIv.superview convertRect:pictureTwoIv.frame toView:[UIApplication sharedApplication].keyWindow] withIndex:1];
    }
}

- (void)tapPictureThree {
    if (images.count < 3) {
        [self showChoosePictureActionSheet];
    } else {
        [self showImageViewerFromRect:[pictureThreeIv.superview convertRect:pictureThreeIv.frame toView:[UIApplication sharedApplication].keyWindow] withIndex:2];
    }
}

- (void)showImageViewerFromRect:(CGRect)rect withIndex:(NSUInteger)index {
    MQImageViewerViewController *viewerVC = [MQImageViewerViewController new];
    viewerVC.images = images;
    viewerVC.currentIndex = index;
    viewerVC.shouldHideSaveBtn = YES;
    
    __weak MQImageViewerViewController *wViewerVC = viewerVC;
    [viewerVC setSelection:^(NSUInteger index) {
        __strong MQImageViewerViewController *sViewerVC = wViewerVC;
        [sViewerVC dismiss];
    }];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [viewerVC showOn:[UIApplication sharedApplication].keyWindow.rootViewController fromRect:rect];
}

- (void)showMenuControllerInView:(UIView *)inView
                      targetRect:(CGRect)targetRect
                   menuItemsName:(NSDictionary *)menuItemsName
{
    [self becomeFirstResponder];
    //判断menuItem都有哪些
    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:menuItems];
    [menu setTargetRect:targetRect inView:inView];
    [menu setMenuVisible:YES animated:YES];
}

- (void)handlePictureCount {
    if (images.count == 0) {
        [self changeToZeroPicture];
    } else if (images.count == 1) {
        [self changeToOnePicture];
    } else if (images.count == 2) {
        [self changeToTwoPicture];
    } else if (images.count == 3) {
        [self changeToThreePicture];
    }
}

- (void)changeToZeroPicture {
    pictureTwoItem.hidden = YES;
    pictureThreeItem.hidden = YES;
    
    deleteOneIv.hidden = YES;
    deleteTwoIv.hidden = YES;
    deleteThreeIv.hidden = YES;
    
    pictureOneIv.image = addIconImage;
}

- (void)changeToOnePicture {
    pictureTwoItem.hidden = NO;
    pictureThreeItem.hidden = YES;
    
    deleteOneIv.hidden = NO;
    deleteTwoIv.hidden = YES;
    deleteThreeIv.hidden = YES;
    
    pictureOneIv.image = [images objectAtIndex:0];
    pictureTwoIv.image = addIconImage;
}

- (void)changeToTwoPicture {
    pictureTwoItem.hidden = NO;
    pictureThreeItem.hidden = NO;
    
    deleteOneIv.hidden = NO;
    deleteTwoIv.hidden = NO;
    deleteThreeIv.hidden = YES;
    
    pictureOneIv.image = [images objectAtIndex:0];
    pictureTwoIv.image = [images objectAtIndex:1];
    pictureThreeIv.image = addIconImage;
}

- (void)changeToThreePicture {
    pictureTwoItem.hidden = NO;
    pictureThreeItem.hidden = NO;
    
    deleteOneIv.hidden = NO;
    deleteTwoIv.hidden = NO;
    deleteThreeIv.hidden = NO;
    
    pictureOneIv.image = [images objectAtIndex:0];
    pictureTwoIv.image = [images objectAtIndex:1];
    pictureThreeIv.image = [images objectAtIndex:2];
}

- (void)refreshFrameWithScreenWidth:(CGFloat)screenWidth andY:(CGFloat)y {
    [self calculatePictureAndPictureItemLengthWithScreenWidth:screenWidth];
    
    [addPictureLabel sizeToFit];
    
    [self refreshPictureOneFrame];
    [self refreshPictureTwoFrame];
    [self refreshPictureThreeFrame];
    
    self.frame = CGRectMake(0, y + kMQMessageFormSpacing, screenWidth, CGRectGetMaxY(pictureOneItem.frame) + kMQMessageFormSpacing);
}

- (void)addImage:(UIImage *)image {
    [images addObject:image];
    [self handlePictureCount];
}

- (NSArray *)getImages {
    return images;
}

- (void)showChoosePictureActionSheet {
    // 先关闭键盘，否则会被键盘遮住
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:[MQBundleUtil localizedStringForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[MQBundleUtil localizedStringForKey:@"select_gallery"], [MQBundleUtil localizedStringForKey:@"select_camera"], nil];
    [sheet showInView:self.superview];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            if ([self.delegate respondsToSelector:@selector(choosePictureWithSourceType:)]) {
                [self.delegate choosePictureWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            break;
        }
        case 1: {
            if ([self.delegate respondsToSelector:@selector(choosePictureWithSourceType:)]) {
                [self.delegate choosePictureWithSourceType:(NSInteger*)UIImagePickerControllerSourceTypeCamera];
            }
            break;
        }
    }
    actionSheet = nil;
}

@end