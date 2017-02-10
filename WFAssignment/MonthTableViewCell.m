//
//  MonthTableViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "MonthTableViewCell.h"
#import "DateCollectionViewCell.h"

@implementation MonthTableViewCell{
    
    NSRange daysRange;
    NSMutableArray *weekdaysArray;
    NSDictionary *selectedIndexDict;
    NSString *monthString;
    NSString *yearString;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    weekdaysArray = [[NSMutableArray alloc]init];
    [self getWeekdaysArray];
    
    _theCollectionView.delegate = self;
    _theCollectionView.dataSource = self;
    
    [_theCollectionView registerNib:[UINib nibWithNibName:@"DateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DateCell"];
    
    NSDate *today = [NSDate date];
    NSCalendar *currentCal = [NSCalendar currentCalendar];
    
    daysRange = [currentCal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:today];
    
    NSDateComponents *components = [currentCal components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear  fromDate:today];//Get current calender info

    monthString = [self getCurrentMonthWith:[components month]];
    self.monthLabel.text = monthString;
    yearString = [NSString stringWithFormat:@"%tu",[components year]];
    
    //Get First Day of Month
    [components setDay:1];
    NSDate *firstDay = [currentCal dateFromComponents:components];
    NSDateComponents *newComp = [currentCal components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:firstDay];//Get current calender info
    NSInteger firstweekday = [newComp weekday];
    
    if (firstweekday > 1) {
        [weekdaysArray removeObjectsInRange:NSMakeRange(0, firstweekday - 1)];
    }
    
}

-(NSString *)getCurrentMonthWith:(NSInteger)month{
    
    switch (month){
            
        case 1:
            return @"JANUARY";
        case 2:
            return @"FEBRUARY";
        case 3:
            return @"MARCH";
        case 4:
            return @"APRIL";
        case 5:
            return @"MAY";
        case 6:
            return @"JUNE";
        case 7:
            return @"JULY";
        case 8:
            return @"AUGUST";
        case 9:
            return @"SEPTEMBER";
        case 10:
            return @"OCTOBER";
        case 11:
            return @"NOVEMBER";
        case 12:
            return @"DECEMBER";
        default:
            return @"Month";
    }
}

-(void)getWeekdaysArray{
    
    NSString *weekdayString;
    
    for (int i = 0 ; i < 6 ; i++) {
        
        for ( int j = 1; j <= 7; j++) {
            
            weekdayString = [self getWeekdayWith:j];
            [weekdaysArray addObject:weekdayString];
        }
    }
    
}

-(NSString *)getWeekdayWith:(int)weekday{
    
    switch (weekday){
            
        case 1:
            return @"SUNDAY";
        case 2:
            return @"MONDAY";
        case 3:
            return @"TUESDAY";
        case 4:
            return @"WEDNESDAY";
        case 5:
            return @"THURSDAY";
        case 6:
            return @"FRIDAY";
        case 7:
            return @"SATURDAY";

        default:
            return @"WEEKDAY";
    }
    
}

- (IBAction)calenderButtonAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"] options:@{} completionHandler:^(BOOL success) {
        
    }];

}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return daysRange.length;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCell" forIndexPath:indexPath];
    
    NSString *dayString = [NSString stringWithFormat:@"%02ld",indexPath.row + 1];
    cell.dateLabel.text = dayString;
    
    NSString *weekdayString = [weekdaysArray objectAtIndex:indexPath.row];
    cell.weekLabel.text = [weekdayString substringToIndex:3];
    
    if ([[selectedIndexDict objectForKey:@(indexPath.row)]boolValue]) {
        
        cell.checkmarkImageView.hidden = NO;
        cell.selectView.hidden = NO;
    }else{
        cell.checkmarkImageView.hidden = YES;
        cell.selectView.hidden = YES;
    }
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _dateString = nil;
    
    if ([[selectedIndexDict objectForKey:@(indexPath.row)]boolValue]) {//Unselect
        
        selectedIndexDict = @{@(indexPath.row) : @(NO)};

    }else{//Select
        selectedIndexDict = @{@(indexPath.row) : @(YES)};
        
        NSString *weekDayString = [[weekdaysArray objectAtIndex:indexPath.row] lowercaseString];
        NSString *capitalisedWeekday = [weekDayString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[weekDayString substringToIndex:1] capitalizedString]];

        monthString = [monthString lowercaseString];
        NSString *capitalisedMonth = [monthString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[monthString substringToIndex:1] capitalizedString]];

        NSString *dayString = [NSString stringWithFormat:@"%02ld",indexPath.row + 1];

        _dateString = [NSString stringWithFormat:@"%@, %@ %@, %@", capitalisedWeekday, capitalisedMonth, dayString, yearString];
    }

    [self.delegate monthCellSelectedWithDateString:_dateString];

    [self.theCollectionView reloadData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
