<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <style type="text/css">
        #code:hover{
            cursor: pointer;
        }
    </style>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>在线购物商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" href="../../iconfont/iconfont.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function(){
            $("#code").on("click", function(){
                $(this).attr("src", "${pageContext.request.contextPath}/user/generateCode?mask=" + new Date().getTime());
            });

            $("div[name=add]").click(function(){
                var id = $(this).attr("productId")
                $.post("${pageContext.request.contextPath}/private/cart/add", {id:id}, function(msg){
                    alert(msg);
                }, "text");
            });

        });
    </script>
    <body>
        <div class="navbar navbar-default clear-bottom">
            <div class="container">
                <!-- logo start -->
                <div class="navbar-header">
                    <a class="navbar-brand logo-style" href="/">
                        <img class="brand-img" src="${pageContext.request.contextPath}/images/com-logo1.png" alt="logo" height="70">
                    </a>
                </div>
                <!-- logo end -->
                <!-- navbar start -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="#">商城主页</a>
                        </li>
                        <li>
                            <a href="myOrders.jsp">我的订单</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/private/cart/showCart">购物车</a>
                        </li>
                        <li class="dropdown">
                        	<a href="center.jsp">会员中心</a>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <c:if test="${empty sessionScope.user}">
                            <li>
                                <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
                            </li>
                            <li>
                                <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
                            </li>
                            <li style="color:red;height: 66px;line-height:66px;">
                                    ${msg}
                            </li>
                        </c:if>

                        <c:if test="${not empty sessionScope.user}">
                            <li class="userName">
                                您好：${sessionScope.user.nickName}！
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                                    <img class="img-circle" src="${pageContext.request.contextPath}${sessionScope.user.image}" height="30" />
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                                            <i class="glyphicon glyphicon-cog"></i>修改密码
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/user/quit">
                                            <i class="glyphicon glyphicon-off"></i> 退出
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <!-- navbar end -->
            </div>
        </div>
        <!-- content start -->
        <div class="container" id="a">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-header" style="margin-bottom: 0px;">
                        <h3>商品列表</h3>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <form class="form-inline hot-search" action="${pageContext.request.contextPath}/product/findByCondition">
                        <div class="form-group">
                            <label class="control-label">价格：</label>
                            <input type="text" class="form-control" placeholder="最低价格" name="minPrice" value="${condition.minPrice}">--
                            <input type="text" class="form-control" placeholder="最高价格" name="maxPrice" value="${condition.maxPrice}">
                        </div>
                        &nbsp;
                        <div class="form-group">
                            <!-- <input type="text" id="datepicker" class="form-control" placeholder="出发时间"> -->
                            <label class="control-label">分类：</label>
                            <select class="form-control input-sm" name="productTypeId">
                                <option value="-1">查询全部</option>
                                <c:forEach items="${productTypes}" var="productType">
                                    <option value="${productType.id}" ${condition.productTypeId == productType.id ? "selected":""}>${productType.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-warning pull-right">
                            <i class="glyphicon glyphicon-search"></i>&nbsp;查询
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="content-back">
            <div class="container" id="a">
                <div class="row">
                    <c:forEach items="${products}" var="product">
                        <div class="col-xs-3  hot-item">
                            <div class="panel clear-panel">
                                <div class="panel-body">
                                    <div class="art-back clear-back">
                                        <div class="add-padding-bottom">
                                            <img src="${pageContext.request.contextPath}${product.image}" class="shopImg">
                                        </div>
                                        <h4>${product.name}</h4>
                                        <div class="user clearfix pull-right">
                                            ￥${product.price}
                                        </div>
                                        <div class="desc">${product.desc}</div>
                                        <div class="attention pull-right" name="add" productId="${product.id}">
                                            加入购物车 <i class="icon iconfont icon-gouwuche"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
                <!-- fiex btn start-->
                <!--  <div class="mfw-toolbar">
                    <div class="toolbar-item-top">
                        <a href="#a" role="button" class="btn">
                            <i class="glyphicon glyphicon-chevron-up"></i>
                        </a>
                    </div>
                </div> -->
                <!-- fiex btn end-->
            </div>
        </div>
        <!-- content end-->
        <!-- footers start -->
<!--         <div class="footers"> -->
<!--             版权所有：&nbsp; &nbsp; 南京网博 shixiaojun@itany.com -->
<!--         </div> -->
        <!-- footers end -->
        <!-- 修改密码模态框 -->
        <div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                    </div>
                    <form action="" class="form-horizontal" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">原密码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">新密码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">重复密码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                            <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                            <button type="submit" class="btn btn-warning">修&nbsp;&nbsp;改</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- 登录模态框   --> 
        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">登&nbsp;陆</h4>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/doLogin" class="form-horizontal" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登录帐号：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password" name="username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password" name="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">验证码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="code">
                                </div>
                                <div class="col-sm-2 input-height">
                                   <img id="code" src="${pageContext.request.contextPath}/user/generateCode" />
                                </div>
                               <!--  <label class="col-sm-3 control-label" style="text-align:left; border: 1px solid #ccc;">1234</label> -->
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                            <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                            <button type="submit" class="btn btn-warning">登&nbsp;&nbsp;陆</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- 注册模态框 -->
        <div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">会员注册</h4>
                    </div>
                    <form action="${pageContext.request.contextPath}/user/doRegist" class="form-horizontal" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户姓名:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="nickName">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登陆账号:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登录密码:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password" name="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系电话:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系地址:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text" name="address">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                            <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                            <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
