//
//  ServiceViewController.h
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end
