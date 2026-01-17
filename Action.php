<?php
/**
 * RSS Action 处理类
 *
 * @package Rss
 * @author Typecho
 * @version 1.0.0
 */
class Rss_Action extends Typecho_Widget implements Widget_Interface_Do
{
    /**
     * 数据库对象
     * @var Typecho_Db
     */
    private $db;

    /**
     * 插件配置
     * @var mixed
     */
    private $options;

    /**
     * 构造函数
     */
    public function __construct($request, $response, $params = NULL)
    {
        parent::__construct($request, $response, $params);
        $this->db = Typecho_Db::get();
        $this->options = Helper::options()->plugin('Rss');
    }

    /**
     * 输出全文 RSS
     *
     * @access public
     * @return void
     */
    public function feed()
    {
        $this->styledFeed();
    }

    /**
     * 输出带样式的 RSS
     *
     * @access public
     * @return void
     */
    public function styledFeed()
    {
        $config = $this->options;
        $options = Helper::options();

        // 获取文章数量配置
        $feedCount = isset($config->feedCount) && is_numeric($config->feedCount)
            ? intval($config->feedCount)
            : 20;

        // 如果设置为 0，则输出全部文章
        if ($feedCount === 0) {
            $feedCount = 10000; // 设置一个较大的数字
        }

        // 是否输出全文
        $fullContent = isset($config->fullContent) && $config->fullContent == '1';

        // 是否添加样式
        $addStyle = isset($config->addStyle) && $config->addStyle == '1';

        // 获取样式主题
        $styleTheme = isset($config->styleTheme) ? $config->styleTheme : 'gradient';

        // 版权信息
        $copyright = isset($config->copyright) ? $config->copyright : '';

        // 设置 header
        $this->response->setContentType('application/xml; charset=UTF-8');

        // 获取文章
        $posts = $this->db->fetchAll(
            $this->db->select()->from('table.contents')
                ->where('table.contents.status = ?', 'publish')
                ->where('table.contents.type = ?', 'post')
                ->where('table.contents.created <= ?', time())
                ->order('table.contents.created', Typecho_Db::SORT_DESC)
                ->limit($feedCount)
        );

        // 构建 RSS
        echo '<?xml version="1.0" encoding="UTF-8"?>';

        if ($addStyle) {
            echo '<?xml-stylesheet type="text/xsl" href="' . $options->pluginUrl . '/Rss/rss-' . $styleTheme . '.xsl"?>';
        }

        echo "\n";

        $w = date('w');
        $lastBuildDateFormatted = date('Y', time()) . '年' .
                                 date('m', time()) . '月' .
                                 date('d', time()) . '日 ' .
                                 date('H:i', time());
        ?>
<rss version="2.0"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title><?php echo htmlspecialchars($options->title); ?></title>
        <link><?php echo $options->siteUrl; ?></link>
        <atom:link href="<?php echo $options->siteUrl; ?>feed" rel="self" type="application/rss+xml" />
        <description><?php echo htmlspecialchars($options->description); ?></description>
        <language>zh-CN</language>
        <lastBuildDate><?php echo date(DATE_RFC822, time()); ?></lastBuildDate>
        <lastBuildDateFormatted><?php echo $lastBuildDateFormatted; ?></lastBuildDateFormatted>
        <generator>Typecho RSS Plugin</generator>
        <?php foreach ($posts as $post):
            $content = $post['text'];

            // 兼容部分编辑器/输入法：文章开头的标题写成“#标题”（缺少空格）时不会被 Markdown 识别
            $content = preg_replace('/\A\x{FEFF}/u', '', $content);
            $content = preg_replace('/\A([ \t\x{3000}]*)((?:#{1,6}))([^\s#])/u', '$1$2 $3', $content);

            // 解析 Markdown
            if (strpos($post['type'], '_markdown') !== false || $post['type'] == 'post') {
                $content = Markdown::convert($content);
            }

            // 如果不输出全文，则截取摘要
            if (!$fullContent) {
                $content = Typecho_Common::subStr(strip_tags($content), 0, 200, '...');
            }

            // 添加版权信息
            if (!empty($copyright)) {
                $content .= '<hr/>' . $copyright;
            }

            // 获取文章链接
            $routeExists = (NULL != Typecho_Router::get('post'));
            $permalink = $routeExists ? Typecho_Router::url('post',
                array('cid' => $post['cid']), $options->siteUrl)
                : $options->siteUrl . '?p=' . $post['cid'];

            $w = date('w', $post['created']);
            $dateFormatted = date('Y', $post['created']) . '年' .
                           date('m', $post['created']) . '月' .
                           date('d', $post['created']) . '日' .
                           date('H:i', $post['created']);
        ?>
        <item>
            <title><?php echo htmlspecialchars($post['title']); ?></title>
            <link><?php echo $permalink; ?></link>
            <guid isPermaLink="true"><?php echo $permalink; ?></guid>
            <pubDate><?php echo date(DATE_RFC822, $post['created']); ?></pubDate>
            <pubDateFormatted><?php echo $dateFormatted; ?></pubDateFormatted>
            <dc:creator><?php echo htmlspecialchars($options->title); ?></dc:creator>
            <description><![CDATA[<?php echo $content; ?>]]></description>
            <content:encoded><![CDATA[<?php echo $content; ?>]]></content:encoded>
        </item>
        <?php endforeach; ?>
    </channel>
</rss>
        <?php
    }

    /**
     * 执行函数
     *
     * @access public
     * @return void
     */
    public function action()
    {
        $this->on($this->request->is('do=feed'))->feed();
        $this->on($this->request->is('do=styledFeed'))->styledFeed();
    }
}
