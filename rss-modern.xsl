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
            line-height: 1.6;
            color: #1a1a1a;
            background: linear-gradient(to bottom, #f0f4f8 0%, #e9eff5 100%);
            min-height: 100vh;
            padding: 0;
        }

        .header-wrapper {
            background: linear-gradient(135deg, #0066cc 0%, #0052a3 100%);
            color: white;
            padding: 0;
            box-shadow: 0 4px 20px rgba(0, 102, 204, 0.15);
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .header {
            padding: 50px 0;
        }

        .header h1 {
            font-size: 2.8em;
            margin-bottom: 15px;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .header .description {
            font-size: 1.2em;
            opacity: 0.95;
            margin-bottom: 20px;
            font-weight: 300;
        }

        .header .meta {
            font-size: 0.95em;
            opacity: 0.85;
            display: flex;
            gap: 20px;
            align-items: center;
            flex-wrap: wrap;
        }

        .meta-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 12px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }

        .main-content {
            max-width: 1000px;
            margin: -30px auto 0;
            padding: 0 20px 40px;
        }

        .rss-info {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
            border-left: 4px solid #0066cc;
        }

        .rss-info h2 {
            font-size: 1.4em;
            color: #0066cc;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .rss-info p {
            color: #5a5a5a;
            line-height: 1.8;
            margin-bottom: 12px;
        }

        .rss-url {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #e0e6ed;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            word-break: break-all;
            margin-top: 15px;
            color: #0066cc;
        }

        .items {
            display: grid;
            gap: 25px;
        }

        .item {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border-top: 3px solid #0066cc;
        }

        .item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 102, 204, 0.15);
        }

        .item h3 {
            font-size: 1.6em;
            margin-bottom: 12px;
            font-weight: 600;
            line-height: 1.3;
        }

        .item h3 a {
            color: #1a1a1a;
            text-decoration: none;
            transition: color 0.3s;
        }

        .item h3 a:hover {
            color: #0066cc;
        }

        .item .meta {
            color: #888;
            font-size: 0.9em;
            margin-bottom: 18px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .meta-item::before {
            content: "";
            display: inline-block;
            width: 4px;
            height: 4px;
            background: #0066cc;
            border-radius: 50%;
        }

        .item .description {
            color: #444;
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
        }

        .item .read-more {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: #0066cc;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .item .read-more:hover {
            background: #0052a3;
            transform: translateX(3px);
        }

        .item .read-more::after {
            content: "→";
            font-size: 1.2em;
        }

        .footer {
            max-width: 1000px;
            margin: 40px auto 0;
            padding: 30px 20px;
            text-align: center;
            color: #888;
            font-size: 0.9em;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 600px) {
            .header {
                padding: 30px 0;
            }

            .header h1 {
                font-size: 2em;
            }

            .header .description {
                font-size: 1em;
            }

            .rss-info, .item {
                padding: 20px;
            }

            .item h3 {
                font-size: 1.3em;
            }
        }
    </style>
</head>
<body>
    <div class="header-wrapper">
        <div class="container">
            <div class="header">
                <h1><xsl:value-of select="/rss/channel/title"/></h1>
                <div class="description">
                    <xsl:value-of select="/rss/channel/description"/>
                </div>
                <div class="meta">
                    <span class="meta-badge">🌐 <xsl:value-of select="/rss/channel/link"/></span>
                    <span class="meta-badge">🕒 <xsl:value-of select="/rss/channel/lastBuildDateFormatted"/></span>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="rss-info">
            <h2>📡 RSS 订阅说明</h2>
            <p>RSS（Really Simple Syndication）是一种内容聚合格式，让您可以通过专业的 RSS 阅读器订阅本站的最新文章，无需频繁访问网站即可获取更新。</p>
            <p>推荐使用 Feedly、Inoreader、NetNewsWire 等 RSS 阅读器，复制下方地址即可订阅：</p>
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
                        <span class="meta-item"><xsl:value-of select="pubDateFormatted"/></span>
                        <xsl:if test="dc:creator">
                            <span class="meta-item"><xsl:value-of select="dc:creator"/></span>
                        </xsl:if>
                    </div>
                    <div class="description">
                        <xsl:value-of select="description" disable-output-escaping="yes"/>
                    </div>
                    <a class="read-more">
                        <xsl:attribute name="href">
                            <xsl:value-of select="link"/>
                        </xsl:attribute>
                        阅读全文
                    </a>
                </div>
            </xsl:for-each>
        </div>
    </div>

    <div class="footer">
        <p><xsl:value-of select="/rss/channel/generator"/> | 现代化 RSS 订阅体验</p>
    </div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
