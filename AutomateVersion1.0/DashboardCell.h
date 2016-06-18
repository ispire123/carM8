//
//  DashboardCell.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 17/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cleanModel;
@property (strong, nonatomic) IBOutlet UILabel *cleanRego;
@property (strong, nonatomic) IBOutlet UILabel *cleanDate;
@property (strong, nonatomic) IBOutlet UILabel *cleanTime;
@property (strong, nonatomic) IBOutlet UILabel *cleanAddress;
@property (strong, nonatomic) IBOutlet UILabel *cleanStatus;



@end
