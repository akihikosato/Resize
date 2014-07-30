//
//  AFSDKDemoViewController.h
//  AviaryDemo-iOS
//
//  Created by Michael Vitrano on 1/23/13.
//  Copyright (c) 2013 Aviary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImobileSdkAds/ImobileSdkAds.h>

#import "Common.h"
#import "Setting.h"
#import "InfoViewController.h"
#import "VerChecker.h"

typedef enum {
    PORTRAIT,
    LANDSCAPE
} SHIFT;

typedef enum {
    PHOTO_POR,
    PHOTO_LAN
} PHOTO_TYPE;

typedef enum {
    CAMERA,
    ALBUM
} PICKER_TYPE;

typedef enum {
    LAERGE,
    SMALL
} IMAGE_SIZE;

typedef enum {
    SAVED
} ALERT;

typedef enum {
    EDIT,
    SCALE_EDIT,
    CALCEL
} EDITOR_STATE;

@class Setting;
@class InfoViewController;
@class VerChecker;

@interface AFSDKDemoViewController : UIViewController
<
UIAlertViewDelegate
>
{
    // Class
    Setting    *setting;
    //VerChecker *checker;
    
    SHIFT       viewShift;
    PICKER_TYPE type;
    PHOTO_TYPE  photoType;
    IMAGE_SIZE  imageSize;
    
    
    UIImage *mainImage;
    
    float photoX, photoY, sizeVal, btnVal[4];
    int   photoNum;
    BOOL  isSetted, addEdited;;
    
    NSDictionary *pickerInfoDic;
    UIImage      *savedImage;
    NSURL        *photoUrl;
    
    // Main View
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIView *waitingView;
    IBOutlet UIView *waitingView2;
    IBOutlet UIActivityIndicatorView *indiView;
    
    // Scale View
    IBOutlet UIView    *scaleView;
    IBOutlet UILabel   *sizeLabel;
    IBOutlet UIButton  *setBtn1;
    IBOutlet UIButton  *setBtn2;
    IBOutlet UIButton  *setBtn3;
    IBOutlet UIButton  *setBtn4;
    IBOutlet UIButton  *setBtn5;
    
    // Title View
    IBOutlet UIView *titleView;
    IBOutlet UIButton *cameraBtn;
    IBOutlet UIButton *albumBtn;
    IBOutlet UIButton *settingBtn;
    IBOutlet UIButton *recoBtn;

}


@property (strong, nonatomic) IBOutlet UIButton *editSampleButton;
@property (strong, nonatomic) IBOutlet UIButton *choosePhotoButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic, retain) VerChecker *checker;;
@property (nonatomic, assign) IBOutlet UISlider *slider;
@property (nonatomic, assign) float maxX, maxY;
@property (nonatomic) UIView *adView, *iconView;

// KEYS
@property (nonatomic) BOOL flagEdit, flagResize, format, flagSilent;
@property (nonatomic, assign) float lastVal;
@property (nonatomic, retain) NSMutableArray *valuesArr;


- (IBAction)editSample:(id)sender;
- (IBAction)choosePhoto:(id)sender;
- (void)setScaleBtnVal;
@end
