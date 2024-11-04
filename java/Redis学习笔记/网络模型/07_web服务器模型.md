![image-20240509161254553](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509161254553.png)





![image-20240509161423267](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509161423267.png)





![image-20240509161619132](../../../../AppData/Roaming/Typora/typora-user-images/image-20240509161619132.png)



1. 当acceptfd可读时，就是有客户端连接，建立连接，加入epfd（监听可读）
2. 当client socket可读时，就是客户端发送命令，处理完后，就可以监听client socket 是否可写（加入epfd 监听可写）
3. client socket可写时，就将数据发送到客户端