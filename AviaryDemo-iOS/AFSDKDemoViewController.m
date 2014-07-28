//
//  AFSDKDemoViewController.m
//  AviaryDemo-iOS
//
//  Created by Michael Vitrano on 1/23/13.
//  Copyright (c) 2013 Aviary. All rights reserved.
//

#import "AFSDKDemoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import <AviarySDK/AviarySDK.h>

#define API_KEY    @"3905e43f1eb6b37d"
#define SECRET_KEY @"e23332384f2d62fa"

static NSString * const kAFAviaryAPIKey = @"3905e43f1eb6b37d";
static NSString * const kAFAviarySecret = @"e23332384f2d62fa";

@interface AFSDKDemoViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
AFPhotoEditorControllerDelegate,
UIPopoverControllerDelegate
>

@property (strong, nonatomic) IBOutlet UIImageView *imagePreviewView;
@property (nonatomic, strong) UIPopoverController * popover;
@property (nonatomic, assign) BOOL shouldReleasePopover;

@property (nonatomic, strong) ALAssetsLibrary * assetLibrary;
@property (nonatomic, strong) NSMutableArray * sessions;

@end

@implementation AFSDKDemoViewController
@synthesize imagePreviewView;
@synthesize checker;
@synthesize slider, maxX, maxY, adView, iconView;
@synthesize flagEdit, flagResize, flagSilent, fotmat, lastVal, valuesArr;

#pragma mark - View Controller Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Allocate Asset Library
    ALAssetsLibrary * assetLibrary = [[ALAssetsLibrary alloc] init];
    [self setAssetLibrary:assetLibrary];
    
    // Allocate Sessions Array
    NSMutableArray * sessions = [NSMutableArray new];
    [self setSessions:sessions];
    
    // Start the Aviary Editor OpenGL Load
    [AFOpenGLManager beginOpenGLLoad];
    
    
    float viewHeight = [[UIScreen mainScreen]bounds].size.height;
    
    // Main View
    self.view.frame  = CGRectMake(0, 0, 320, viewHeight);
    
    toolBar.frame = CGRectMake(0, 0,
                               toolBar.frame.size.width,
                               toolBar.frame.size.height);
    
    // Title View
    titleView.frame = self.view.frame;
    
    [self.view addSubview:titleView];
    
    // Main View
    toolBar.frame = CGRectMake(0, 0,
                               toolBar.frame.size.width,
                               toolBar.frame.size.height);
    
    

    // Waiting View
    waitingView2.center = titleView.center;
    waitingView2.backgroundColor =  [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8];
    waitingView2.layer.cornerRadius = 7;
    waitingView2.clipsToBounds = YES;
    
    // Scale View
    scaleView.backgroundColor = [UIColor clearColor];
    scaleView.center = CGPointMake(self.view.frame.size.width / 2,
                                   self.view.frame.size.height * 3/4);

    setBtn1 = [self settingBtn:setBtn1];
    setBtn2 = [self settingBtn:setBtn2];
    setBtn3 = [self settingBtn:setBtn3];
    setBtn4 = [self settingBtn:setBtn4];
    setBtn5 = [self settingBtn:setBtn5];
    
    
    // Setting Photo Para
    setting = [[Setting alloc]init:self];
    imageSize = [setting checkDevicePhotoSize];
    
    sizeVal = maxX / maxY;
    
    
    // Set Slider
    slider.minimumValue = 200.0;
    slider.maximumValue = maxY;
    [slider addTarget:self
               action:@selector(changeSlider:)
     forControlEvents:UIControlEventValueChanged];
    // 5s, 5 ,4s
    //PixelXDimension = 3264;
    //PixelYDimension = 2448;
    // 1936 × 2592 . 4
    
    // Banner
    adView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50.0f,
                                                     320, 50)];
    adView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:adView];
    [ImobileSdkAds showBySpotID:SPOT_ID View:adView];
    
    // Icon Ads
    iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 420, 320, 75)];
    [titleView addSubview:iconView];
    ImobileSdkAdsIconParams *icon1Params = [[ImobileSdkAdsIconParams alloc] init];
    icon1Params.iconNumber = 4;
    icon1Params.iconTitleEnable = YES;
    icon1Params.iconTitleFontColor = @"#000000";
    icon1Params.iconTitleShadowEnable = YES;
    icon1Params.iconTitleShadowColor = @"#777777";
    [ImobileSdkAds showBySpotID:SPOT_ID_ICON View:iconView IconPrams:icon1Params];

    // Checker
    checker = [[VerChecker alloc]init:self];
    
    // Load Data
    [Data loadUserData:self];
    
    // Set Data
    [self settingUserData];
    
    
    // Size Label
    [sizeLabel setText:[NSString stringWithFormat:@"%.0f x %.0f",photoX, photoY]];
    
}

