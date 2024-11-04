![image-20240417010831419](../../../AppData/Roaming/Typora/typora-user-images/image-20240417010831419.png)



Mapper 接口 extends BaseMapper

Service 接口 extends IService接口

ServiceImp类 实现 Mapper接口 继承ServiceImpl



其实呢 与Mapper层接口很像，感觉可以调用Mapper接口即可，也可以用IService接口，底层还是Mapper接口



```java
@Override
@Transactional
public void deductBalance(Long id, Integer money) {
    // 1.查询用户
    User user = getById(id);
    // 2.校验用户状态
    if (user == null || user.getStatus() == UserStatus.FROZEN) {
        throw new RuntimeException("用户状态异常！");
    }
    // 3.校验余额是否充足
    if (user.getBalance() < money) {
        throw new RuntimeException("用户余额不足！");
    }
    // 4.扣减余额 update tb_user set balance = balance - ?
    int remainBalance = user.getBalance() - money;
    lambdaUpdate()
            .set(User::getBalance, remainBalance)
            .set(remainBalance == 0, User::getStatus, UserStatus.FROZEN) 
        		// 可以 有条件set 比如if name == null set name = 'yyj'
            .eq(User::getId, id)
            .eq(User::getBalance, user.getBalance()) // 乐观锁
            .update();
}
```





```java
@Override
public List<User> queryUsers(String name, Integer status, Integer minBalance, Integer maxBalance) {
    return lambdaQuery()
            .like(name != null, User::getUsername, name) // 这个也是 啊啊啊 好爽
            .eq(status != null, User::getStatus, status)
            .ge(minBalance != null, User::getBalance, minBalance)
            .le(maxBalance != null, User::getBalance, maxBalance)
            .list();
}
```





req 请求入参

resp 返回出参

这两个用 数据库的实体类 来相互转换 BeanUtil.copyToList(addresses, AddressVO.class) 用 BeanUtil转换