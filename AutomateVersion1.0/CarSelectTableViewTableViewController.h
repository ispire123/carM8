//
//  CarSelectTableViewTableViewController.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 15/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarSelectTableViewTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *cellDetails;
    
}
@property (strong, nonatomic) IBOutlet UITableView *cleaningCarTableView;
- (IBAction)back:(id)sender;

@end