- (void)settingUserData {
    
    NSLog(@"--- %f",lastVal);
    
    photoY = lastVal;
    photoX = photoY * sizeVal;
    slider.value = lastVal;
}

- (UIButton*)settingBtn:(UIButton*)btn {
    
    [[btn layer] setBorderWidth:1.0f];
    [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    btn.layer.cornerRadius = 7;
    btn.clipsToBounds = YES;
    
    return btn;
}

- (void)hiddenStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

// サイズ選択のボタン値を設定
- (void)setScaleBtnVal {
    for (int i = 0; i < 4; i++) {
        btnVal[i] = [[valuesArr objectAtIndex:i]floatValue];
    }
}

#pragma mark - Btn Action
- (IBAction)titleBtnAction:(UIButton *)sender {
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    //imgPicker.allowsEditing = YES; // トリミングの可否
    NSLog(@"--- ----");
    
    if (sender.tag == CAMERA) {
        // Camera
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        // カメラと動画を選択可能にする
        imgPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        // 画像の大きさを調整するView
        [imgPicker.view addSubview:scaleView];
        
        // Set Scale
        [setBtn1 setTitle:[FMT:@"%.0f",[[valuesArr objectAtIndex:0]floatValue]] forState:UIControlStateNormal];
        [setBtn2 setTitle:[FMT:@"%.0f",[[valuesArr objectAtIndex:1]floatValue]] forState:UIControlStateNormal];
        [setBtn3 setTitle:[FMT:@"%.0f",[[valuesArr objectAtIndex:2]floatValue]] forState:UIControlStateNormal];
        [setBtn4 setTitle:[FMT:@"%.0f",[[valuesArr objectAtIndex:3]floatValue]] forState:UIControlStateNormal];
        
        
        //imgPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        //imgPicker.videoMaximumDuration = 10.0f;
        
        type = sender.tag;
        [self presentViewController:imgPicker animated:YES completion:NULL];
        
        [self sendAnalytics:@"/camera"];
        
    }
    
    if (sender.tag == ALBUM) { // Album
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        
        // Movie
        //imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        type = sender.tag;
        [self presentViewController:imgPicker animated:YES completion:NULL];
        
        [self sendAnalytics:@"/album"];
    }
    
    if (sender.tag == 2) { // Show InfoView
        
        InfoViewController *view = [[InfoViewController alloc]initWithNibName:@"InfoViewController"
                                                                       bundle:nil
                                                                         main:self];
        [self presentViewController:view animated:YES completion:nil];
        
        [self sendAnalytics:@"/info"];
        
    }
    if (sender.tag == 3) { // Wall Ads
        
        ImobileSdkAdsStatus status = [ImobileSdkAds getStatusBySpotID:SPOT_ID_WALL];
        if (IMOBILESDKADS_STATUS_READY == status) {
            [ImobileSdkAds showBySpotID:SPOT_ID_WALL];
        }
        
        
    }
    
    if (sender.tag == 4) { // Inter
        
        [ImobileSdkAds showBySpotID:SPOT_ID_INT];
    }
    
    else {
        
    }
    
    // Animation
    [CustomBtn addAnimation:sender];
    
    [self hiddenStatusBar];
}


// Tool Bar Btn Action
- (IBAction)toolBarBtnAction:(UIBarButtonItem *)sender {
    
    if (sender.tag == 3) {
        [self openEditer];
    }
}

// google analytics
-(void)sendAnalytics:(NSString*)message {
	
	[[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:message];
	[[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createAppView] build]];
	
}

// Open Photo Editer
- (void)openEditer {
    
     NSURL *assetURL = [pickerInfoDic objectForKey:UIImagePickerControllerReferenceURL];
    
     [[self assetLibrary] assetForURL:assetURL resultBlock:^(ALAsset *asset) {
         if (asset) {
             [self launchEditorWithAsset:asset];
         }
         } failureBlock:^(NSError *error) {
         /*
         [[[UIAlertView alloc] initWithTitle:@"Error"
                                     message:@"Please enable access to your device's photos."
                                    delegate:nil
                           cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         */
     }];
}

// Set Scale
- (IBAction)scalebtnAction:(UIButton*)sender {
    
    NSLog(@"--- scale Btn:%d",sender.tag);
    
    float val;
    
    switch (sender.tag) {
        case 0: val = [[valuesArr objectAtIndex:0]floatValue];//640;
            break;
        case 1: val = [[valuesArr objectAtIndex:1]floatValue];//960;
            break;
        case 2: val = [[valuesArr objectAtIndex:2]floatValue];//1280;
            break;
        case 3: val = [[valuesArr objectAtIndex:3]floatValue];//1880;
            break;
        case 4:
            if (imageSize == 0) {
                val = 3264.0f;
            } else {
                val = 2592.0f;
            }
            break;
    }
    
    [CustomBtn addAnimation:sender];
    
    [slider setValue:val animated:YES];
    
    photoY = val;
    photoX = val * sizeVal;
    
    // カメラモード
    if (type == CAMERA) {
        if (viewShift == PORTRAIT) {

        } else {
     
        }
    }

    if (type == ALBUM) {
        // 写真の大きさで判定
    }
    
    [sizeLabel setText:[NSString stringWithFormat:@"%.0f x %.0f",photoX, photoY]];
    
}

- (void)hiddenWaitingView {
    [waitingView2 removeFromSuperview];
}

// Slider Action
- (void)changeSlider:(UISlider*)sender {
    
    photoY = sender.value;
    photoX = sender.value * sizeVal;
    
    [sizeLabel setText:[NSString stringWithFormat:@"%.0f x %.0f",photoX, photoY]];
}

#pragma mark - Photo Editor Launch Methods
- (void) launchEditorWithAsset:(ALAsset *)asset
{
    UIImage * editingResImage = [self editingResImageForAsset:asset];
    UIImage * highResImage = [self highResImageForAsset:asset];
    
    [self launchPhotoEditorWithImage:editingResImage highResolutionImage:highResImage];
    
    // Hidden Indicator
    [self performSelector:@selector(hiddenWaitingView) withObject:nil afterDelay:2.0f];
}

- (void) launchEditorWithSampleImage
{
    UIImage * sampleImage = [UIImage imageNamed:@"Demo.png"];
    
    [self launchPhotoEditorWithImage:sampleImage highResolutionImage:nil];
}

#pragma mark - Photo Editor Creation and Presentation
- (void) launchPhotoEditorWithImage:(UIImage *)editingResImage highResolutionImage:(UIImage *)highResImage
{    
    // Customize the editor's apperance. The customization options really only need to be set once in this case since they are never changing, so we used dispatch once here.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setPhotoEditorCustomizationOptions];
    });
    
    // Initialize the photo editor and set its delegate
    AFPhotoEditorController * photoEditor = [[AFPhotoEditorController alloc] initWithImage:editingResImage];
    [photoEditor setDelegate:self];
    
    // If a high res image is passed, create the high res context with the image and the photo editor.
    if (highResImage) {
        [self setupHighResContextForPhotoEditor:photoEditor withImage:highResImage];
    }
    
    // Present the photo editor. default;animated:YES
    [self presentViewController:photoEditor animated:YES completion:nil];
    

    /*//-------------------------------------------------------------------------
    // View Animation
    photoEditor.view.frame = CGRectMake(0, 0, photoEditor.view.frame.size.width, photoEditor.view.frame.size.height + 50.0f);
    photoEditor.view.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2 * 3.0f);
    //photoEditor.view.backgroundColor = [UIColor yellowColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.45f];
    [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseOut];
    photoEditor.view.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2);
    [UIView commitAnimations];
    
    // Banner
    adView.center = CGPointMake(adView.center.x, adView.center.y - 50.0f);
    [photoEditor.view addSubview:adView];
    //photoEditor.
    //-------------------------------------------------------------------------*/


    
}

