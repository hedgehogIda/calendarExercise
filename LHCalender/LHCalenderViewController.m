//
//  LHCalenderViewController.m
//  LHCalender
//
//  Created by 腾实信 on 2017/2/22.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "LHCalenderViewController.h"
#import "LHCalendarTool.h"
#import "LHCalendarModel.h"
#import "LHPlainFlowLayout.h"
#import "LHCollectionViewCell.h"
#import "LHDayDetailModel.h"
#import "LHCollectionHeaderView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LHCalenderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger year;
    NSInteger month;
    NSInteger day;
}
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *dataSourceArray;
@property(nonatomic, strong) NSMutableDictionary *cellIdentifierDic;
@property(nonatomic, strong) NSMutableArray *selectedCellArray;
@property (strong , nonatomic) NSIndexPath * m_lastAccessed;

@end

@implementation LHCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Ida的日历";
    self.view.backgroundColor = [UIColor clearColor];
    //初始化当前日期并将年月日赋值给实例变量
    [self initCurrentdate];
    //数据源获取数据
    [self getData];
    //创建视图
    [self createCalendarView];
}

- (void)initCurrentdate {
    year = [LHCalendarTool year:[NSDate date]];
    month = [LHCalendarTool month:[NSDate date]];
    day = [LHCalendarTool day:[NSDate date]];
    
}

- (void)getData {
    [LHCalendarModel getCalenderDataWithDate:[NSDate date] block:^(NSMutableArray *result) {
        [self.dataSourceArray addObjectsFromArray:result];
        [self.collectionView reloadData];
    }];
}

- (void)createCalendarView {
    LHPlainFlowLayout * layout = [[LHPlainFlowLayout alloc] init];
    layout.naviHeight = 0.0;
    //布局
    //UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //设置item的宽高
    layout.itemSize=CGSizeMake(WIDTH / 7, WIDTH / 7);
    //设置滑动方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置行间距
    layout.minimumLineSpacing=0.0f;
    //每列的最小间距
    layout.minimumInteritemSpacing = 0.0f;
    //四周边距
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[LHCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView"];
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
}

-(void)panGesture:(UIGestureRecognizer*)gestureRecognizer
{
    float pointerX = [gestureRecognizer locationInView:self.collectionView].x;
   
    float pointerY = [gestureRecognizer locationInView:self.collectionView].y;
    for(LHCollectionViewCell* cell1 in self.collectionView.visibleCells) {
        float cellLeftTop = cell1.frame.origin.x;
        float cellRightTop = cellLeftTop + cell1.frame.size.width;
        float cellLeftBottom = cell1.frame.origin.y;
        float cellRightBottom = cellLeftBottom + cell1.frame.size.height;
        if (pointerX >= cellLeftTop && pointerX <= cellRightTop && pointerY >= cellLeftBottom && pointerY <= cellRightBottom) {
            NSIndexPath* touchOver = [self.collectionView indexPathForCell:cell1];
            if (self.m_lastAccessed != touchOver) {
                if ([self.selectedCellArray containsObject:touchOver]) {
                    cell1.backgroundColor = [UIColor whiteColor];
                    [self.selectedCellArray removeObject:touchOver];
                    
                }
                else{
                    [self.selectedCellArray addObject:touchOver];
                    LHCalendarModel *model = self.dataSourceArray[touchOver.section];
                    if (touchOver.row >= model.firstday){
                        cell1.backgroundColor = [UIColor yellowColor];
                    }else{
                        cell1.backgroundColor = [UIColor whiteColor];
                    }
                    
                }
            }
            self.m_lastAccessed = touchOver;
            
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {

        self.collectionView.scrollEnabled = YES;
        self.m_lastAccessed = nil;
    }
    
}

#pragma mark - UICollectionView  datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSourceArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    LHCalendarModel *model = self.dataSourceArray[section];
    return model.dayDetailArray.count + model.firstday;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [_cellIdentifierDic objectForKey:[NSString stringWithFormat:@"%@",indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"LHCalenderCell%@",indexPath];
        [_cellIdentifierDic setValue:identifier forKey:[NSString stringWithFormat:@"%@",indexPath]];
        [self.collectionView registerClass:[LHCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    LHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.dataSourceArray.count) {
        LHCalendarModel *model = self.dataSourceArray[indexPath.section];
        if (indexPath.item >= model.firstday) {
            NSInteger index = indexPath.item - model.firstday;
            LHDayDetailModel * subModel = model.dayDetailArray[index];
            cell.dateL.text = [NSString stringWithFormat:@"%ld",(long)subModel.day];
            cell.priceL.text = [NSString stringWithFormat:@"%@",subModel.price];
            cell.backgroundColor = [UIColor whiteColor];

            if ((model.year == year) && (model.month == month) && (subModel.day == day))  {
    
                cell.dateL.text = [NSString stringWithFormat:@"今天"];
                cell.backgroundColor = [UIColor whiteColor];
                
            }
            
            if ((model.year == year) && (model.month == month) && (subModel.day < day)) {
                cell.backgroundColor = [UIColor whiteColor];
                cell.dateL.textColor = [UIColor lightGrayColor];
                cell.priceL.text = @"";
                cell.userInteractionEnabled = NO;
            }

        }else{
            cell.userInteractionEnabled = NO;
        }
    }
    if ([self.selectedCellArray containsObject:indexPath]) {
        cell.backgroundColor = [UIColor yellowColor];
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH, 80);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LHCollectionHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView" forIndexPath:indexPath];
    LHCalendarModel * model = self.dataSourceArray[indexPath.section];
    
    headerView.dateL.text = [NSString stringWithFormat:@"%ld-%ld",model.year, model.month];
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LHCollectionViewCell *cell = (LHCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    if ([self.selectedCellArray containsObject:indexPath]) {
        cell.backgroundColor = [UIColor whiteColor];
        [self.selectedCellArray removeObject:indexPath];
    }
    else{
        [self.selectedCellArray addObject:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
    }

}
- (NSMutableDictionary *)cellIdentifierDic{
    if (!_cellIdentifierDic) {
        _cellIdentifierDic = [NSMutableDictionary dictionary];
    }
    return _cellIdentifierDic;
}
- (NSMutableArray *)dataSourceArray{

    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}
- (NSMutableArray *)selectedCellArray{
    if (!_selectedCellArray) {
        _selectedCellArray = [NSMutableArray array];
    }
    return _selectedCellArray;
}
@end
