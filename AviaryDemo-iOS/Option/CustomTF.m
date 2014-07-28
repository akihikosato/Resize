//
//  CustomTF.m
//  PhotoEditor
//
//  Created by Akihiko Sato on 2014/07/21.
//  Copyright (c) 2014年 Aviary. All rights reserved.
//

#import "CustomTF.h"

@implementation CustomTF
@synthesize valuesArr;

- (id)init:(AFSDKDemoViewController*)mainClass
 infoClass:(InfoViewController*)infoClass
       tag:(int)tag
{
    self = [super init];
    if (self) {
   
        main = mainClass;
        info = infoClass;
        
        self.frame  = CGRectMake(0, 0, 50, 30);
        self.tag = tag;
        //self.delegate = self;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor darkTextColor];
        //self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.text = [FMT:@"%.0f", [[main.valuesArr objectAtIndex:self.tag]floatValue]];
        
        [[self layer] setBorderWidth:1.0f];
        [self.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
        self.layer.cornerRadius = 7;
        self.clipsToBounds = YES;
        
  
        [self addTarget:info
                   action:@selector(editingBegin:)
         forControlEvents:UIControlEventEditingDidBegin];
        
        [self addTarget:info
                   action:@selector(editingChanged:)
         forControlEvents:UIControlEventEditingChanged];
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    self.center = CGPointMake(40 + 80*self.tag, 65);
}

/*
#pragma mark - TextField
- (void)editingBegin:(UITextField*)tf {
    
    NSLog(@"--- editingBegin:%d",tf.tag);
    
    
    tf.keyboardType = UIKeyboardTypeASCIICapable;
    
    // ScaleArr同期
    valuesArr = [NSMutableArray arrayWithArray:main.valuesArr];
    //valuesArr = main.valuesArr;
    
    NSLog(@"--- Values:%@",valuesArr);
    
    NSNumber *num = [valuesArr objectAtIndex:tf.tag];
    
    tf.text = nil;
    tf.placeholder = [FMT:@"%.0f",num.floatValue];
    
    info.adView.hidden   = YES;
    info.iconView.hidden = YES;
    
    NSLog(@"--- tf setted");
}

- (void)editingChanged:(UITextField*)tf {
    //NSLog(@"--- editingChanged:%d",tf.tag);
    
    
}


#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField*)tf {
    
    NSLog(@"--- tag:%d",tf.tag);
    
    NSLog(@"--- %@, %f",valuesArr, main.maxY);
    
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
        
        if (main.maxY < val) {
            tf.text = [FMT:@"%.0f",preVal];
            return NO;
        }
    }

    
    

    // Replace
    [valuesArr replaceObjectAtIndex:tf.tag
                         withObject:[NSNumber numberWithFloat:val]];
    
    main.valuesArr = nil;
    main.valuesArr = valuesArr;
    
    // Save
    [Data changeScaleArr:valuesArr];
    
    // Hidden Keyboard
    [tf resignFirstResponder];
    
    info.adView.hidden   = NO;
    info.iconView.hidden = NO;
    
    return YES;
}


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
*/
@end
