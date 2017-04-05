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

@property (strong, nonatomic) NSArray *attributes;
@property (assign, nonatomic) CGFloat heightOfContentView;

@end

@implementation CustomVerticalLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSLog(@"prepareLayout");
    
    // layoutAttributesForElementsInRect에서 array정보를 구할 경우
    // 함수가 호출될 때마다 계산이 이루어짐
    // prepareLayout은 처음 한번 호출된 후 invalidateLayout을 호출해야
    // 재 호출됨으로 이때 초기에 필요한 정보들을 계산해 주는 것이 좋음
    self.attributes = [self makeAttributes];
    
    self.heightOfContentView = [self calculateHeightOfContentView];
    
}

- (CGSize)collectionViewContentSize
{
    // 셀을 그릴 수 있는 영역을 지정
    // 처음 셋팅할 때 먼저 계산해서 값을 넣어주는게 좋음
    CGSize result = CGSizeZero;
    
    result =  CGSizeMake(DEVICE_WIDTH, self.heightOfContentView);
    
    return result;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"layoutAttributesForElementsInRect");
    
    return self.attributes;
}


- (NSArray *)makeAttributes
{
    NSMutableArray *result = [NSMutableArray array];
    
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
                
            }
            else if (index == COLUMN_COUNT - 1)
            {
                cellFrame = CGRectMake(originX, originY, CELL_WIDTH, CELL_HEIGHT);
                
                originX = CELL_MARGIN;
                originY += (CELL_WIDTH + CELL_MARGIN);
                
            }
            
            NSLog(@"originX : %f, originY : %f", originX, originY);
            
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            attr.frame = cellFrame;
            
            [result addObject:attr];
        }
    }
    
    return result;
}

- (CGFloat)calculateHeightOfContentView
{
    CGFloat result = 0.0f;
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger rowCount = cellCount / COLUMN_COUNT + (((cellCount % COLUMN_COUNT)!=0)?1:0);
    
    CGFloat contentHeight = rowCount * CELL_HEIGHT + ( rowCount + 1 ) * CELL_MARGIN;
    
    NSLog(@"contentHeight : %f", contentHeight);
    
    result = contentHeight;
    
    return result;
}

@end
