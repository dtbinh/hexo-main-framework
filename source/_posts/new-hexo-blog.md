title: Migrate to Hexo
---
# 博客正式遷移到Hexo  #

## 緣起 ##
- 徘徊于WordPress  迷茫于VPS

- 糾結選哪個blog framework安家 

- 猛然發現平台真的不重要 折騰的心應該focus于內容

- 希望得到舒適恬靜描描畫畫feelings （而不是臃腫擔心的後台admin）

## 目標 ##

 - 簡潔優美的書寫環境
 - 輕鬆快捷的發佈服務端
 - 意外極端情況的應急修復能力
 
<!--more-->

## 擼起褲腿 思路+實現 ##

    本地測試環境 
    (現有)OS:win7 64bit  text編輯器：notepad++
    (即將搭建)
    [git](http://git-scm.com/ ) 
    [node.js npm](https://www.npmjs.org/)
    [hexo 基於node.js靜態博客生成處理工具](http://hexo.io/)

    遠程服務端環境
    支持靜態化html解析的Github Pages
    


    
## 本地 local environment setup ##

1.win平台安裝git [官方地址 下載安裝即可](http://git-scm.com/downloads)
 
2.本地安裝node.js [node-v0.10.27-x64(選合適的版本)](http://nodejs.org/dist/v0.10.27/x64/node-v0.10.27-x64.msi)
 
3.安裝hexo ` $ npm install hexo -g` 非常簡潔

 **至此，本地配置完成，搭好高樓大廈的骨架，要準備充實內容啦~**

## 服務端 remote environment setup ##

4.開通github賬號 [官方註冊](http://github.com)

5.新建repo 以xxxx.github.io命名的repository  **建立pages的重要關鍵**

 至此，可以用https://github.com/xxxx/xxxx.github.io 訪問到新建的repo
    
（換言之確保 git clone https://github.com/xxxx/xxxx.github.io.git 可以正常）

6.打開剛剛的repo主頁，點擊項目的setting(URI直接進入)https://github.com/xxxx/xxxx.github.io/settings 點擊Github Pages自動生成默認的頁面

**至此可以通過xxxx.github.io訪問默認頁面了**（首次生效可能需要10min）
 

**切換回本地操作**

## 0.**利用ssh方式使用git** ##

- 每次輸入賬號密碼簡直反人類

- 利用ssh更安全快捷

- 原理：客戶端生成的public key反饋回服務端得到認證 以後server-client通信就利用key匹配

- 媽媽再也不用擔心我輸入密碼啦~

進入Git Bash命令行 輸入

    git config --global user.email "your@email.com"
    git config --global user.name "yourname"
    
這兩步是設定客戶端的全局名稱和郵件信息（僅僅是標識作用 郵箱用戶名隨便填）

**生成秘鑰**

    ssh-keygen -t rsa -C "your@email.com"
一路按 Enter 確認 最後得到秘鑰
 

    Your identification has been saved in x:\x\.ssh\id_rsa
    Your public key has been saved in x:\x\.ssh\id_rsa.pub
    The key fingerprint is:
    xx:xx:xx:xx:xx:ab:c1:50:10:40:0a:ba:c1:xx:xx:xx 
    
然後,用文本编辑器打开**id_rsa.pub**文件,拷贝其中的内容,将其添加到 [官方Github add ssh key ](https://github.com/settings/ssh)

**這一步目的是讓服務端認識客戶端 進行授權操作repo**。

最後 執行命令

    ssh -T git@github.com

提示已經授權代表成功 告別https密碼登陸啦啦啦 （忽視warning）

## **1.利用hexo初始化博客** ##

本地新建博客主目錄 例如blog

    hexo init <folder>

完成**主程序**初始化 此時blog目錄應該create了很多文件 默認目錄結構

    ├── node_modules
    ├── scaffolds
    ├── scripts
    ├── source
    |   ├── _drafts
    |   └── _posts
    ├── themes
    ├── _config.yml
    └── package.json

根據程序默認配置 生成靜態博客文件
   

    hexo generate

此時，主目錄下多了個子目錄 `public` 裡面就是整個博客的所有的靜態文件。

進行本地預覽調試 啟動本地服務器 默認4000端口
 

    hexo server

現在通過 `https://localhost:40000` 就可以看到剛剛生成的博客了

但這**僅僅**是本地可以訪問 （我們必須把它發佈到服務器 看下文）

## **2.發佈博客到Github Pages服務器** ##
     cd切換回博客的主目錄 前述的blog 
    
**思路**

- 2.1先把遠程的repo clone到本地

- 2.2再刪除**github默認的pages文件**

- 2.3上傳更新我們的新的博客靜態文件

**2.1  先把遠程的repo clone到本地**
 

    git clone git@github.com:xxxx/xxxx.github.io.git

**2.2 再刪除github默認的pages文件**
   
    git rm -rf *
    git commit -m 'delete origin pages files'
    git push origin master

到這裡 已經把原來的pages文件刪除 清空完 可以放新文件上去了

**2.3上傳更新我們的新的博客靜態文件**

hexo原生支持發佈到Github的遠程服務端，因而只需修改全局配置文件`_config.yml` 就可以方便更新Github Pages了

用notepad++打開`_config.yml` 修改

    # Deployment
    ## Docs: http://hexo.io/docs/deployment.html
    deploy:
      type: github
      repo: git@github.com:xxxx/xxxx.github.io.git
      branch: master

更多`_config.yml` 修改 [看官方docs](http://hexo.io/docs/)

最後 執行 `hexo deploy -g` 就成功發佈到Github Pages了

**驗證**

通過能訪問 [xxxx.github.io](http://xxxx.github.io) 即證明成功publish


**恭喜你 到現在終於把基本博客的最基本完成啦~（碼字君好累啊）**

## 3.進階配置 advanced settings ##

**3.1  hexo發佈過程全解析**     

    

**理順過程**

-  1.hexo new 'hello-world' 本地編寫文章

-  2.hexo generate 生成靜態
 
-  3.hexo server 打開本地服務端 http://localhost:4000 調試
 
-  4.hexo deploy 發佈到遠端服務器


**看清原理**（對應上面過程來分析）


- 1.hexo調用node.js生成.md文件 默認路徑`source\_posts\xx.md`

- 2.hexo依據默認配置 生成靜態文件 默認生成在子目錄`public` 內

- 3.hexo利用web服務器開啟本地web服務

- 4.拷貝`public` 到`.deploy` 再執行git命令 讀取`_config.yml` 的deploy參數，`git add .` `git commit -m 'CommitMessage'` `git push origin [branch]` 

**升華小結下**  

1.直接在相應目錄建立文件,再deploy的效果和`hexo new new-post-article`一樣，**eg.在`source\_posts`下直接新建`xx.md`文件等效于`hexo n xx` (新建pages同理)** 
 
2.**手動執行`git add .` `git commit -m 'CommitMessage'` `git push origin [branch]` 等效同理于`hexo deploy`** 
 
故此 以後熟悉后直接變成**兩個步驟**

    hexo new 'new-post-article'
    hexo d -g 

稍等服務端就生效（最長10min）   

hexo常用命令

    hexo n == hexo new
    hexo g == hexo generate
    hexo s == hexo server
    hexo d == hexo deploy

## 3.2 博客站點個性化 sites customization ##

**3.2.1 global settings**

全局設置在博客主目錄下 （前例blog）的`_config.yml` 中
默認配置如下  更多查看[官方docs](http://hexo.io/docs/configuration.html) 挺全面的
主要修改：站點簡介、固定鏈接、默認目錄、主題theme選擇、發佈deploy方式等。

    
    title: Hexo
    subtitle:
    description:
    author: John Doe
    email:
    language:
    url: http://yoursite.com
    root: /
    permalink: :year/:month/:day/:title/
    tag_dir: tags
    archive_dir: archives
    category_dir: categories
    code_dir: downloads/code
    new_post_name: :title.md
    default_layout: post
    auto_spacing: false
    titlecase: false
    filename_case: 0
    render_drafts: false
    post_asset_folder: false
    relative_link: false
    highlight:
      enable: true
      line_number: true
      tab_replace:
    default_category: uncategorized
    category_map:
    tag_map:
    archive: 2
    category: 2
    tag: 2
    port: 4000
    logger: false
    logger_format:
    date_format: MMM D YYYY
    time_format: H:mm:ss
    per_page: 10
    pagination_dir: page
    disqus_shortname:
    theme: light
    exclude_generator:
    deploy:
      type:
  
**3.2.2 主題配色優化 theme customization**

 主目錄下子目錄 `theme` 為主題文件夾所在,而 [官方hexo theme wiki參考](https://github.com/hexojs/hexo/wiki/Themes)  童靴們也可以自己寫add進去
 

- 找到合適的 copy進來就好 git clone也行 whatever u like

- 最後配置 `_config.yml` options中的`theme： 改為新主題名` (注意冒號：後面先加個space空格鍵 不然報錯)



**3.2.3 添加插件 新建頁面**

添加插件

[官方說明不錯](http://hexo.io/docs/plugins.html)  瞄瞄吧 碼字好苦啊~


添加頁面等

    hexo new page 'page-name'


**3.2.4 添加自定義域名**


感謝開源程序與大家無私的精神 終於可以通過 http://xxxx.github.io 訪問您的博客啦~~


however 這個在github.io下的子域名有點長或者不爽的


Github Pages支持用自定義域名  `萬惡的資本主義想得好周到嘛~`


**兩種情況**


**1.有`example.com` 這樣的由頂級域名下的域名**（叫一級域名？who knows）

    

- 到repo目錄下新建 `CNAME` 文件，該文件只有一行，只需填 `example.com` 

- ping dig traceroute xxxx.github.io的ip 找最快最穩定的

- 到DNS服務商修改 `example.com` 的A 記錄指向 剛剛的ip

- drink a cup of coffee and visit http://example.com Enjoy it!


**2.有`abc.example.com` 的子域名**


-  到repo目錄下新建 `CNAME` 文件，該文件只有一行，只需填 `abc.example.com` 
 
-  到DNS服務商修改 `abc.example.com` 的CNAME 記錄指向 `abc.example.com` 
 


[more details!](https://help.github.com/articles/about-custom-domains-for-github-pages-sites)


To be continued (額 手抽筋啦).....

PS:

long time no write something elegantly with pure purpose.
       
有問題歡迎留言哈 輕輕拍就好   LOL

