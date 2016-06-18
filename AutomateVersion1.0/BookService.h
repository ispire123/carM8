//
//  BookService.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 26/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookService : UITableViewController <UITableViewDataSource, UITableViewDataSource>
{
       NSArray *customerCars;
       NSArray *cellDetails;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *optionView;




        
@end
