//
// Created by 河内 浩貴 on 13/05/03.
// Copyright (c) 2013 niyaty. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>


@interface ItemListViewController : UITableViewController

@property (nonatomic, strong) NSManagedObject *feed;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@interface NSString (FetchRSS)
- (NSString *)stringByStrippingHTML;
@end
