//
//  cancelService.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 19/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cancelService : UITableViewController
{
    NSMutableArray *canceljobList;
    NSString *serviceid;
    NSString *carid;
    NSString *objectId;
    NSString *carRego;
    NSString *date;
    NSString *time;
    NSString *location;
    NSString *productChoosen;
    NSString *payableAmount;
    NSString *status;
}
@property (strong, nonatomic) IBOutlet UITableView *canceljobTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
- (IBAction)cancelService:(id)sender;

@end
