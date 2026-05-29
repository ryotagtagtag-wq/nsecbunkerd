FROM node:20-alpine AS builder
WORKDIR /app

# モノレポ用の管理ツール pnpm をインストール
RUN npm install -g pnpm

# リポジトリの全ファイルをコピー
COPY . .

# 【重要】モノレポ全体の依存関係を強制解決してビルド
RUN pnpm install --no-frozen-lockfile
RUN pnpm run build

# --- 実行用コンテナ ---
FROM node:20-alpine
WORKDIR /app

RUN npm install -g pnpm
COPY --from=builder /app ./

# アプリのポートを開放
EXPOSE 3000

# サーバー起動時に、単体パッケージではなくモノレポ内の「nsecbunkerd」を直接実行
CMD ["pnpm", "--filter", "nsecbunkerd", "start"]
