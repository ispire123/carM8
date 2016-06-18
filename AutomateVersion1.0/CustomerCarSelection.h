//
//  CustomerCarSelection.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 9/02/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerCarSelection : UITableViewController <UITableViewDataSource, UITableViewDataSource>
{
    NSArray *cellDetails;
    
}
@property (strong, nonatomic) IBOutlet UITableView *carListTableView;
- (IBAction)next:(id)sender;

@property NSString *carSelectedForService;

- (IBAction)back:(id)sender;


@end
