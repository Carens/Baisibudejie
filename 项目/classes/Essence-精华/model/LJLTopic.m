//
//  LJLTopic.m
//  项目
//
//  Created by LiJiale on 15/7/29.
//
//

#import "LJLTopic.h"

@implementation LJLTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

//通过运行时转换
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

//重写创建时间的get方法
- (NSString *)create_time
{
    //创建时间格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    //判断帖子创建的时间
    if(create.isThisYear){
        if(create.isThisToday){
            //相隔时间
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];

        if (cmps.hour >= 1) { // 时间差距 >= 1小时
            return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
        } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
            return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
        } else { // 1分钟 > 时间差距
            return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
}

}

- (CGFloat)cellHeight
{
    if(!_cellHeight){
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LJLTopicCellMargin , MAXFLOAT);
        //文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
       
        //文字部分的高度
        _cellHeight = LJLTopicCellTextY + textH + LJLTopicCellMargin;
        
        //根据中间类型计算cell中间部分
        if(self.type == LJLTopicTypePicture){//图片帖子
            
            //图片显示出来的最大的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的最大高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
//            判断是否是大图
            if( pictureH >= LJLTopicCellPictureMaxH ){
                pictureH = LJLTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = LJLTopicCellMargin;
            CGFloat pictureY = LJLTopicCellTextY + textH + LJLTopicCellMargin;

            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            //图片的高度
            _cellHeight += pictureH + LJLTopicCellMargin;
        }else if(self.type == LJLTopicTypeVoice){//声音帖子
            
            CGFloat voiceX = LJLTopicCellMargin;
            CGFloat voiceY = LJLTopicCellTextY + textH + LJLTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + LJLTopicCellMargin;
            
        }else if(self.type == LJLTopicTypeVideo){
            
            CGFloat videoX = LJLTopicCellMargin;
            CGFloat videoY = LJLTopicCellTextY + textH + LJLTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + LJLTopicCellMargin;
            
            
        }
        
        //底部工具条的高度
        _cellHeight += LJLTopicCellBottomBarH + LJLTopicCellMargin;
    }
    return _cellHeight;
}


@end
