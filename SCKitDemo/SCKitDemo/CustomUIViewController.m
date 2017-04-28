//
//  CustomUIViewController.m
//  SCKitDemo
//
//  Created by ShannonChen on 17/4/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CustomUIViewController.h"
#import "SCMacro.h"

static NSString * const kCellInfoTitleKey = @"kCellInfoTitleKey";
static NSString * const kCellInfoTargetControllerKey = @"kCellInfoTargetControllerKey";
static NSString * const kCellInfoHidesBottomBarKey = @"kCellInfoHidesBottomBarKey";


@interface CustomUIViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray <NSDictionary *> *cellInfoArray;

@end


#pragma mark - Lifecycle
@implementation CustomUIViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.cellInfoArray = @[@{kCellInfoTitleKey : @"CutomButton",
                                 kCellInfoTargetControllerKey : @"CustomButtonViewController",
                                 kCellInfoHidesBottomBarKey : @(YES)}];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:tableView];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
/// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// row count for each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellInfoArray.count;
}

/// cell configuration
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseIdentifier = @"<#cellIdentifier#>";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    SCWarningIndexOutOfArrayBounds(indexPath.row, self.cellInfoArray, cell);
    cell.textLabel.text = self.cellInfoArray[indexPath.row][kCellInfoTitleKey];
    
    return cell;
}

/// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

/// cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SCWarningIndexOutOfArrayBounds(indexPath.row, self.cellInfoArray);
    NSDictionary *cellInfo = self.cellInfoArray[indexPath.row];
    NSString *className = cellInfo[kCellInfoTargetControllerKey];
    BOOL hidesBottomBarWhenPushed = [cellInfo[kCellInfoHidesBottomBarKey] boolValue];
    
    if (className && NSClassFromString(className)) {
        UIViewController *controller = [NSClassFromString(className) new];
        controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
