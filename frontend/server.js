const express = require("express");
const path = require("path");
const { createProxyMiddleware } = require("http-proxy-middleware");

const app = express();

const PORT = process.env.PORT || 3000;
const BACKEND_URL = process.env.BACKEND_URL;

const backendProxy = createProxyMiddleware({
  target: BACKEND_URL,
  changeOrigin: true
});

app.use((req, res, next) => {
  if (
    req.path === "/tasks" ||
    req.path.startsWith("/tasks/") ||
    req.path === "/files" ||
    req.path.startsWith("/files/")
  ) {
    return backendProxy(req, res, next);
  }

  next();
});

app.use(express.static(path.join(__dirname, "public")));

app.get("/config", (req, res) => {
  res.json({
    taskApiUrl: "",
    fileApiUrl: ""
  });
});

app.listen(PORT, () => {
  console.log(`TaskHub frontend running on port ${PORT}`);
});