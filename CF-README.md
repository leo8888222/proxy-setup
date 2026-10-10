# Cloudflare Workers 免费代理

## ⚠️ 风险警告
违反 Cloudflare 服务条款，可能导致账号被封。仅供学习研究。

## 部署步骤

1. 注册 Cloudflare 账号：https://dash.cloudflare.com/sign-up（免费）
2. 进入 Workers & Pages → Create → Create Worker
3. 删除默认代码，粘贴 `cf-worker.js` 的内容
4. 点 Deploy
5. 得到地址：`https://xxx.workers.dev`

## 使用

```
https://xxx.workers.dev/?url=https://example.com
```

## 限制
- 免费版每天 10 万次请求
- CPU 时间限制，不适合大流量/视频
- 随时可能被封号
