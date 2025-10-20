<?php
/**
 * RSS 全文输出美化插件
 *
 * @package RSS Styling
 * @author TypechoTeam
 * @version 1.0.0
 * @link http://www.typecho.team
 */
class Rss_Plugin implements Typecho_Plugin_Interface
{
    /**
     * 激活插件方法,如果激活失败,直接抛出异常
     *
     * @access public
     * @return void
     * @throws Typecho_Plugin_Exception
     */
    public static function activate()
    {
        // 移除 Typecho 原生的 feed 路由
        Helper::removeRoute('feed');

        // 添加自定义路由，接管 /feed
        Helper::addRoute('feed', '/feed', 'Rss_Action', 'styledFeed');
    }

    /**
     * 禁用插件方法,如果禁用失败,直接抛出异常
     *
     * @static
     * @access public
     * @return void
     * @throws Typecho_Plugin_Exception
     */
    public static function deactivate()
    {
        Helper::removeRoute('feed');

        // 恢复 Typecho 原生的 feed 路由
        Helper::addRoute('feed', '/feed', 'Widget_Archive', 'feed');
    }

    /**
     * 获取插件配置面板
     *
     * @access public
     * @param Typecho_Widget_Helper_Form $form 配置面板
     * @return void
     */
    public static function config(Typecho_Widget_Helper_Form $form)
    {
        $feedCount = new Typecho_Widget_Helper_Form_Element_Text(
            'feedCount',
            NULL,
            '20',
            _t('RSS 文章数量'),
            _t('设置 RSS 输出的文章数量，默认为 20 篇，设置为 0 则输出全部文章')
        );
        $form->addInput($feedCount);

        $fullContent = new Typecho_Widget_Helper_Form_Element_Radio(
            'fullContent',
            array(
                '1' => _t('输出全文'),
                '0' => _t('输出摘要')
            ),
            '1',
            _t('RSS 内容输出'),
            _t('选择 RSS 输出全文还是摘要')
        );
        $form->addInput($fullContent);

        $addStyle = new Typecho_Widget_Helper_Form_Element_Radio(
            'addStyle',
            array(
                '1' => _t('启用'),
                '0' => _t('禁用')
            ),
            '1',
            _t('RSS 样式美化'),
            _t('是否在浏览器中美化显示 RSS')
        );
        $form->addInput($addStyle);

        $styleTheme = new Typecho_Widget_Helper_Form_Element_Select(
            'styleTheme',
            array(
                'gradient' => _t('渐变风格 - 紫色渐变，现代感强'),
                'minimal' => _t('简洁风格 - 黑白简约，清爽干净'),
                'modern' => _t('现代风格 - 蓝色系，商务范'),
                'dark' => _t('暗黑风格 - 深色主题，护眼舒适')
            ),
            'gradient',
            _t('样式主题'),
            _t('选择 RSS 在浏览器中的显示风格')
        );
        $form->addInput($styleTheme);

        $copyright = new Typecho_Widget_Helper_Form_Element_Textarea(
            'copyright',
            NULL,
            '',
            _t('版权信息'),
            _t('在每篇文章末尾添加版权信息，支持 HTML 标签')
        );
        $form->addInput($copyright);
    }

    /**
     * 个人用户的配置面板
     *
     * @access public
     * @param Typecho_Widget_Helper_Form $form
     * @return void
     */
    public static function personalConfig(Typecho_Widget_Helper_Form $form){}
}