- (void) setupHighResContextForPhotoEditor:(AFPhotoEditorController *)photoEditor withImage:(UIImage *)highResImage
{
    // Capture a reference to the editor's session, which internally tracks user actions on a photo.
    __block AFPhotoEditorSession *session = [photoEditor session];
    
    // Add the session to our sessions array. We need to retain the session until all contexts we create from it are finished rendering.
    [[self sessions] addObject:session];
    
    // Create a context from the session with the high res image.
    AFPhotoEditorContext *context = [session createContextWithImage:highResImage];
    
    __block AFSDKDemoViewController * blockSelf = self;
    
    // Call render on the context. The render will asynchronously apply all changes made in the session (and therefore editor)
    // to the context's image. It will not complete until some point after the session closes (i.e. the editor hits done or
    // cancel in the editor). When rendering does complete, the completion block will be called with the result image if changes
    // were made to it, or `nil` if no changes were made. In this case, we write the image to the user's photo album, and release
    // our reference to the session. 
    [context render:^(UIImage *result) {
        if (result) {
            UIImageWriteToSavedPhotosAlbum(result, nil, nil, NULL);
        }
        
        [[blockSelf sessions] removeObject:session];
        
        blockSelf = nil;
        session = nil;
        
    }];
}

#pragma Photo Editor Delegate Methods

