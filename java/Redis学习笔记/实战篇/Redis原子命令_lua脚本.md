

![image-20240306125423893](../../../AppData/Roaming/Typora/typora-user-images/image-20240306125423893.png)



![image-20240306125434608](../../../AppData/Roaming/Typora/typora-user-images/image-20240306125434608.png)



lua脚本确保了释放锁的时候,"判断是否是自己的锁" 和 "删除锁" 的两个动作的原子性!