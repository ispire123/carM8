//
//  CustomerDashboard.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerDashboard : UIViewController
{
    NSMutableArray *currentJobs;
    NSString *serviceid;
    NSString *carid;
}
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UITableView *cusTableView;

@end