// This is called when the user taps "Done" in the photo editor. 
- (void) photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    [[self imagePreviewView] setImage:image];
    [[self imagePreviewView] setContentMode:UIViewContentModeScaleAspectFit];

    [self dismissViewControllerAnimated:YES completion:nil];
}

// This is called when the user taps "Cancel" in the photo editor.
- (void) photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Photo Editor Customization
- (void) setPhotoEditorCustomizationOptions
{
    // Set API Key and Secret
    [AFPhotoEditorController setAPIKey:API_KEY secret:SECRET_KEY];
    
    // Set Tool Order
    NSArray * toolOrder = nil;//@[kAFEffects, kAFFocus, kAFFrames, kAFStickers, kAFEnhance, kAFOrientation, kAFCrop, kAFAdjustments, kAFSplash, kAFDraw, kAFText, kAFRedeye, kAFWhiten, kAFBlemish, kAFMeme];
    [AFPhotoEditorCustomization setToolOrder:toolOrder];
    
    // Set Custom Crop Sizes
    [AFPhotoEditorCustomization setCropToolOriginalEnabled:NO];
    [AFPhotoEditorCustomization setCropToolCustomEnabled:YES];
    NSDictionary * fourBySix = @{kAFCropPresetHeight : @(4.0f), kAFCropPresetWidth : @(6.0f)};
    NSDictionary * fiveBySeven = @{kAFCropPresetHeight : @(5.0f), kAFCropPresetWidth : @(7.0f)};
    NSDictionary * square = @{kAFCropPresetName: @"Square", kAFCropPresetHeight : @(1.0f), kAFCropPresetWidth : @(1.0f)};
    [AFPhotoEditorCustomization setCropToolPresets:@[fourBySix, fiveBySeven, square]];
    
    // Set Supported Orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray * supportedOrientations = @[@(UIInterfaceOrientationPortrait), @(UIInterfaceOrientationPortraitUpsideDown), @(UIInterfaceOrientationLandscapeLeft), @(UIInterfaceOrientationLandscapeRight)];
        [AFPhotoEditorCustomization setSupportedIpadOrientations:supportedOrientations];
    }
}

