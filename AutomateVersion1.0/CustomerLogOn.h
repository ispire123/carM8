//
//  CustomerLogOn.h
//  AutomateVersion1.0
//
//  Created by iSpire Solution 1 on 22/01/2016.
//  Copyright © 2016 Ispire Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerLogOn : UIViewController


- (IBAction)customerSignUpAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backAction:(id)sender;

@end
