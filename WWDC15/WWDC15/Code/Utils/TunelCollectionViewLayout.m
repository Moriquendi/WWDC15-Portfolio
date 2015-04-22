//
//  TunelCollectionViewLayout.m
//  WWDC15
//
//  Created by Michal Smialko on 22/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

#import "TunelCollectionViewLayout.h"

@interface TunelCollectionViewLayout ()
@property(nonatomic, readonly) CGSize itemSize;
@property(nonatomic, strong) NSIndexPath *indexPathForCenteredItem;
@end

@implementation TunelCollectionViewLayout

- (CGSize)itemSize
{
    return self.collectionView.bounds.size;
}

- (void)prepareLayout
{
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.itemSize.width, self.itemSize.height * numberOfItems);
}

#pragma mark - Attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger j = 0; j < numberOfItems; j++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:0];
        [layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [[[self class] layoutAttributesClass] layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect bounds = CGRectZero;
    bounds.size = self.itemSize;
    attributes.bounds = bounds;
    
    CGFloat x = self.collectionView.bounds.size.width / 2;
    
    CGFloat yOffset = self.collectionView.contentOffset.y;
    NSInteger item = indexPath.item;
    
    BOOL stayInOnePlace = NO;
    CGFloat y = stayInOnePlace ?
                        self.collectionView.frame.size.height / 2 + yOffset :
                        self.collectionView.bounds.size.height / 2 + self.collectionView.bounds.size.height * item;
    
    attributes.center = CGPointMake(x, y);
    
    CGFloat distanceFromCenter = y - self.collectionView.bounds.size.height/2.f - yOffset;
    CGFloat normalizedDistance = distanceFromCenter / self.collectionView.bounds.size.height;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    CGFloat translate = 240 * normalizedDistance;
    
    if (translate < 0) {
        attributes.center = CGPointMake(attributes.center.x,
                                        attributes.center.y - distanceFromCenter*0.9);
        attributes.alpha = MAX(0, 1 + normalizedDistance);
    }
    
    attributes.transform3D = CATransform3DTranslate(rotationAndPerspectiveTransform,
                                                    0,
                                                    0,
                                                    MIN(0, translate));
    
    return attributes;
}

#pragma mark - Target Content Offset

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity
{
    CGPoint targetContentOffset = proposedContentOffset;
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = [self layoutAttributesForUserFingerMovingWithVelocity:velocity
                                  proposedContentOffset:proposedContentOffset];
    
    if (layoutAttributesForItemToCenterOn) {
        targetContentOffset.x = 0;
        targetContentOffset.y = layoutAttributesForItemToCenterOn.center.y - self.collectionView.bounds.size.height / 2;
        self.indexPathForCenteredItem = layoutAttributesForItemToCenterOn.indexPath;
    }
    
    return targetContentOffset;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:self.indexPathForCenteredItem];
    CGPoint targetContentOffset = proposedContentOffset;
    
    if (attributes) {
        targetContentOffset.x = 0;
        targetContentOffset.y = attributes.center.y - self.collectionView.bounds.size.height;
    }
    
    return targetContentOffset;
}

#pragma mark - Helpers

- (UICollectionViewLayoutAttributes *)layoutAttributesForUserFingerMovingWithVelocity:(CGPoint)velocity
                                                                proposedContentOffset:(CGPoint)offset
{
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = nil;
    CGRect nextVisibleBounds = [self collectionView].bounds;
    nextVisibleBounds.origin = offset;
    NSArray *layoutAttributesInRect = [self layoutAttributesForElementsInRect:nextVisibleBounds];
    
    if (velocity.y > 0.0f) {
        layoutAttributesForItemToCenterOn = [layoutAttributesInRect lastObject];
    }
    else if (velocity.y < 0.0f) {
        layoutAttributesForItemToCenterOn = [layoutAttributesInRect firstObject];
    }
    else {
        CGFloat distanceToCenter = CGFLOAT_MAX;
        
        for (UICollectionViewLayoutAttributes *attributes in layoutAttributesInRect) {
            CGFloat midOfFrame = CGRectGetMidY(self.collectionView.frame);
            CGFloat center = self.collectionView.contentOffset.y + midOfFrame;
            
            CGFloat distance = ABS(center - attributes.center.y);
            
            if (distance < distanceToCenter) {
                distanceToCenter = distance;
                layoutAttributesForItemToCenterOn = attributes;
            }
        }
    }
    
    return layoutAttributesForItemToCenterOn;
}

#pragma mark - Invalidating Layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
