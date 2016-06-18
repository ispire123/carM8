//
//  carSelectCellTableViewCell.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 4/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carSelectCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carMake;
@property (weak, nonatomic) IBOutlet UILabel *carModel;
@property (weak, nonatomic) IBOutlet UILabel *carRego;
@property (weak, nonatomic) IBOutlet UILabel *carYear;
@property (weak, nonatomic) IBOutlet UILabel *carSelected;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *service;
@end