#pragma mark - UIImagePicker Delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    pickerInfoDic = info;
    
    NSLog(@"%@",info);
    
    /*
    
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (!image) { return; }
    
    
    //NSLog(@"%@",info);
    
    [self hiddenStatusBar];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Set Imgae
    [imagePreviewView setImage:(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    // Set Size
    CGRect photoRect = [(NSValue *)[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    
    photoX = photoRect.size.width;
    photoY = photoRect.size.height;
    
    // 画像の向き
    if (photoX < photoY) {
        photoShift = PORTRAIT;
    } else {
        photoShift = LANDSCAPE;
    }
    
    [titleView removeFromSuperview];
    
    //[self presentViewController:picker animated:YES completion:NULL];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //[self dismissViewControllerAnimated:YES completion:completion];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //[self dismissPopoverWithCompletion:completion];
        [self dismissPopoverWithCompletion:nil];
    }
    */
    
    photoUrl = nil;
    
    if (type == ALBUM) {
        
        photoUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
        
        // Check Photo Type
        UIImage *img =  [info objectForKey:UIImagePickerControllerOriginalImage];
        CGImageRef ref = img.CGImage;
        photoX = (float)CGImageGetWidth(ref);
        photoY = (float)CGImageGetHeight(ref);
        NSLog(@"画像サイズ:%.0f x %.0f", photoX, photoY);
   
        if (photoX < photoY) { // 縦長
            photoType = PHOTO_POR;
        } else {
            photoType = PHOTO_LAN;
        }
        
        [sizeLabel setText:[NSString stringWithFormat:@"%.0f x %.0f",photoX, photoY]];
        
        [self setPhotoUrl:photoUrl];
        
    } else { // Camera
        
        NSLog(@"--- Pre Size:%.0f x %.0f",photoY, photoX);
        //////////////////////////////////////////////////
        // Save Para
        if (photoX < photoY) {
            // 縦長
            photoType = PHOTO_POR;
            //lastVal = photoX;
        } else {
            photoType = PHOTO_LAN;
            //lastVal = photoX;
        }
        [Data changeUserData:self];
        //////////////////////////////////////////////////
        
        // Indicator
        [picker.view addSubview:waitingView2];
        
        // Assetを使うためにはセーブしなければならない
        UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        
        image = [self resizeImage:image];
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
        // Save Time 1.0 sc
        [self performSelector:@selector(checkAlbumInfo) withObject:nil afterDelay:2.0f];
    }
}

// Photo Resize
- (UIImage*)resizeImage:(UIImage*)img {
    
    // 画像のリサイズ後のサイズ
    CGSize resizedSize = CGSizeMake(photoX, photoY);
    
    NSLog(@"--- Saved Size:%.0f x %.0f",photoY, photoX);
    
    // UIGraphics××の関数を利用して、画像をリサイズする
    UIGraphicsBeginImageContext(resizedSize);
    [img drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (void)checkAlbumInfo {
    
    // 最新のAssetを調べる
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        // Within the group enumeration block, filter to enumerate just photos.
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
    
        photoNum = group.numberOfAssets;
        
        //NSLog(@"--- photoNum:%d",photoNum);
        
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:photoNum-1]
                                options:NSEnumerationReverse
                             usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
                                 
                                 // The end of the enumeration is signaled by asset == nil.
                                 if (alAsset) {
                                     
                                     photoUrl = [[alAsset defaultRepresentation] url];
                                     NSLog(@"--- %@",photoUrl);
                                     
                                     [self setPhotoUrl:photoUrl];
         
                                      //ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                                      //UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
         
                                     // Stop the enumerations
                                     *stop = YES; *innerStop = YES;
                                     
                                     return ;
                                 }
                             }];
        
    } failureBlock: ^(NSError *error) {
        // Typically you should handle an error more gracefully than this.
        NSLog(@"No groups");
    }];
}

