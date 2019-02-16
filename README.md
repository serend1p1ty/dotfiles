# code-env

这个仓库帮助你在`Linux`环境下迅速搭建起一套编程环境。环境包括：`zsh`，`vim`，`tmux`。

![](https://github.com/ppnman/code-env/blob/master/doc/vim.png)

![](https://github.com/ppnman/code-env/blob/master/doc/zsh.png)

## 1. :pencil:介绍

`zsh`内置5个插件。

| 功能         | 对应的插件            |
| ------------ | --------------------- |
| 快速目录跳转 | `autojump`            |
| 历史命令提示 | `autosuggestions`     |
| 语法高亮     | `syntax-highlighting` |
| 模糊搜索     | `fzf`                 |
| 彩色主题     | `powerlevel9k`        |

`vim`内置14个插件，专为`Python`打造。

| 功能         | 对应的插件       |
| ------------ | ---------------- |
| 代码自动补全 | `jedi-vim`       |
| 语法检错     | `ale`            |
| 目录树       | `nerdtree`       |
| 异步执行代码 | `asyncrun`       |
| 代码规范化   | `vim-autoformat` |
| 增强tab键    | `supertab`       |
| 快速注释     | `nerdcomment`    |
| 查找文件     | `LeaderF`        |
| 彩虹括号     | `rainbow`        |
| 显示缩进线   | `identLine`      |
| 自动补全括号 | `auto-pairs`     |
| 操作成对符号 | `vim-surround`   |
| 状态栏       | `vim-airline`    |
| 深蓝主题     | `iceberg`        |

## 2. :hammer_and_wrench:安装

### 2.1 依赖

安装之前请确保电脑里有以下软件

- `git`
- `curl`

### 2.2 安装

只需要一行命令即可完成`code-env`的基本配置

```
curl -sL https://bit.ly/2WOXNKx > install.sh && bash install.sh
```

:zap:**zsh安装注意事项**：

- `zsh`的安装分为第一部分(安装`zsh`)，第二部分(安装`oh-my-zsh`及其插件)。安装脚本执行的时候会询问你执行第几部分的安装。第一次运行安装脚本，请执行第一部分的安装。第一部分安装完之后，电脑会重启。重启之后再次执行命令`bash install.sh`，此次选择第二部分的安装。
- 安装完成之后需要运行`source ~/.zshrc`加载配置。

:zap:**vim安装注意事项**：

**语法检错**和**代码规范化**是可选功能，如想使用还需要安装一些依赖包。

- 安装`pip3`，在终端运行`sudo apt install python3-pip`
- 在vim的**命令行模式**下运行`:call InstallRequirements()`

## 3. :sos:帮助

如果遇到无法解决的问题，请提出[Issue](https://github.com/ppnman/code-env/issues)。
