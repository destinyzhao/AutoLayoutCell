# AutoLayoutCell
动态计算Cell高度

动态计算Cell Demo 一个是用的UITableView+FDTemplateLayoutCell就不多说
另外一个是参考UITableView+FDTemplateLayoutCell 写的一个简单的分类 用起来方便

一行代码就能实现自动计算Cell高度和缓存高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView heightForAutoLayoutCellWithIdentifier:@"TestCell" cacheKey:[NSString stringWithFormat:@"TestCell%ld_%ld",indexPath.section,indexPath.row] configaurtaion:^(id cell) {
        [cell updatecellHeight];
    }];
}
