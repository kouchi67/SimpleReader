//
//  ItemDetailViewController.h
//  SimpleReader
//
//  Created by 河内 浩貴 on 13/05/03.
//  Copyright (c) 2013年 niyaty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy) NSString *link;

@end
