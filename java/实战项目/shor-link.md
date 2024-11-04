## 1.快速开始



### 后端

引入 redis的 ip + port ，username & password

引入 mysql ip + port, username & password

引入 nacos, 它是注册和发现中心，所以我们要找到它，**而且要让别的项目发现我们（用项目name）**

so  要导入 nacos的 IP & port & 声明自己的项目Name



### 前端

我不说



### 目录结构

![175949eb-5caa-4000-9fca-cbad5e63953e](../../../../Documents/Tencent Files/2560899500/FileRecv/MobileFile/175949eb-5caa-4000-9fca-cbad5e63953e.png)

dto 就是 data transfer object 和 前端交互的

do 就是 data object 和 数据库交互的



## 2.用户管理



### 布隆过滤

引入，它是 依赖redis的，so应该先引入 redis的maven

它是用redission的，也要引入redission

#### maven依赖

![image-20240924150521539](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924150521539.png)



### 代码导入

![image-20240924150647916](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924150647916.png)



### 具体使用

![image-20240924150913595](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924150913595.png)

![image-20240924151037257](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924151037257.png)

![image-20240924151159078](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924151159078.png)





### MybatisPlus



### 数据脱敏

![image-20240924151757072](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924151757072.png)

![image-20240924152313583](../../../../AppData/Roaming/Typora/typora-user-images/image-20240924152313583.png)





## 学到了what



### **分库分表**

分表：如果表的数据太大了（B+Tree, 多了一层，就都慢了）

分库：连接太多（连接池的连接是一定的）



#### 分片键的选择

应该是，不变的

比如说 username，if 它善变就不要它，否则会有超多的麻烦

而且，应该是容易得到了

if select时没有这个字段，应该用goto表

goto表，就是用你一定用到的字段和 分片键 映射。先找到分片键在进行其他操作





### 数据库

#### 逻辑删除

删除时不能真正的删除（数据都是有用的），可以用delflag来标记 or 可以将删除的数据 存在别的表（防止表太大）



### 冗余数据

数据库为什么 有 聚集索引（存 主键 & 数据），二级索引 （存索引 & 主键，会导致回表，主键可以看成指针）

so，为什么二级索引不也存 数据呢

1. 冗余
2. if 该数据，那所有的数据都要改，非常麻烦，而且还要保证一致性

而且告诉我们，索引不应 容易变动（主键更是不能变动，因为它变动，二级索引存的主键也要变）

主键应该是递增插入的
why 防止页分裂啊

mysql B+Tree, 它是一个磁盘块存一个节点，如果一个节点满了，还要插入，就要页分裂了，很麻烦的

主键 （递增 & 不改变）

