<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:dc="http://purl.org/dc/elements/1.1/">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html lang="zh-CN">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title><xsl:value-of select="/rss/channel/title"/> - RSS Feed</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            line-height: 1.7;
            color: #e0e0e0;
            background: #0d1117;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #161b22;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            border: 1px solid #30363d;
        }

        .header {
            background: linear-gradient(135deg, #1f6feb 0%, #1158c7 100%);
            color: white;
            padding: 50px 40px;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at top right, rgba(255,255,255,0.1) 0%, transparent 60%);
            pointer-events: none;
        }

        .header h1 {
            font-size: 2.6em;
            margin-bottom: 12px;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .header .description {
            font-size: 1.15em;
            opacity: 0.95;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .header .meta {
            font-size: 0.9em;
            opacity: 0.85;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            position: relative;
            z-index: 1;
        }

        .meta span {
            background: rgba(255, 255, 255, 0.15);
            padding: 6px 14px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }

        .rss-info {
            background: #0d1117;
            padding: 30px 40px;
            border-bottom: 1px solid #30363d;
        }

        .rss-info h2 {
            font-size: 1.3em;
            color: #58a6ff;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .rss-info p {
            color: #8b949e;
            line-height: 1.8;
            margin-bottom: 12px;
        }

        .rss-url {
            background: #161b22;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #30363d;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            word-break: break-all;
            margin-top: 15px;
            color: #58a6ff;
        }

        .items {
            padding: 30px 40px;
        }

        .item {
            margin-bottom: 40px;
            padding-bottom: 40px;
            border-bottom: 1px solid #21262d;
        }

        .item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .item h3 {
            font-size: 1.6em;
            margin-bottom: 12px;
            font-weight: 600;
            line-height: 1.3;
        }

        .item h3 a {
            color: #e0e0e0;
            text-decoration: none;
            transition: color 0.3s;
        }

        .item h3 a:hover {
            color: #58a6ff;
        }

        .item .meta {
            color: #8b949e;
            font-size: 0.9em;
            margin-bottom: 18px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .item .meta span::before {
            content: "•";
            margin-right: 8px;
            color: #58a6ff;
        }

        .item .description {
            color: #c9d1d9;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .item .description p {
            margin-bottom: 15px;
        }

        .item .description img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 15px 0;
            border: 1px solid #30363d;
        }

        .item .description a {
            color: #58a6ff;
            text-decoration: none;
        }

        .item .description a:hover {
            text-decoration: underline;
        }

        .item .read-more {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #21262d;
            color: #58a6ff;
            text-decoration: none;
            border-radius: 6px;
            border: 1px solid #30363d;
            font-weight: 500;
            transition: all 0.3s;
        }

        .item .read-more:hover {
            background: #30363d;
            border-color: #58a6ff;
        }

        .item .read-more::after {
            content: "→";
            font-size: 1.2em;
        }

        .footer {
            background: #0d1117;
            padding: 25px 40px;
            text-align: center;
            color: #8b949e;
            font-size: 0.9em;
            border-top: 1px solid #30363d;
        }

        @media (max-width: 600px) {
            body {
                padding: 10px;
            }

            .header {
                padding: 35px 25px;
            }

            .header h1 {
                font-size: 2em;
            }

            .rss-info, .items {
                padding: 20px 25px;
            }

            .item h3 {
                font-size: 1.3em;
            }

            .footer {
                padding: 20px 25px;
            }
        }

        /* 自定义滚动条 */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: #0d1117;
        }

        ::-webkit-scrollbar-thumb {
            background: #30363d;
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #484f58;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><xsl:value-of select="/rss/channel/title"/></h1>
            <div class="description">
                <xsl:value-of select="/rss/channel/description"/>
            </div>
            <div class="meta">
                <span>🌐 <xsl:value-of select="/rss/channel/link"/></span>
                <span>🕒 <xsl:value-of select="/rss/channel/lastBuildDateFormatted"/></span>
            </div>
        </div>

        <div class="rss-info">
            <h2>📡 RSS 订阅</h2>
            <p>使用 RSS 阅读器订阅本站，及时获取最新文章更新，无需频繁访问网站。</p>
            <p>复制下方地址到您的 RSS 阅读器（推荐使用深色主题阅读器如 NetNewsWire）：</p>
            <div class="rss-url">
                <xsl:value-of select="/rss/channel/atom:link/@href"/>
            </div>
        </div>

        <div class="items">
            <xsl:for-each select="/rss/channel/item">
                <div class="item">
                    <h3>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="link"/>
                            </xsl:attribute>
                            <xsl:value-of select="title"/>
                        </a>
                    </h3>
                    <div class="meta">
                        <span><xsl:value-of select="pubDateFormatted"/></span>
                        <xsl:if test="dc:creator">
                            <span><xsl:value-of select="dc:creator"/></span>
                        </xsl:if>
                    </div>
                    <div class="description">
                        <xsl:value-of select="description" disable-output-escaping="yes"/>
                    </div>
                </div>
            </xsl:for-each>
        </div>

        <div class="footer">
            <p><a href="https://typecho.team" target="_blank"><xsl:value-of select="/rss/channel/generator"/></a> | 深色主题优化</p>
        </div>
    </div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
