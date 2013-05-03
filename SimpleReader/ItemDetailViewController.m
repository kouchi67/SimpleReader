//
//  ItemDetailViewController.m
//  SimpleReader
//
//  Created by 河内 浩貴 on 13/05/03.
//  Copyright (c) 2013年 niyaty. All rights reserved.
//

#import "ItemDetailViewController.h"

@implementation ItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _webView.delegate = self;
    NSURL *url = [[NSURL alloc] initWithString:_link];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", [error description]);
}


@end
