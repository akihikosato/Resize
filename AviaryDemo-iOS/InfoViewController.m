//
//  InfoViewController.m
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/15.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize mainClass, adView, iconView, valuesArr;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                 main:(AFSDKDemoViewController*)main
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mainClass = main;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < 4; i++) {
        textField[i] = [[CustomTF alloc]init:mainClass
                                   infoClass:self
                                         tag:i];
        textField[i].delegate = self;
        [cell4 addSubview:textField[i]];
    }

    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;

    // Set Segment
    [self initSegment];
}

- (void)hoge1:(UITextField*)textField {
    //NSLog(@"*** *** ***");
}
- (void)hoge:(UITextField*)textField {
}

- (void)viewWillAppear:(BOOL)animated {
    // Ads
    adView = mainClass.adView;
    [self.view addSubview:adView];
    
    iconView = mainClass.iconView;
    [self.view addSubview:iconView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)tappedBtn:(UIButton *)sender {
    
    if (sender.tag < 4) {
        adView.hidden   = YES;
        iconView.hidden = YES;
    }
    else if (sender.tag == 4) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        mainClass.adView = adView;
        [mainClass.view addSubview:mainClass.adView];
        
        mainClass.iconView = iconView;
        [mainClass.view addSubview:mainClass.iconView];
    }
    else if (4 < sender.tag) {
        
        [CustomBtn addAnimation:sender];
        
        // Infomation Alert
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Title"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK", nil
                              ];
        
        alert.tag = sender.tag;
        [alert setMessage:[self dialogMessage:sender.tag]];
        
        [alert show];
    }
}

- (NSString*)dialogMessage:(int)tag {
    
    return @"Message......";
}

#pragma mark -Segment
- (void)initSegment {
    seg0.selectedSegmentIndex = (int)mainClass.flagEdit;
    seg1.selectedSegmentIndex = (int)mainClass.flagResize;
    seg2.selectedSegmentIndex = (int)mainClass.fotmat;
    seg3.selectedSegmentIndex = (int)mainClass.flagSilent;
}

- (IBAction)segmentAction:(UISegmentedControl*)sender {
    
    NSLog(@"--- sender:%d",sender.tag);
    
    BOOL flag =  (BOOL)sender.selectedSegmentIndex;
    
    if (sender.tag == 0) {
        // Edit
        mainClass.flagEdit = flag;
        NSLog(@"--- flag:%d",(BOOL)mainClass.flagEdit);
    }
    if (sender.tag == 1) {
        // Resise
        mainClass.flagResize = flag;
    }
    if (sender.tag == 3) {
        // Format
        mainClass.fotmat = flag;
    }
    if (sender.tag == 3) {
        // Silent
        NSLog(@"--- Silent");
        
        /*
        // Ver1.1にて解放
        sender.selectedSegmentIndex = 1;
        // Alert
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"---"
                                                       message:@"次のバージョン"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK", nil];
        [alert show];
        */
    }

    [mainClass.checker saveUserData];
    
}
#pragma mark - TextField
- (void)editingBegin:(UITextField*)tf {
    
    NSLog(@"--- editingBegin:%d",tf.tag);
    
    
    tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    // ScaleArr同期
    valuesArr = [NSMutableArray arrayWithArray:mainClass.valuesArr];
    //valuesArr = main.valuesArr;
    
    NSLog(@"--- Values:%@",valuesArr);
    
    NSNumber *num = [valuesArr objectAtIndex:tf.tag];
    
    tf.text = nil;
    tf.placeholder = [FMT:@"%.0f",num.floatValue];
    
    adView.hidden   = YES;
    iconView.hidden = YES;
    
    NSLog(@"--- tf setted");
}

- (void)editingChanged:(UITextField*)tf {
    //NSLog(@"--- editingChanged:%d",tf.tag);
    
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField*)tf {
    
    NSLog(@"--- tag:%d",tf.tag);
    
    NSLog(@"--- %@, %f",valuesArr, mainClass.maxY);
    
    NSString *sizeStr = tf.text;
    float val = sizeStr.floatValue;
    float preVal = [[valuesArr objectAtIndex:tf.tag]floatValue];
    
    if (![self checkNumber:val]) {
        tf.text = [FMT:@"%.0f",preVal];
        return NO;
    }
    
    if (tf.tag == 0) {
        if ([[valuesArr objectAtIndex:1]floatValue] < val) {
            tf.text = [FMT:@"%.0f",preVal];
            return NO;
        }
    }
    if (tf.tag == 1) {
        if (val < [[valuesArr objectAtIndex:0]floatValue] &&
            [[valuesArr objectAtIndex:2]floatValue] <= val) {
            tf.text = [FMT:@"%.0f",preVal];
            return NO;
        }
    }
    if (tf.tag == 2) {
        if (val < [[valuesArr objectAtIndex:1]floatValue] &&
            [[valuesArr objectAtIndex:3]floatValue] < val) {
            tf.text = [FMT:@"%.0f",preVal];
            return NO;
        }
    }
    if (tf.tag == 3) {
        
        if (mainClass.maxY < val) {
            tf.text = [FMT:@"%.0f",preVal];
            return NO;
        }
    }
    
    
    
    
    // Replace
    [valuesArr replaceObjectAtIndex:tf.tag
                         withObject:[NSNumber numberWithFloat:val]];
    
    mainClass.valuesArr = nil;
    mainClass.valuesArr = valuesArr;
    
    // Save
    [Data changeScaleArr:valuesArr];
    
    // Hidden Keyboard
    [tf resignFirstResponder];
    
    adView.hidden   = NO;
    iconView.hidden = NO;
    
    return YES;
}

/*
 // 被るのでコメント
 - (BOOL)textFieldShouldBeginEditing:(UITextField*)tf {
 tf.text = nil;
 NSLog(@"--- TF->textFieldShouldBeginEditing");
 return YES;
 }
 */

#pragma mark -
- (void)showTextError:(int)type {
    
    // Alert
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:@"値が不正です"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL)checkNumber:(float)val {
    
    
    if (val <= 0.0f) { // 入力しない時
        [self showTextError:0]; // Error
        return NO;
    }
    
    int length = [FMT:@"%d",(int)val].length;
    
    
    NSLog(@"--- length:%d",length);
    
    if (4 < length) { // 入力オーバー
        return NO;
    }
    
    NSString *num = [FMT:@"%d",(int)val];
    
    for (int i = 0; i < length; i++) {
        
        // 一文字取得
        NSString *checkStr = [num substringWithRange:NSMakeRange(i, 1)];
        
        NSLog(@"--- Num:%@",checkStr);
        
        BOOL res = NO;
        
        // Check Number
        for(int p = 0; p < 10; p++) {
            
            res = [checkStr isEqualToString:[FMT:@"%d",p]];
            
            if (res) { break; }
        }
        
        if (!res) { // 数値以外検出
            NSLog(@"--- NG Str");
            return NO;
        }
    }
    
    return YES;
}

//----------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 105.0f;
    }
    if (indexPath.row == 2) {
        return 90.0f;
    }
    else {
        return 50.0f;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    //cell.textLabel.text = infoArr[indexPath.row];
    
    if (indexPath.row == 0) {
        cell = cell0;
    }
    if (indexPath.row == 1) {
        cell = cell1;
    }
    if (indexPath.row == 2) {
        cell = cell4;
    }
    if (indexPath.row == 3) {
        cell = cell2;
    }
    if (indexPath.row == 4) {
        cell = cell3;
    }
    
    
    
    return cell;
}

@end
