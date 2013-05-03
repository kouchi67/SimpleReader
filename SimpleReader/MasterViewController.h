//
//  MasterViewController.h
//  SimpleReader
//
//  Created by Hiroki Kouchi on 13/05/03.
//  Copyright (c) 2013年 niyaty. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
