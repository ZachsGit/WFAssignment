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
#import "ScheduleViewController.h"

@interface ViewController (){
    
    NSMutableArray *savedReservationArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    savedReservationArray = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:101.0/255.0 green:180.0/255.0 blue:233.0/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.navigationController.title = @"MY RESERVATIONS";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus"]style:UIBarButtonItemStylePlain target:self action:@selector(plusButtonClicked:)];
    
    savedReservationArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedReservation"] mutableCopy];

    if (savedReservationArray.count == 0) {//Initally no reservation made
        
        NSMutableArray *savedArray = [[NSMutableArray alloc]init];
        NSDictionary *dictionary = @{@"Date":@"Monday, March 26, 2016", @"Time":@"02:00 PM", @"PartySize": @(1), @"Title":@"Gel Manicure", @"Duration": @"30M", @"Description":@"Get the upper hand with our chip-resistant, mirror-finish gel polish that requires no drying time and last up to two weeks."};
        [savedArray addObject:dictionary];
        
        savedReservationArray = savedArray;
        
        [[NSUserDefaults standardUserDefaults] setObject:savedArray forKey:@"savedReservation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.theCollectionView.delegate = self;
    self.theCollectionView.dataSource = self;
    [self.theCollectionView registerNib:[UINib nibWithNibName:@"ReservationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReservationCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reserveButtonCliked) name:@"ReserveButtonCliked" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"MY RESERVATIONS";
}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return savedReservationArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ReservationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReservationCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = [savedReservationArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = [dictionary objectForKey:@"Date"];
    cell.timeLabel.text = [dictionary objectForKey:@"Time"];
    cell.titleLabel.text = [dictionary objectForKey:@"Title"];
    cell.sizeLabel.text = [NSString stringWithFormat:@"PARTY SIZE - %tu",[[dictionary objectForKey:@"PartySize"]integerValue]];
    cell.durantionLabel.text = [dictionary objectForKey:@"Duration"];
    cell.descriptionLabel.text = [dictionary objectForKey:@"Description"];

    cell.cancelButton.tag = indexPath.row;
    [cell.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UICollectionView Flowlayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    float width = screenSize.width - 20;
    
    return CGSizeMake(width, 200);
}

-(void)plusButtonClicked:(id)sender{
    
    if (savedReservationArray.count < 10) {
        
        ServiceViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceView"];
        self.navigationController.navigationBar.topItem.title = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)reserveButtonCliked{
    
    savedReservationArray = [[NSMutableArray alloc]init];
    
    savedReservationArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedReservation"] mutableCopy];
    [self.theCollectionView reloadData];
}

-(void)cancelButtonClicked:(id)sender{
    
    UIButton *cancelBtn = (id)sender;
    
    if (cancelBtn.tag != 0) {
        
        [savedReservationArray removeObjectAtIndex:cancelBtn.tag];
        [self.theCollectionView reloadData];
        
        [[NSUserDefaults standardUserDefaults] setObject:savedReservationArray forKey:@"savedReservation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
