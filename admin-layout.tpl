{* -- By default, check admin login ----------------------------------------- *}

{block name="check-auth"}
    {check_auth role="ADMIN" resource="{block name="check-resource"}{/block}" access="{block name="check-access"}{/block}" login_tpl="/admin/login"}
{/block}

{block name="no-return-functions"}{/block}

{* -- Define some stuff for Smarty ------------------------------------------ *}
{config_load file='variables.conf'}

{* -- Declare assets directory, relative to template base directory --------- *}
{declare_assets directory='assets'}

{* Set the default translation domain, that will be used by {intl} when the 'd' parameter is not set *}
{default_translation_domain domain='bo.default'}

<!DOCTYPE html>
<html lang="{$lang_code}">
<head>
    <meta charset="utf-8">

    <title>{block name="page-title"}Default Page Title{/block} - {intl l='Thelia Back Office'}</title>

    {images file='assets/img/favicon.ico'}<link rel="shortcut icon" href="{$asset_url}" />{/images}

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">

    {block name="meta"}{/block}

    {* -- Bootstrap CSS section --------------------------------------------- *}

    {block name="before-bootstrap-css"}{/block}

	{stylesheets file='assets/css/styles.css'}
        <link rel="stylesheet" href="{$asset_url}">
    {/stylesheets}

    {block name="after-bootstrap-css"}{/block}

    {* -- Admin CSS section ------------------------------------------------- *}

    {block name="before-admin-css"}{/block}

    {block name="after-admin-css"}{/block}

    {* Modules css are included here *}

    {hook name="main.head-css" location="head_css" }

    {* HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries *}
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    {javascripts file='assets/js/libs/respond.min.js'}
    <script src="{$asset_url}"></script>
    {/javascripts}
    <![endif]-->
</head>

