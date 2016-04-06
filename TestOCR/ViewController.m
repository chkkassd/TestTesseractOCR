//
//  ViewController.m
//  TestOCR
//
//  Created by 赛峰 施 on 16/4/6.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import "ViewController.h"
#import "CZSPhotoPickerManager.h"
#import "MBProgressHUD.h"
#import "UIImage+ScaleSize.h"
#import <TesseractOCR/TesseractOCR.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) CZSPhotoPickerManager *pickerManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showPickerManager {
    self.pickerManager = [[CZSPhotoPickerManager alloc] initWithPresentController:self];
    __weak typeof(self) weakSelf = self;
    self.pickerManager.completPhoto = ^(UIImage *image){
        if (image) {
            UIImage *scaleImage = [UIImage imageCompressForWidth:image targetWidth:weakSelf.imageView.frame.size.width];
            weakSelf.imageView.image = scaleImage;
            [weakSelf performImageRecognitionWithImage:scaleImage];
        }
    };
    [self.pickerManager showActionSheet];
}

- (void)performImageRecognitionWithImage:(UIImage *)image {
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng+chi_sim" engineMode:G8OCREngineModeTesseractOnly];
    
    // 4
    tesseract.pageSegmentationMode = G8PageSegmentationModeAuto;
    
    // 5
    tesseract.maximumRecognitionTime = 60.0;
    
    // 6
    tesseract.image = image.g8_blackAndWhite;
    [tesseract recognize];
    
    // 7
    self.textView.text = tesseract.recognizedText;
}

- (IBAction)photoButtonPressed:(id)sender {
    [self showPickerManager];
}
@end
