//
//  ScheduleViewController.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "ScheduleViewController.h"
#import "InfomationTableViewCell.h"
#import "MonthTableViewCell.h"
#import "TimeTableViewCell.h"

@interface ScheduleViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MonthCellDelegate, TimeCellDelegate>{
    
    InfomationTableViewCell *infoCell;
    MonthTableViewCell *monthCell;
    TimeTableViewCell *timeCell;
    
    UIPickerView *pickerView;
    UIView *viewOfPicker;
    
    NSString *selectedDateString;
    NSString *selectedTimeString;
    NSInteger partySize;
}

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.theTableView.delegate = self;
    self.theTableView.dataSource = self;
    
    partySize = 1;
    
    self.reserveButton.userInteractionEnabled = NO;
    self.reserveButton.alpha = 0.5;
    
    self.navigationItem.title = @"SCHEDULE";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], }];
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        infoCell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];
        
        [infoCell.sizeButton addTarget:self action:@selector(sizeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        return infoCell;
    }else if (indexPath.row == 1){
        
        monthCell = [tableView dequeueReusableCellWithIdentifier:@"MonthCell"];
        monthCell.delegate = self;
        
        return monthCell;
    }else{
        
        timeCell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        timeCell.delegate = self;
        
        return timeCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 180;
    }else if (indexPath.row == 1){
        return 135;
    }
    return 140;
}

#pragma mark - UIPickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 12;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%tu",row+1];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //infoCell.sizeButton.titleLabel.text = [NSString stringWithFormat:@"%tu",row];
    [infoCell.sizeButton setTitle:[NSString stringWithFormat:@"%tu",row+1] forState:UIControlStateNormal];
    partySize = row + 1;
}

#pragma mark - Button Clicked and Tapped
-(void)sizeButtonTapped:(id)sender{
    
    viewOfPicker = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 240, self.view.frame.size.width, 240)];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked:)];
    cancelButton.tintColor = [UIColor lightGrayColor];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    
    pickerView = [[UIPickerView alloc]init] ;
    pickerView.frame = CGRectMake(0, 40, self.view.frame.size.width, 200);
    pickerView.backgroundColor = [UIColor whiteColor];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    
    [viewOfPicker addSubview:pickerView];
    [viewOfPicker addSubview:toolBar];
    
    [self.view addSubview:viewOfPicker];
}

-(void)cancelClicked:(id)sender{
    
    [infoCell.sizeButton setTitle:[NSString stringWithFormat:@"%tu",1] forState:UIControlStateNormal];
    [viewOfPicker removeFromSuperview];
}

-(void)doneClicked:(id)sender{
    
    [viewOfPicker removeFromSuperview];
}

- (IBAction)reserveButtonAction:(id)sender {
    
    NSMutableArray *savedArray = [[NSMutableArray alloc]init];
    savedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedReservation"] mutableCopy];
        
    NSDictionary *dictionary = @{@"Date": selectedDateString, @"Time": selectedTimeString, @"PartySize": @(partySize), @"Title": @"Hot Stone Massage", @"Duration": @"1H", @"Description":@"Massage focus on the deepest layer of muscle to target knots and release chronic muscle tension."};
    [savedArray addObject:dictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:savedArray forKey:@"savedReservation"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReserveButtonCliked" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - MonthCell Delegate
-(void)monthCellSelectedWithDateString:(NSString *)dateString{
    selectedDateString = dateString;
    
    if (selectedTimeString.length > 0 && selectedDateString.length > 0) {
        
        self.reserveButton.userInteractionEnabled = YES;
        self.reserveButton.alpha = 1;
        
    }else{
        self.reserveButton.userInteractionEnabled = NO;
        self.reserveButton.alpha = 0.5;
    }
}

#pragma mark - TimeCellDelegate
-(void)timeCellSelectedWithTimeString:(NSString *)timeString{
    
    selectedTimeString = timeString;
    
    if (selectedTimeString.length > 0 && selectedDateString.length > 0) {
        
        self.reserveButton.userInteractionEnabled = YES;
        self.reserveButton.alpha = 1;
        
    }else{
        self.reserveButton.userInteractionEnabled = NO;
        self.reserveButton.alpha = 0.5;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
