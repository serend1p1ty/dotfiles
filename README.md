# dotfiles

## 1. :pencil:介绍

这个仓库帮助你在`Linux`环境下迅速搭建起一套开发环境。

环境包括：`zsh`，`vim`，`tmux`。

`vim`的配置文件同时兼容`Windows`，但是不提供自动安装脚本。

## 2. :hammer_and_wrench:安装

### 2.1 依赖

安装之前请确保电脑里有以下软件

- `git`
- `curl`
- `pip3`

### 2.2 安装

只需要一行命令即可完成配置

```
curl -sL https://bit.ly/2WOXNKx > install.sh && bash install.sh
```

:zap:**zsh安装注意事项**：

- `zsh`的安装分为第一部分(安装`zsh`)，第二部分(安装`oh-my-zsh`及其插件)。安装脚本执行的时候会询问你执行第几部分的安装。第一次运行安装脚本，请执行第一部分的安装。第一部分安装完之后，电脑会重启。重启之后再次执行命令`bash install.sh`，此次选择第二部分的安装。
- 安装完成之后需要运行`source ~/.zshrc`加载配置。

## 3. :sos:帮助

如果遇到无法解决的问题，请提出[Issue](https://github.com/ppnman/code-env/issues)。
