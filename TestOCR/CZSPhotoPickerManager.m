//
//  CZSPhotoPickerManager.m
//  Chat
//
//  Created by 赛峰 施 on 15/10/20.
//  Copyright © 2015年 CZS Team 2015. All rights reserved.
//

#import "CZSPhotoPickerManager.h"

@interface CZSPhotoPickerManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *presentController;
@property (strong, nonatomic) UIImagePickerController *picker;
@end

@implementation CZSPhotoPickerManager

- (instancetype)initWithPresentController:(UIViewController *)presentController {
    self = [super init];
    if (self) {
        self.presentController = presentController;
    }
    return self;
}

- (UIImagePickerController *)picker {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = YES;
    }
    return _picker;
}

- (void)showActionSheet {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take photo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.presentController presentViewController:self.picker animated:YES completion:NULL];
        }];
        [alert addAction:takePhotoAction];
    }
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Select from album", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.presentController presentViewController:self.picker animated:YES completion:NULL];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:NULL];
    
    [alert addAction:albumAction];
    [alert addAction:cancleAction];
    
    [self.presentController presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        self.completPhoto(image);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        self.completPhoto(nil);
    }];
}

@end
