# docker-lnmp
### lnmp
```html
目录介绍：
.
├── conf                                # 配置文件目录，用于在docker-compose.yml 文件中挂载配置文件
│   ├── mysql
│   ├── nginx
│   ├── php-fpm
│   └── redis
├── docker-compose.yml                  # docker-compose 模板文件
├── Dockerfile                          # Dockerfile 文件 用以创建 php-fpm 及安装常用扩展
├── data                                # 数据存放目录，用于在docker-compose.yml 文件中挂载数据存储目录
│   ├── mysql
│   └── redis
├── log                                 # 日志文件目录，用于在docker-compose.yml 文件中挂载配置文件
│   ├── mysql
│   └── nginx
└── www                               	# 应用站点存放目录

windowns下请勿挂载mysql数据目录

clone文件到本地，确认已安装docker docker-compose，执行docker-compose up (后台运行请加 -d)

```
