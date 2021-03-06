//
//  ServiceViewController.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceTableViewCell.h"
#import "ScheduleViewController.h"

@interface ServiceViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    NSArray *imagesArray;
    NSArray *labelsArray;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], }];
    self.navigationItem.title = @"SPA SERVICE";
    
    self.theTableView.delegate = self;
    self.theTableView.dataSource = self;
    
    self.reserveButton.layer.cornerRadius = 5;
    self.reserveButton.layer.masksToBounds = YES;
    
    self.theTableView.layer.cornerRadius = 10;
    self.theTableView.layer.masksToBounds = YES;

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    [self.imageScrollView setContentSize:CGSizeMake(3 * screenSize.width, screenSize.height - 64)];
    [self.imageScrollView setPagingEnabled:YES];
    [self.imageScrollView setDelegate:self];
    [self.imageScrollView setShowsHorizontalScrollIndicator:NO];
    [self.imageScrollView setShowsVerticalScrollIndicator:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    imagesArray = [[NSArray alloc]initWithObjects:@"page1.png",@"page2.png",@"page3.png", nil];
    labelsArray = [[NSArray alloc]initWithObjects:@"Swedish Massage", @"Deep Tissue Massage", @"Hot Stone Massage", @"Reflexology", @"Trigger Point Therapy", nil];

    for (int i = 0; i < imagesArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *  screenSize.width, 0, screenSize.width,  screenSize.height-64)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageView setImage:[UIImage imageNamed:[imagesArray objectAtIndex:i]]];
        [self.imageScrollView addSubview:imageView];
    }
    
    self.pageControl.currentPage = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"SPA SERVICE";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int indexOfPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage =(int) indexOfPage;
}

- (IBAction)reserveButtonClicked:(id)sender {
    
    if (self.pageControl.currentPage == 2) {
        
        ScheduleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleView"];
        self.navigationController.navigationBar.topItem.title = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%@",[labelsArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        
        ScheduleViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleView"];
        self.navigationController.navigationBar.topItem.title = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
