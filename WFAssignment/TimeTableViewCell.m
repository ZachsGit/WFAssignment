//
//  TimeTableViewCell.m
//  WFAssignment
//
//  Created by Zhang Xu on 2/9/17.
//  Copyright © 2017 Zhang Xu. All rights reserved.
//

#import "TimeTableViewCell.h"
#import "TimeCollectionViewCell.h"

@implementation TimeTableViewCell{
    
    NSArray *timeArray;
    NSDictionary *selectedIndexDict;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    timeArray = @[@"09:00 AM", @"10:00 AM", @"11:00 AM", @"12:00 PM", @"01:00 PM", @"02:00 PM", @"03:00 PM", @"04:00 PM", @"05:00 PM", @"06:00 PM", @"07:00 PM", @"08:00 PM"];
    
    _theCollectionView.delegate = self;
    _theCollectionView.dataSource = self;
}

#pragma mark - UICollectionVie DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return timeArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AmpmCell" forIndexPath:indexPath];
    
    cell.timeLabel.text = [timeArray objectAtIndex:indexPath.row];
    
    if ([[selectedIndexDict objectForKey:@(indexPath.row)]boolValue]) {
    
        cell.checkImageView.hidden = NO;
        cell.selectView.hidden = NO;
    
    }else{
        
        cell.checkImageView.hidden = YES;
        cell.selectView.hidden = YES;
    }

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //TimeCollectionViewCell *cell = (TimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedTimeString = nil;
    
    if ([[selectedIndexDict objectForKey:@(indexPath.row)]boolValue]) {//Unselect
        
        selectedIndexDict = @{@(indexPath.row) : @(NO)};
        
    }else{//Select
        
        selectedIndexDict = @{@(indexPath.row) : @(YES)};
        
        self.selectedTimeString = [timeArray objectAtIndex:indexPath.row];        
    }
    
    [self.delegate timeCellSelectedWithTimeString:self.selectedTimeString];
    
    [self.theCollectionView reloadData];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
