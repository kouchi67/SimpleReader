//
// Created by 河内 浩貴 on 13/05/03.
// Copyright (c) 2013 niyaty. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ItemListViewController.h"
#import "ItemCell.h"
#import "TBXML.h"
#import "TBXML+Dictionary.h"
#import "ItemDetailViewController.h"

@implementation ItemListViewController
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }

    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }

    NSLog(@"%@", [_feed description]);
    if (_feed) {
        NSString *urlString = [_feed valueForKey:@"url"];
        [self setTitle:[_feed valueForKey:@"url"]];

        // load開始
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:req
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   [self arrangeItems:data];
                               }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)arrangeItems:(NSData *)data
{
    NSError *error = nil;
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:data error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
        return;
    }

    // 取得したXMLをパースする
    NSDictionary *rootElement = [TBXML dictionaryWithElement:tbxml.rootXMLElement];
    NSLog(@"%@", rootElement);

    NSDictionary *rss = [rootElement valueForKey:@"rss"];
    NSDictionary *channel = [rss valueForKey:@"channel"];
    NSArray *array = [channel valueForKey:@"item"];

    // itemまで分解したらArrayに格納する
    for (NSDictionary *item in array) {
        [_items addObject:item];
    }

    // UI操作はmainスレッドで行う
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.tableView reloadData];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    if ([identifier isEqualToString:@"showItemDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *item = [_items objectAtIndex:indexPath.row];
        NSString *title = [item valueForKey:@"title"];
        NSString *link = [item valueForKey:@"link"];

        // 詳細画面のURLをセットする
        ItemDetailViewController *viewController = [segue destinationViewController];
        [viewController setTitle:title];
        [viewController setLink:link];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = [_items count];
    if (_feed == nil) {
        count = 1;
    }

    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    NSDictionary *item = [_items objectAtIndex:indexPath.row];

    NSString *title = [item valueForKey:@"title"];
    cell.titleLabel.text = title;

    NSString *description = [item valueForKey:@"description"];
    cell.descriptionLabel.text = [description stringByStrippingHTML];

    return cell;
}

@end

@implementation NSString (FetchRSS)

- (NSString *) stringByStrippingHTML
{
    NSRange range;
    NSString *string = [self copy];
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    }
    return string;
}

@end