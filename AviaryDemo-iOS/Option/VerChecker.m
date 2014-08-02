//
//  VerChecker.m
//  Request_Test
//
//  Created by a.sato on 2014/07/18.
//  Copyright (c) 2014年 a.sato. All rights reserved.
//

#import "VerChecker.h"

#define DATA @"USER_DATA"
#define FMT NSString stringWithFormat

@implementation VerChecker

- (id)init:(AFSDKDemoViewController*)mainClass {
    
    if (self = [super init]) {
        
        NSLog(@"=== Ver Checker ===");
        
        // MainView
        main = mainClass;
        
        [self checkMyVersion:mainClass];
        
        /*// Notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveUserData)
                                                     name:@"SAVE" object:nil];
        */
    }
    
    return self;
}

- (void)checkMyVersion:(AFSDKDemoViewController*)mainClass {
    
    /*// Base View
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = mainClass.view.center;
    view.backgroundColor = WAITVIEW_COL;
    view.layer.cornerRadius = 7;
    view.clipsToBounds = YES;
    [mainClass.view addSubview:view];
    
    // UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.numberOfLines = 2;
    label.text = @"checking\nnow version...";
    label.alpha = 0.8f;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:13];
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(mainClass.view.center.x, mainClass.view.center.y + 30);
    [mainClass.view addSubview:label];
    
    // Indicator
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, 0, 50, 50);
    indicator.center = CGPointMake(mainClass.view.center.x, mainClass.view.center.y - 10);
    [mainClass.view addSubview:indicator];
    [indicator startAnimating];
    */

    
    NSURL *url = [NSURL URLWithString:JSON_URL];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               
                               if (!error) {
                                   
                                   mainClass.view.backgroundColor = [UIColor cyanColor];
                                   
                                   NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   //NSLog(@"--- %@",jsonDictionary);
                                   
                                   NSArray *array = [jsonDictionary objectForKey:@"シート1"];
                                   
                                   NSMutableArray *imageList = [[NSMutableArray alloc] init];
                                   for (NSDictionary *obj in array)
                                   {
                                       [imageList addObject:[obj objectForKey:@"Version"]];
                                   }
                                   
                                   //------------------------------------------------------------
                                   // Check Version
                                   NSString *deviceVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                                   float myVer = deviceVer.floatValue;
                                   
                                   NSString *str = [imageList objectAtIndex:0];
                                   float nowVer  = str.floatValue;
                                   
                                   //NSLog(@"--- nowVer%.1f, myVer%.1f",nowVer, myVer);
                                   
                                   if (myVer != nowVer) {
                                       [self showAlert:YES];
                                   } else {
                                       NSLog(@"--- 最新バーション");
                                   }
                                   //------------------------------------------------------------
                                   
                               }
                               else { // Error
                                   NSLog(@"--- Error");
                                   
                                   mainClass.view.backgroundColor = [UIColor redColor];
                                   
                                   [self showAlert:NO];
                               }
                               /*// Hidden View
                               [UIView beginAnimations:nil context:nil];
                               [UIView setAnimationDuration:0.1f];
                               view.alpha = 0.0f;
                               indicator.alpha = 0.0f;
                               label.alpha = 0.0f;
                               [UIView commitAnimations];
                               */
                           }];
}

- (void)showAlert:(BOOL)flagVerUp {
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = NSLocalizedString(@"title", nil);
    alert.message = NSLocalizedString(@"new_ver", nil);
    [alert addButtonWithTitle:@"OK"];
    
    if (!flagVerUp) {
        // 圏外
        alert.title = NSLocalizedString(@"error", nil);
        alert.message = NSLocalizedString(@"no_res", nil);
        alert.tag = 1;
    }
    
    // iPod系は外す？？
    
    [alert show];
    
}

# pragma mark - Alert View Delegate
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 0) {
        // App Store
        NSURL *url = [NSURL URLWithString:NSLocalizedString(@"open_url", nil)];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        
    }
}

# pragma mark - User Data
- (NSDictionary*)userDataDic {
    return nil;
}

- (void)loadUserData {
    
    NSDictionary *dic;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *valArr;
    
    
    if ([ud objectForKey:DATA]) {
        
        dic = [ud objectForKey:DATA];
        valArr = [ud objectForKey:SCALES];
        
        NSLog(@"--- dic:%@ arr:%@",dic, valArr);
        
    } else {
        
        NSLog(@"--- None Data");
        
        
        // Create Data
        NSArray *arr = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:320],
                        [NSNumber numberWithFloat:640],
                        [NSNumber numberWithFloat:960],
                        [NSNumber numberWithFloat:1280],
                        nil];
        
        valArr = [NSMutableArray arrayWithArray:arr];
        
        dic = [NSDictionary dictionaryWithObjectsAndKeys:
               @"0",   @"EDIT_MODE",
               @"0",   @"RESIZE_MODE",
               @"0",   @"FORMAT",
               @"1",   @"SILENT_MODE",
               //arr,    @"VALUES",
               @"2000", @"LAST_VAL",
               nil];
         
        
        main.valuesArr = [NSMutableArray arrayWithArray:valArr];
        
        // Save
        [ud setObject:arr forKey:SCALES];
        [ud setObject:dic forKey:DATA];
        
    }
    
    ////////////////////////////////////////
    // Set User Data
    ////////////////////////////////////////
    
    
    //Set Main Paras
    NSString *val;
    
    val = [dic objectForKey:@"EDIT_MODE"];
    main.flagEdit = val.boolValue;
    
    val = [dic objectForKey:@"RESIZE_MODE"];
    main.flagResize = val.boolValue;
    
    val = [dic objectForKey:@"FORMAT"];
    main.format = val.boolValue;
    
    val = [dic objectForKey:@"SILENT_MODE"];
    main.flagSilent = val.boolValue;
    
    val = [dic objectForKey:@"LAST_VAL"];
    main.lastVal = val.floatValue;
    
    // Set Btn Size Vale
    main.valuesArr = [NSMutableArray arrayWithArray:valArr];
    [main setScaleBtnVal];
    //NSLog(@"%@",main.valuesArr);

}

- (void)saveUserData {
    
    NSLog(@"--- Saved...");
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [FMT:@"%d",(int)main.flagEdit],     @"EDIT_MODE",
                         [FMT:@"%d",(int)main.flagResize],   @"RESIZE_MODE",
                         [FMT:@"%d",(int)main.format],       @"FORMAT",
                         [FMT:@"%d",(int)main.flagSilent],   @"SILENT_MODE",
                         main.valuesArr,                     @"VALUES",
                         [FMT:@"%f",main.lastVal],           @"LAST_VAL",
                         nil];
    // Save
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:DATA];
}


@end