- (void)setPhotoUrl:(NSURL*)url {
    
    NSLog(@"--- setPhotoUrl:(NSURL*)url:%@",url);
    
    void(^completion)(void)  = ^(void){
        
        [[self assetLibrary] assetForURL:url resultBlock:^(ALAsset *asset) {
            
            if (asset){
                [self launchEditorWithAsset:asset];
            }
            
        } failureBlock:^(NSError *error) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enable access to your device's photos." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
        
    };
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:completion];
    }else{
        [self dismissPopoverWithCompletion:completion];
    }
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Popover Methods

- (void) presentViewControllerInPopover:(UIViewController *)controller
{
    CGRect sourceRect = [[self choosePhotoButton] frame];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:controller];
    [popover setDelegate:self];
    [self setPopover:popover];
    [self setShouldReleasePopover:YES];
    
    [popover presentPopoverFromRect:sourceRect inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (void) dismissPopoverWithCompletion:(void(^)(void))completion
{
    [[self popover] dismissPopoverAnimated:YES];
    [self setPopover:nil];

    NSTimeInterval delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if ([self shouldReleasePopover]){
        [self setPopover:nil];
    }
    [self setShouldReleasePopover:YES];
}

#pragma mark - ALAssets Helper Methods

- (UIImage *)editingResImageForAsset:(ALAsset*)asset
{
    CGImageRef image = [[asset defaultRepresentation] fullScreenImage];
    
    
    return [UIImage imageWithCGImage:image scale:1.0 orientation:UIImageOrientationUp];
}

- (UIImage *)highResImageForAsset:(ALAsset*)asset
{
    ALAssetRepresentation * representation = [asset defaultRepresentation];
    
    CGImageRef image = [representation fullResolutionImage];
    UIImageOrientation orientation = [representation orientation];
    CGFloat scale = [representation scale];
    
    return [UIImage imageWithCGImage:image scale:scale orientation:orientation];
}

#pragma mark - Interface Actions

- (IBAction)editSample:(id)sender
{
    if ([self hasValidAPIKey]) {
        [self launchEditorWithSampleImage];
    }

}

- (IBAction)choosePhoto:(id)sender
{
    if ([self hasValidAPIKey]) {
        UIImagePickerController * imagePicker = [UIImagePickerController new];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [imagePicker setDelegate:self];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else{
            [self presentViewControllerInPopover:imagePicker];
        }
    }
}

#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    }else{
        return YES;
    }
}

- (BOOL) shouldAutorotate
{
    //NSLog(@"--- 回転:%d",[[UIDevice currentDevice] orientation]);
    
    int orientation = [[UIDevice currentDevice]orientation];
    
    if (orientation < 3) {
        // 縦向き
        viewShift = PORTRAIT;
        NSLog(@"--- PORTRAIT");
    } else {
        // 横向き
        viewShift = LANDSCAPE;
        NSLog(@"--- LANDSCAPE");
    }
    
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setShouldReleasePopover:NO];
    [[self popover] dismissPopoverAnimated:YES];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if ([self popover]) {
        CGRect popoverRef = [[self choosePhotoButton] frame];
        [[self popover] presentPopoverFromRect:popoverRef inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}

#pragma mark - Status Bar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private Helper Methods

- (BOOL) hasValidAPIKey
{
    /*
    if ([kAFAviaryAPIKey isEqualToString:@"<YOUR-API-KEY>"] || [kAFAviarySecret isEqualToString:@"<YOUR-SECRET>"]) {
        [[[UIAlertView alloc] initWithTitle:@"Oops!"
                                    message:@"You forgot to add your API key and secret!"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return NO;
    }
    */
    
    return YES;
}

@end
