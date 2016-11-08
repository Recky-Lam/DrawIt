//
//  DIHomeViewController.m
//  DrawIt
//
//  Created by ReckyLin on 2016/10/24.
//  Copyright © 2016年 ywl-ios1. All rights reserved.
//

#import "DIHomeViewController.h"
#import "DIDrawViewController.h"
#import "DIPaintCollectionViewCell.h"

@interface DIHomeViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *paintsDataSource;

@property (nonatomic, strong) UICollectionView *elementsCollectionView;

@end

@implementation DIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Draw It" backButton:NO];
        
    [self.contentView setBackgroundColor:WhiteColor];
    
    self.paintsDataSource = [NSMutableArray arrayWithArray:[DICacheManager getPaintCache]];
    
    [self buildElements];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCollectionView) name:SavedImageNotifacation object:nil];
}

- (void)buildElements
{

    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    
    self.elementsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height - kBottomBarHeight) collectionViewLayout:flowLayout];
    [self.elementsCollectionView setDelegate:self];
    [self.elementsCollectionView setDataSource:self];
    [self.elementsCollectionView setBackgroundColor:RGB(241, 241, 241, 1)];
    
    [self.elementsCollectionView registerClass:[DIPaintCollectionViewCell class] forCellWithReuseIdentifier:paintCellIdentifier];
    
    [self.contentView addSubview:self.elementsCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.paintsDataSource count] + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/5, kScreenWidth/5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DIPaintInfoModel *paint = [[DIPaintInfoModel alloc] init];
    
    if ([self.paintsDataSource count] > 0) {
        if (indexPath.row == self.paintsDataSource.count) {
            paint.thumbImage = Image(@"paint_add");
        }
        else {
            paint = self.paintsDataSource[indexPath.row];
        }
    }
    else {
        paint.thumbImage = Image(@"paint_add");
    }
    
    DIPaintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:paintCellIdentifier forIndexPath:indexPath];
    [cell configCellDataWithData:paint Indexpath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.paintsDataSource count] > 0) {
        if (indexPath.row == self.paintsDataSource.count) {
            [self presentController:[[DIDrawViewController alloc] init]];
        }
        else
        {
            
        }
    }
    else {
        [self presentController:[[DIDrawViewController alloc] init]];
    }
}

- (void)refreshCollectionView
{
    self.paintsDataSource = [NSMutableArray arrayWithArray:[DICacheManager getPaintCache]];

    [self.elementsCollectionView reloadData];
}

@end
