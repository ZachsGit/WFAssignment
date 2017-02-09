//
//  ViewController.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/8/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "ViewController.h"
#import "ReservationCollectionViewCell.h"
#import "ServiceViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:101.0/255.0 green:180.0/255.0 blue:233.0/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus"]style:UIBarButtonItemStylePlain target:self action:@selector(plusButtonClicked:)];
    
    self.theCollectionView.delegate = self;
    self.theCollectionView.dataSource = self;
    [self.theCollectionView registerNib:[UINib nibWithNibName:@"ReservationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReservationCell"];
    
}


#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ReservationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReservationCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma marks - UICollectionView Flowlayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    float width = screenSize.width - 20;
    
    return CGSizeMake(width, 200);
}

-(void)plusButtonClicked:(id)sender{
    
    ServiceViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceView"];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
