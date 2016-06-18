//
//  customerCarListViewController.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 2/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerCarListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *carList;
    NSArray *cellDetails;
}

@property (strong, nonatomic) IBOutlet UITableView *tablecarList;
- (IBAction)backButton:(id)sender;

@end
