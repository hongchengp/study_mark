# 面向字节流

socket fd;

fd.write(buf) -> int 

它会return 将buf写入socket缓冲区的字节数，不一定会将buf中的字节全部写入

同样的还有read，而且write后，也不一定会直接发送

它不是不是完整的发送的，而是以字节为单位发送的

UDP它是以报文为单位发送的（通过报文头，明确消息边界）



# 可靠传输

滑动窗口 + 超时重传 + 三次握手 + 四次挥手 

**感觉超时重传是可靠传输的关键**

还有确认机制

如果收到了，会发送它的确认消息



# 三次握手



![image-20240613161705931](../../../AppData/Roaming/Typora/typora-user-images/image-20240613161705931.png)

​	

如果两次挥手的话，如果连接请求发生阻塞后再到达，会让客户端一直处于连接状态，浪费资源

![image-20240613161951966](../../../AppData/Roaming/Typora/typora-user-images/image-20240613161951966.png)





# 四次挥手



## 正常流程

![image-20240613162124130](../../../AppData/Roaming/Typora/typora-user-images/image-20240613162124130.png)





![image-20240613162041586](../../../AppData/Roaming/Typora/typora-user-images/image-20240613162041586.png)



## 保活计时器

![image-20240613162227743](../../../AppData/Roaming/Typora/typora-user-images/image-20240613162227743.png)





# 流量控制

![image-20240613162314203](../../../AppData/Roaming/Typora/typora-user-images/image-20240613162314203.png)

如果零窗口了，就启动零窗口计时器，防止接收方调整窗口后，消息丢失让发送窗口一直是零



# 拥塞控制

![image-20240613162550368](../../../AppData/Roaming/Typora/typora-user-images/image-20240613162550368.png)



## 快重传

如果有三次重复确认，就直接重传消息

防止超时重传，发生慢开始

