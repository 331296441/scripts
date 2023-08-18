以下是使用el-upload组件实现调用axios封装的upload命令上传文件的Vue代码示例：
``` js
<template>
  <el-upload
    class="upload-demo"
    :action="uploadUrl"
    :on-success="handleSuccess"
    :before-upload="beforeUpload"
    :headers="headers"
  >
    <el-button size="small" type="primary">点击上传</el-button>
  </el-upload>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      uploadUrl: 'your_upload_url', // 设置上传文件的后端接口地址
      headers: { // 设置请求头，根据实际需求进行修改
        Authorization: 'Bearer ' + localStorage.getItem('token')
      }
    };
  },
  methods: {
    beforeUpload(file) {
      // 可以在此处添加文件上传前的验证逻辑
      // 返回 false 可取消上传
      console.log('beforeUpload:', file);
    },
    handleSuccess(response) {
      // 文件上传成功后的回调函数
      console.log('handleSuccess:', response);
    }
  }
};
</script>
```
以上代码中，el-upload组件通过action属性指定了上传文件的后端接口地址，on-success属性指定了文件上传成功后的回调函数。
在beforeUpload方法中，你可以添加文件上传前的验证逻辑。例如，你可以检查文件类型、大小等。如果验证不通过，你可以返回false取消上传操作。
在handleSuccess方法中，你可以处理文件上传成功后的回调逻辑。response参数包含了上传成功后的响应数据。
在data中，你需要根据实际情况设置uploadUrl为你的上传文件的后端接口地址，并根据需要设置headers为请求头。请确保在请求头中传递了合适的身份验证信息。
记得安装并引入Vue和Element UI相关的库，以及配置axios库。