<body>
	{* display top bar only if admin is connected *}

	{loop name="top-bar-auth" type="auth" role="ADMIN"}

	    {* -- Brand bar section ------------------------------------------------- *}

		{hook name="main.before-topbar" location="before_topbar" }

		<div class="topbar">
			<div class="container">

		        <div class="row">
		            <div class="col-md-12 clearfix">
		      		    <div class="version-info pull-left">{intl l='Version %ver' ver="{$THELIA_VERSION}"}</div>

                        <div class="clearfix pull-right hidden-xs">
                            <div class="button-toolbar pull-righ" role="toolbar">

                                {hook name="main.topbar-top" }

                                <div class="btn-group">
                                    <a href="{navigate to="index"}" title="{intl l='View site'}" target="_blank" class="btn btn-default"><span class="glyphicon glyphicon-eye-open"></span> {intl l="View shop"}</a>
                                    <button class="btn btn-default btn-primary"><span class="glyphicon glyphicon-user"></span> {admin attr="firstname"} {admin attr="lastname"}</button>
                                    <button class="btn btn-default btn-primary dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="profile" href="{url path='admin/configuration/administrators'}"><span class="glyphicon glyphicon-edit"></span> {intl l="Profil"}</a></li>
                                        <li><a class="logout" href="{url path='admin/logout'}" title="{intl l='Close administation session'}"><span class="glyphicon glyphicon-off"></span> {intl l="Logout"}</a></li>
                                    </ul>
                                </div>

                                <div class="btn-group">
                                    {loop type="lang" name="ui-lang" id="{lang attr='id'}"}
                                    <button class="btn btn-default">
                                        <img src="{image file="assets/img/flags/{$CODE}.png"}" alt="{$TITLE}" /> {$CODE|ucfirst}
                                    </button>
                                    {/loop}

                                    <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        {loop type="lang" name="ui-lang"}
                                        <li><a href="{url path="{navigate to="current"}" lang={$CODE}}"><img src="{image file="assets/img/flags/{$CODE}.png"}" alt="{$TITLE}" /> {$CODE|ucfirst}</a></li>
                                        {/loop}
                                     </ul>
                                </div>

                                {hook name="main.topbar-bottom" }

                            </div>
                        </div>

		            </div>

		    		{hook name="main.inside-topbar" location="inside_topbar" }

		        </div>

		    </div>
		</div>

		{hook name="main.after-topbar" location="after_topbar" }

	    {* -- Top menu section -------------------------------------------------- *}

		{hook name="main.before-top-menu" location="before_top_menu" }

		<nav class="navbar navbar-default" role="navigation">

            <div class="container">

                <div class="row">
        			<div class="navbar-header">
        				<button type="button" class="btn navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        					<span class="sr-only">Toggle navigation</span>
        					<span class="icon-bar"></span>
        					<span class="icon-bar"></span>
        					<span class="icon-bar"></span>
        				</button>
        			</div>

        			<div class="collapse navbar-collapse navbar-collapse">
        				<ul class="nav navbar-nav navbar-top-menu">

                            <li class="{if $admin_current_location == 'home'}active{/if}" id="home_menu">
                                <a href="{url path='/admin/home'}">{intl l="Home"}</a>
                            </li>

                            {loop name="menu-auth-customer" type="auth" role="ADMIN" resource="admin.customer" access="VIEW"}
                            {ifhook rel="main.top-menu-customer"}
                                {hookblock name="main.top-menu-customer" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'customer'}active{/if}" id="customers_menu">

                                    <a href="{url path='/admin/customers'}" data-target="{url path='/admin/customers'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Customers"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-customer"}
                                        <li role="menuitem">
                                            <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                {$title}
                                            </a>
                                        </li>
                                        {/forhook}
                                    </ul>
                                </li>
                                {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-customer"}
                                <li class="{if $admin_current_location == 'customer'}active{/if}" id="customers_menu">
                                    <a href="{url path='/admin/customers'}" >{intl l="Customers"}</a>
                                </li>
                            {/elsehook}
                            {/loop}

                            {loop name="menu-auth-order" type="auth" role="ADMIN" resource="admin.order" access="VIEW"}
                                <li class="dropdown {if $admin_current_location == 'order'}active{/if}" id="orders_menu">

                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{intl l="Orders"}</a>

                                    <ul class="dropdown-menu" role="menu">

                                        <li role="menuitem">
                                            <a class="clearfix" data-target="{url path='admin/orders'}" href="{url path='admin/orders'}">
                                                <span class="pull-left">{intl l="All orders"}</span>
                                                <span class="label label-default pull-right">{count type="order" customer="*" backend_context="1"}</span>
                                            </a>
                                        </li>

                                        {loop name="order-status-list" type="order-status"}
                                            {assign "orderStatusLabel" "order_$CODE"}
                                            <li role="menuitem">
                                                <a class="clearfix" data-target="{url path="admin/orders/$LABEL"}" href="{url path="admin/orders" status={$ID}}">
                                                    <span class="pull-left">{$TITLE}</span>
                                                    <span class="label label-{#$orderStatusLabel#} pull-right">{count type="order" customer="*" backend_context="1" status={$ID}}</span>
                                                </a>
                                            </li>
                                        {/loop}
                                        {hookblock name="main.top-menu-order" fields="id,class,url,title"}
                                        {forhook rel="main.top-menu-order"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                        {/hookblock}
                                    </ul>
                                </li>
                            {/loop}

                            {loop name="menu-auth-catalog" type="auth" role="ADMIN" resource="admin.category" access="VIEW"}
                            {ifhook rel="main.top-menu-catalog"}
                            {hookblock name="main.top-menu-catalog" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'catalog'}active{/if}" id="catalog_menu">

                                    <a href="{url path='/admin/catalog'}" data-target="{url path='/admin/catalog'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Catalog"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-catalog"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                    </ul>
                                </li>
                            {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-catalog"}
                                <li class="{if $admin_current_location == 'catalog'}active{/if}" id="catalog_menu">
                                    <a href="{url path='/admin/catalog'}">{intl l="Catalog"}</a>
                                </li>
                            {/elsehook}
                            {/loop}

                            {loop name="menu-auth-content" type="auth" role="ADMIN" resource="admin.folder"  access="VIEW"}
                            {ifhook rel="main.top-menu-content"}
                            {hookblock name="main.top-menu-content" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'content'}active{/if}" id="contents_menu">

                                    <a href="{url path='/admin/contents'}" data-target="{url path='/admin/contents'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Folders"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-content"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                    </ul>
                                </li>
                            {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-content"}
                                <li class="{if $admin_current_location == 'content'}active{/if}" id="contents_menu">
                                    <a href="{url path='/admin/contents'}" >{intl l="Folders"}</a>
                                </li>
                            {/elsehook}
                            {/loop}

                            {loop name="menu-auth-tools" type="auth" role="ADMIN" resource="admin.tools"  access="VIEW"}
                            {ifhook rel="main.top-menu-tools"}
                            {hookblock name="main.top-menu-tools" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'tools'}active{/if}" id="tools_menu">
                                    <a href="{url path='/admin/tools'}" data-target="{url path='/admin/tools'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Tools"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-tools"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                    </ul>
                                </li>
                            {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-tools"}
                                <li class="{if $admin_current_location == 'tools'}active{/if}" id="tools_menu">
                                    <a href="{url path='/admin/tools'}" >{intl l="Tools"}</a>
                                </li>
                            {/elsehook}
                            {/loop}

                            {loop name="menu-auth-modules" type="auth" role="ADMIN" resource="admin.module"  access="VIEW"}
                            {ifhook rel="main.top-menu-modules"}
                            {hookblock name="main.top-menu-modules" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'modules'}active{/if}" id="modules_menu">
                                    <a href="{url path='/admin/modules'}" data-target="{url path='/admin/modules'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Modules"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-modules"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                    </ul>
                                </li>
                            {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-modules"}
                                <li class="{if $admin_current_location == 'modules'}active{/if}" id="modules_menu">
                                    <a href="{url path='/admin/modules'}" >{intl l="Modules"}</a>
                                </li>
                            {/elsehook}
                            {/loop}

                            {loop name="menu-auth-config" type="auth" role="ADMIN" resource="admin.configuration"  access="VIEW"}
                            {ifhook rel="main.top-menu-configuration"}
                            {hookblock name="main.top-menu-configuration" fields="id,class,url,title"}
                                <li class="dropdown {if $admin_current_location == 'configuration'}active{/if}" id="config_menu">
                                    <a href="{url path='/admin/configuration'}" data-target="{url path='/admin/configuration'}" class="dropdown-toggle" data-toggle="dropdown">{intl l="Configuration"}</a>

                                    <ul class="dropdown-menu" role="menu">
                                        {forhook rel="main.top-menu-configuration"}
                                            <li role="menuitem">
                                                <a {if $id}id="{$id}" {/if} class="{$class}" data-target="{$url}" href="{$url}">
                                                    {$title}
                                                </a>
                                            </li>
                                        {/forhook}
                                    </ul>
                                </li>
                            {/hookblock}
                            {/ifhook}
                            {elsehook rel="main.top-menu-configuration"}
                                <li class="{if $admin_current_location == 'configuration'}active{/if}" id="config_menu">
                                    <a href="{url path='/admin/configuration'}" >{intl l="Configuration"}</a>
                                </li>
                            {/elsehook}
                            {/loop}


                            {hook name="main.in-top-menu-items" location="in_top_menu_items" }

                        </ul>

                        {loop name="top-bar-search" type="auth" role="ADMIN" resource="admin.search"  access="VIEW"}
                        <form class="navbar-form pull-right hidden-xs" action="{url path='/admin/search'}">
                            <div class="form-group">
                                <input type="text" class="form-control" id="search_term" name="search_term" placeholder="{intl l='Search'}">
                            </div>
                            <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                        </form>
                        {/loop}

        			</div>
                </div>
            </div>
		</nav>

		{hook name="main.after-top-menu" location="after_top_menu" }

	{/loop}

    {* A basic brandbar is displayed if user is not connected *}

	{elseloop rel="top-bar-auth"}
	    <div class="brandbar brandbar-wide container">
	        <a class="navbar-brand" href="{url path='/admin'}">{images file='assets/img/logo-thelia-34px.png'}<img src="{$asset_url}" alt="{intl l='Thelia, the open source e-commerce solution'}" />{/images}</a>
	    </div>
	{/elseloop}

    {* -- Main page content section ----------------------------------------- *}

	{block name="main-content"}Put here the content of the template{/block}

    {* -- Footer section ---------------------------------------------------- *}

    {hook name="main.before-footer" location="before_footer" }

    <hr />
    <footer class="footer">
        <div class="container">
            <p>{intl l='&copy; Thelia 2013'}
            - <a href="http://www.openstudio.fr/" target="_blank">{intl l='Published by OpenStudio'}</a>
            - <a href="http://thelia.net/forum" target="_blank">{intl l='Thelia support forum'}</a>
            - <a href="#" target="_blank">{intl l='Thelia contributions'}</a>
            </p>

            {hook name="main.in-footer" location="in_footer" }

        </div>
    </footer>

    {hook name="main.after-footer" location="after_footer" }


	{* -- Javascript section ------------------------------------------------ *}

	{block name="before-javascript-include"}{/block}
    <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
    <script>
        if (typeof jQuery == 'undefined') {
            {javascripts file='assets/js/libs/jquery.js'}
            document.write(unescape("%3Cscript src='{$asset_url}' %3E%3C/script%3E"));
            {/javascripts}
        }
    </script>

	{block name="after-javascript-include"}{/block}

    {javascripts file='assets/js/bootstrap/bootstrap.js'}
        <script src="{$asset_url}"></script>
    {/javascripts}

    {block name="javascript-initialization"}{/block}

    <script>
        (function($) {
            $(document).ready(function(){
               var testModal = $(".modal-force-show");
               if(testModal.length > 0) {
                   testModal.modal("show");
               }
            });
        })(jQuery);
    </script>

	{* Modules scripts are included now *}
	{hook name='main.footer-js' location="footer_js"}

    {block name="javascript-last-call"}{/block}
</body>
</html>

