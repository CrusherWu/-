//
//  KCMainTableViewController.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "FMDBViewController.h"
#import "KCUser.h"
#import "KCStatus.h"
#import "YYFMDBManager.h"

@interface FMDBViewController (){
    NSArray *_status;
    NSMutableArray *_statusCells;
    YYFMDBManager *_db_mamager;
}

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _db_mamager = [YYFMDBManager shareYYFMDBManager];
    [_db_mamager createTable];
    
    [self addUsers];
    [self removeUser];
    [self addStatus];
    
    [self loadStatusData];
}

-(void)addUsers{
    KCUser *user1=[KCUser userWithName:@"Binger" screenName:@"冰儿" profileImageUrl:@"binger.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [_db_mamager addUser:user1];
    KCUser *user2=[KCUser userWithName:@"Xiaona" screenName:@"小娜" profileImageUrl:@"xiaona.jpg" mbtype:@"mbtype.png" city:@"北京"];
     [_db_mamager addUser:user2];
    KCUser *user3=[KCUser userWithName:@"Lily" screenName:@"丽丽" profileImageUrl:@"lily.jpg" mbtype:@"mbtype.png" city:@"北京"];
     [_db_mamager addUser:user3];
    KCUser *user4=[KCUser userWithName:@"Qianmo" screenName:@"阡陌" profileImageUrl:@"qianmo.jpg" mbtype:@"mbtype.png" city:@"北京"];
     [_db_mamager addUser:user4];
    KCUser *user5=[KCUser userWithName:@"Yanyue" screenName:@"炎月" profileImageUrl:@"yanyue.jpg" mbtype:@"mbtype.png" city:@"北京"];
     [_db_mamager addUser:user5];
}

-(void)addStatus{
    KCStatus *status1=[KCStatus statusWithCreateAt:@"9:00" source:@"iPhone 6" text:@"一只雪猴在日本边泡温泉边玩iPhone的照片，获得了\"2014年野生动物摄影师\"大赛特等奖。一起来为猴子配个词" userId:1];
    [_db_mamager addStatus:status1];
    KCStatus *status2=[KCStatus statusWithCreateAt:@"9:00" source:@"iPhone 65" text:@"一只雪猴在日本边泡温泉边玩iPhone的照片，获得了\"2014年野生动物摄影师\"大赛特等奖。一起来为猴子配个词" userId:1];
    [_db_mamager addStatus:status2];
    KCStatus *status3=[KCStatus statusWithCreateAt:@"9:30" source:@"iPhone 556" text:@"【我们送iPhone6了 要求很简单】真心回馈粉丝，小编觉得现在最好的奖品就是iPhone6了。今起到12月31日，关注我们，转发微博，就有机会获iPhone6(奖品可能需要等待)！每月抽一台[鼓掌]。不费事，还是试试吧，万一中了呢" userId:2];
    [_db_mamager addStatus:status3];
    KCStatus *status4=[KCStatus statusWithCreateAt:@"9:45" source:@"iPhone 55556" text:@"重大新闻：蒂姆库克宣布出柜后，ISIS战士怒扔iPhone，沙特神职人员呼吁人们换回iPhone 4。[via Pan-Arabia Enquirer]" userId:3];
    [_db_mamager addStatus:status4];
    KCStatus *status5=[KCStatus statusWithCreateAt:@"10:05" source:@"iPhone 56" text:@"小伙伴们，有谁知道怎么往Iphone4S里倒东西？倒入的东西又该在哪里找？用了Iphone这么长时间，还真的不知道怎么弄！有谁知道啊？谢谢！" userId:4];
    [_db_mamager addStatus:status5];
    KCStatus *status6=[KCStatus statusWithCreateAt:@"10:07" source:@"iPhone hfh6" text:@"在音悦台iPhone客户端里发现一个悦单《Infinite 金明洙》，推荐给大家! " userId:1];
    [_db_mamager addStatus:status6];
    KCStatus *status7=[KCStatus statusWithCreateAt:@"11:20" source:@"iPhone fd6" text:@"如果sony吧mp3播放器产品发展下去，不贪图手头节目源的现实利益，就木有苹果的ipod，也就木有iphone。柯达类似的现实利益，不自我革命的案例也是一种巨头的宿命。" userId:2];
    [_db_mamager addStatus:status7];
    KCStatus *status8=[KCStatus statusWithCreateAt:@"13:00" source:@"iPhone gf6" text:@"【iPhone 7 Plus】新买的iPhone 7 Plus ，如何？够酷炫么？" userId:2];
    [_db_mamager addStatus:status8];
    KCStatus *status9=[KCStatus statusWithCreateAt:@"13:24" source:@"iPhone h6" text:@"自拍神器#卡西欧TR500#，tr350S～价格美丽，行货，全国联保～iPhone6 iPhone6Plus卡西欧TR150 TR200 TR350 TR350S全面到货 招收各种代理！[给力]微信：39017366" userId:3];
    [_db_mamager addStatus:status9];
    KCStatus *status10=[KCStatus statusWithCreateAt:@"13:26" source:@"iPhone gg6" text:@"猜到猴哥玩手机时所思所想者，再奖iPhone一部。（奖品由“2014年野生动物摄影师”评委会颁发）" userId:3];
    [_db_mamager addStatus:status10];
}

-(void)removeUser{
    //注意在SQLite中区分大小写
    [_db_mamager removeUserByName:@"Yanyue"];
}


#pragma mark 加载数据
-(void)loadStatusData{
    _statusCells=[[NSMutableArray alloc]init];
    _status=[_db_mamager getAllStatus];
    NSLog(@"%@",[_status lastObject]);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _status.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identtityKey=@"UITableViewCell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identtityKey];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    cell.textLabel.text = _status[indexPath.row][@"source"];
    return cell;
}

@end
