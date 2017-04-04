//
//  ViewController.m
//  CollectionViewLayout
//
//  Created by 김민아 on 2017. 3. 28..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define STANDARD_DEVICE_WIDTH                                       414.0f
#define DEVICE_WIDTH                                                [UIScreen mainScreen].bounds.size.width
#define WRATIO_WIDTH(w)                                             (w/3.0f) / STANDARD_DEVICE_WIDTH * DEVICE_WIDTH
#define CELL_WIDTH                                                  ( DEVICE_WIDTH - (COLUMN_COUNT + 1) * CELL_MARGIN ) / COLUMN_COUNT

#define CELL_MARGIN                                                 5.0f
#define COLUMN_COUNT                                                4

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCell"]  ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger result = 10;
    
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CustomCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    cell.lbIndex.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    CGFloat cellHeight = CELL_WIDTH;
    
    size = CGSizeMake(cellHeight, cellHeight);
    
    return size;
}



@end
