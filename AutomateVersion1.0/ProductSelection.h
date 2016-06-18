//
//  ProductSelection.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 28/03/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSelection : UITableViewController
{
    NSMutableArray *products;
}
@property (strong, nonatomic) IBOutlet UITableView *productTableView;
@property (retain, nonatomic) NSString *carLocationSelected;
@property (strong, nonatomic) IBOutlet UITextView *productInfo;
@property (strong, nonatomic) IBOutlet UIButton *enterDetails;

@end
