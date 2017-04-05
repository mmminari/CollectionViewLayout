//
//  CustomVerticalLayout.m
//  CollectionViewLayout
//
//  Created by 김민아 on 2017. 4. 4..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "CustomVerticalLayout.h"

#define DEVICE_WIDTH                                                    [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT                                                   [UIScreen mainScreen].bounds.size.height

#define CELL_WIDTH                                                      ( DEVICE_WIDTH - (COLUMN_COUNT + 1) * CELL_MARGIN ) / COLUMN_COUNT
#define CELL_HEIGHT                                                     CELL_WIDTH

#define CELL_MARGIN                                                     5.0f
#define COLUMN_COUNT                                                    4

@interface CustomVerticalLayout ()

@property (assign, nonatomic) CGFloat contentHeight;

@end

@implementation CustomVerticalLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
}

- (CGSize)collectionViewContentSize
{
    //셀을 그릴 수 있는 영역을 지정
    CGSize result = CGSizeMake(DEVICE_WIDTH, self.contentHeight);
    
    return result;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* elementsInRect = [NSMutableArray array];
    
    for(NSInteger i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        CGFloat originX = CELL_MARGIN;
        CGFloat originY = CELL_MARGIN;

        for(NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
        {
            // 각 셀의 UICollectionViewLayoutAttributes에 위치할 frame 값을 계산해 넣어줌
            // 셀이 그려질 contentview의 높이도 같이 계산해줌
            CGRect cellFrame = CGRectZero;
            
            NSInteger index = j % COLUMN_COUNT;
            
            NSLog(@"j : %zd, index : %zd", j, index);
            
            if(index != COLUMN_COUNT - 1)
            {
                cellFrame = CGRectMake(originX, originY, CELL_WIDTH, CELL_HEIGHT);
                
                originX += (CELL_WIDTH + CELL_MARGIN);
                
                self.contentHeight = originY + CELL_WIDTH + CELL_MARGIN;
            }
            else if (index == COLUMN_COUNT - 1)
            {
                cellFrame = CGRectMake(originX, originY, CELL_WIDTH, CELL_HEIGHT);
                
                originX = CELL_MARGIN;
                originY += (CELL_WIDTH + CELL_MARGIN);
                
                self.contentHeight = originY;
            }
            
            NSLog(@"originX : %f, originY : %f", originX, originY);

            if(CGRectIntersectsRect(cellFrame, rect))
            {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
                attr.frame = cellFrame;
                
                [elementsInRect addObject:attr];
            }
        }
    }
    
    return elementsInRect;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *result = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    return result;
//    
//}

@end
