//
//  DetailViewController.h
//  SimpleReader
//
//  Created by Hiroki Kouchi on 13/05/03.
//  Copyright (c) 2013年 niyaty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
