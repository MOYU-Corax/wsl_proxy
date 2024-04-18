### 一键设置wsl及常用软件的代理的小工具

目前实测可对如下工具生效

- apt
- pip
- repo
- git



#### 使用方式

1. 启用 Clash 的允许局域网连接/Allow Lan
2. 设置 Clash 的端口为默认的 `7890`
3. 克隆本仓库
4. 执行 `chmod +x install_wsl_proxy.sh wsl_proxy.sh`
5. 执行 `./install_wsl_proxy.sh`
6. 使用 `wsl_proxy set`启用代理， `wsl_proxy off` 关闭代理

