//
//  InfoViewController.h
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/15.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFSDKDemoViewController.h"
#import "Common.h"
#import "CustomBtn.h"
#import "CustomTF.h"

@class AFSDKDemoViewController;
@class CustomBtn;

@interface InfoViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
{
    
    CustomBtn *customBtn;
    
    
    UIButton *scaleBtn[4];
    UITextField *textField[4];
    
    IBOutlet UITableView *tableView;
    IBOutlet UIButton    *backBtn;
    NSArray              *infoArr;
    
    IBOutlet UITableViewCell *cell0;
    IBOutlet UITableViewCell *cell1;
    IBOutlet UITableViewCell *cell2;
    IBOutlet UITableViewCell *cell3;
    IBOutlet UITableViewCell *cell4;
    
    IBOutlet UISegmentedControl *seg0;
    IBOutlet UISegmentedControl *seg1;
    IBOutlet UISegmentedControl *seg2;
    IBOutlet UISegmentedControl *seg3;
    
    IBOutlet UISlider *slider;
    
    IBOutlet UIButton *sizeBtn0;
    IBOutlet UIButton *sizeBtn1;
    IBOutlet UIButton *sizeBtn2;
    IBOutlet UIButton *sizeBtn3;
    
}

@property (nonatomic, retain)AFSDKDemoViewController *mainClass;
@property (nonatomic, retain)NSMutableArray *valuesArr;
@property (nonatomic)UIView *adView, *iconView;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                 main:(AFSDKDemoViewController*)main;


@end
