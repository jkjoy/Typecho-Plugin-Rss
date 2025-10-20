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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .header .description {
            font-size: 1.1em;
            opacity: 0.9;
            margin-bottom: 20px;
        }

        .header .meta {
            font-size: 0.9em;
            opacity: 0.8;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .rss-info {
            background: #f8f9fa;
            padding: 20px 30px;
            border-bottom: 1px solid #e9ecef;
        }

        .rss-info h2 {
            font-size: 1.2em;
            color: #667eea;
            margin-bottom: 10px;
        }

        .rss-info p {
            color: #6c757d;
            line-height: 1.8;
        }

        .rss-url {
            background: white;
            padding: 10px 15px;
            border-radius: 6px;
            border: 2px solid #667eea;
            font-family: monospace;
            font-size: 0.9em;
            margin-top: 10px;
            word-break: break-all;
        }

        .items {
            padding: 30px;
        }

        .item {
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #e9ecef;
        }

        .item:last-child {
            border-bottom: none;
        }

        .item h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .item h3 a {
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }

        .item h3 a:hover {
            color: #667eea;
        }

        .item .meta {
            color: #6c757d;
            font-size: 0.9em;
            margin-bottom: 15px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .item .meta span {
            display: inline-flex;
            align-items: center;
        }

        .item .description {
            color: #495057;
            line-height: 1.8;
        }

        .item .description img {
            max-width: 100%;
            height: auto;
            border-radius: 6px;
            margin: 10px 0;
        }

        .item .read-more {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .item .read-more:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .footer {
            background: #f8f9fa;
            padding: 20px 30px;
            text-align: center;
            color: #6c757d;
            font-size: 0.9em;
        }

        @media (max-width: 600px) {
            body {
                padding: 10px;
            }

            .header {
                padding: 30px 20px;
            }

            .header h1 {
                font-size: 1.8em;
            }

            .items {
                padding: 20px;
            }

            .item h3 {
                font-size: 1.2em;
            }
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
                <span>🕒 更新时间: <xsl:value-of select="/rss/channel/lastBuildDateFormatted"/></span>
            </div>
        </div>

        <div class="rss-info">
            <h2>📡 什么是 RSS？</h2>
            <p>RSS（Really Simple Syndication）是一种内容聚合格式，让您可以通过 RSS 阅读器订阅本站的最新文章。复制下方 URL 到您的 RSS 阅读器中即可订阅：</p>
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
                        <span>📆<xsl:value-of select="pubDateFormatted"/></span>
                        <xsl:if test="dc:creator">
                            <span>🖋️<xsl:value-of select="dc:creator"/></span>
                        </xsl:if>
                    </div>
                    <div class="description">
                        <xsl:value-of select="description" disable-output-escaping="yes"/>
                    </div>
                </div>
            </xsl:for-each>
        </div>

        <div class="footer">
            <p>由 Typecho RSS 插件强力驱动 | <a href="https://typecho.team"><xsl:value-of select="/rss/channel/generator"/></a></p>
        </div>
    </div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
