/**
 * Cloudflare Workers 代理脚本
 * 警告：违反 Cloudflare ToS，可能导致封号，仅供学习
 *
 * 部署：Workers Dashboard -> Create Worker -> 粘贴此代码 -> Deploy
 * 使用：https://<你的worker>.workers.dev/?url=<目标URL>
 */

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    // 健康检查
    if (url.pathname === "/") {
      return new Response("OK", { status: 200 });
    }

    // 获取目标 URL
    let target = url.searchParams.get("url");
    if (!target) {
      return new Response("用法: ?url=https://example.com", { status: 400 });
    }

    try {
      // 转发请求
      const modifiedRequest = new Request(target, {
        method: request.method,
        headers: request.headers,
        body: request.body,
        redirect: "follow",
      });

      const response = await fetch(modifiedRequest);

      // 返回响应，添加 CORS 头
      const modifiedResponse = new Response(response.body, response);
      modifiedResponse.headers.set("Access-Control-Allow-Origin", "*");
      return modifiedResponse;
    } catch (e) {
      return new Response(`代理错误: ${e.message}`, { status: 500 });
    }
  },
};
