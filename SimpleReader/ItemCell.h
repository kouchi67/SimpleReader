//
//  ItemCell.h
//  SimpleReader
//
//  Created by 河内 浩貴 on 13/05/03.
//  Copyright (c) 2013年 niyaty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
