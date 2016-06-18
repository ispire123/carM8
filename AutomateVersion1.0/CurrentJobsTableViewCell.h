//
//  CurrentJobsTableViewCell.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 13/04/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentJobsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *car;
@property (strong, nonatomic) IBOutlet UITextView *location;
@property (strong, nonatomic) IBOutlet UILabel *product;
@property (weak, nonatomic) IBOutlet UIProgressView *serviceProgress;
@property (weak, nonatomic) IBOutlet UIButton *serviceCancelButton;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *status1;
@property (strong, nonatomic) IBOutlet UILabel *status2;

@end
