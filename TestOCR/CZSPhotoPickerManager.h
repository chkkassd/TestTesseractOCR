//
//  CZSPhotoPickerManager.h
//  Chat
//
//  Created by 赛峰 施 on 15/10/20.
//  Copyright © 2015年 CZS Team 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PICKER_SELECTED,
    PICKER_CANCEL
}PICK_STATE;

typedef void(^CompletPhoto)(UIImage *image);

@interface CZSPhotoPickerManager : NSObject
@property (copy, nonatomic) CompletPhoto completPhoto;
- (instancetype)initWithPresentController:(UIViewController *)presentController;
- (void)showActionSheet;
@end
