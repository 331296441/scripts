```mermaid
gantt
    dateFormat  YYYY-MM-DD

    title Adding GANTT diagram functionality to mermaid

    section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    Active task               :active,  des2, 2014-01-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2               :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2014-01-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :1d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h
```

Marmaid支持使用gantt图表语法绘制甘特图。下面是marmaid gantt图的详细语法和示例:
### 语法
| 语法 | 描述 | 示例 |
| :-: | :-: | :-: |
| dateFormat | 设置日期格式 | dateFormat YYYY-MM-DD |
| title | gantt图标题 | title 项目进度 |
| section | 任务分组 | section 阶段一<br>section 阶段二|
| :active, :done, :crit, | 任务状态 |:active, des1,开始日期, 持续时间<br>:done, des2,开始日期, 持续时间  |
| after | 任务依赖关系 | des3, after des2,持续时间|
### 示例
``` mermaid 
gantt
    dateFormat  YYYY-MM-DD
    title 软件开发甘特图

    section 设计
    需求分析        :active, des1, 2020-01-06, 3d
    用例设计         :after des1, 3d
    数据库设计     :after des2, 3d

    section 开发
    后台开发         :active, des3, after des2, 3d
    前端开发         :after des3, 3d

    section 测试
    功能测试           :after des4, 3d
    性能测试            :after des5, 3d

    section 发布
    编译发布              :after des6, 2d
    上线发布              :after des7, 1d
```