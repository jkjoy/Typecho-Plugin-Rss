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
            line-height: 1.8;
            color: #222;
            background: #fff;
            padding: 40px 20px;
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            border-bottom: 2px solid #000;
            padding-bottom: 30px;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }

        .header .description {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 15px;
        }

        .header .meta {
            font-size: 0.9em;
            color: #999;
        }

        .rss-info {
            background: #f9f9f9;
            border-left: 3px solid #000;
            padding: 20px;
            margin-bottom: 40px;
        }

        .rss-info h2 {
            font-size: 1.1em;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .rss-info p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .rss-url {
            background: #fff;
            padding: 10px;
            border: 1px solid #ddd;
            font-family: 'Courier New', monospace;
            font-size: 0.85em;
            word-break: break-all;
            margin-top: 10px;
        }

        .items {
            list-style: none;
        }

        .item {
            margin-bottom: 50px;
            padding-bottom: 30px;
            border-bottom: 1px solid #e0e0e0;
        }

        .item:last-child {
            border-bottom: none;
        }

        .item h3 {
            font-size: 1.6em;
            margin-bottom: 8px;
            font-weight: 600;
            line-height: 1.3;
        }

        .item h3 a {
            color: #000;
            text-decoration: none;
            transition: color 0.2s;
        }

        .item h3 a:hover {
            color: #666;
        }

        .item .meta {
            color: #999;
            font-size: 0.9em;
            margin-bottom: 15px;
        }

        .item .description {
            color: #444;
            line-height: 1.8;
        }

        .item .description p {
            margin-bottom: 15px;
        }

        .item .description img {
            max-width: 100%;
            height: auto;
            margin: 20px 0;
        }

        .item .read-more {
            display: inline-block;
            margin-top: 15px;
            color: #000;
            text-decoration: none;
            border-bottom: 1px solid #000;
            font-size: 0.95em;
            transition: opacity 0.2s;
        }

        .item .read-more:hover {
            opacity: 0.6;
        }

        .footer {
            margin-top: 60px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            color: #999;
            font-size: 0.85em;
        }

        @media (max-width: 600px) {
            body {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 1.8em;
            }

            .item h3 {
                font-size: 1.3em;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><xsl:value-of select="/rss/channel/title"/></h1>
        <div class="description">
            <xsl:value-of select="/rss/channel/description"/>
        </div>
        <div class="meta">
            <xsl:value-of select="/rss/channel/link"/> · 更新于 <xsl:value-of select="/rss/channel/lastBuildDateFormatted"/>
        </div>
    </div>

    <div class="rss-info">
        <h2>关于 RSS 订阅</h2>
        <p>RSS 是一种内容聚合格式，允许您通过 RSS 阅读器订阅本站的最新文章。</p>
        <p>复制以下地址到您的 RSS 阅读器中：</p>
        <div class="rss-url">
            <xsl:value-of select="/rss/channel/atom:link/@href"/>
        </div>
    </div>

    <ul class="items">
        <xsl:for-each select="/rss/channel/item">
            <li class="item">
                <h3>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="link"/>
                        </xsl:attribute>
                        <xsl:value-of select="title"/>
                    </a>
                </h3>
                <div class="meta">
                    <xsl:value-of select="pubDateFormatted"/>
                    <xsl:if test="dc:creator">
                        · <xsl:value-of select="dc:creator"/>
                    </xsl:if>
                </div>
                <div class="description">
                    <xsl:value-of select="description" disable-output-escaping="yes"/>
                </div>
                <a class="read-more">
                    <xsl:attribute name="href">
                        <xsl:value-of select="link"/>
                    </xsl:attribute>
                    继续阅读 →
                </a>
            </li>
        </xsl:for-each>
    </ul>

    <div class="footer">
        <p><xsl:value-of select="/rss/channel/generator"/></p>
    </div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
