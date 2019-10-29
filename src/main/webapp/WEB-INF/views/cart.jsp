<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>我的购物车</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function(){
            $("#code").on("click", function(){
                $(this).attr("src", "${pageContext.request.contextPath}/user/generateCode?mask=" + new Date().getTime());
            });

            $("#continue").on("click", function(){
                location.href = "${pageContext.request.contextPath}/product/showMain";
            });

            $("#clear").click(function(){
                location.href = "${pageContext.request.contextPath}/private/cart/clear";
            });

            $(".btn-danger").click(function(){
                if(confirm("是否确认删除")){
                    var productId = $(this).attr("productId");
                    var that = this;
                    $.post("${pageContext.request.contextPath}/private/cart/removeById", {productId:productId}, function(msg){
                        $(that).parent().parent().remove();
                        alert(msg);
                    },"text");
                }
            });

            $(".btn-success").click(function(){
                var productId = $(this).attr("productId");
                var that = this;
                $.post("${pageContext.request.contextPath}/private/cart/modifyItemNumByProductId", {productId:productId, num:$(that).parent().prev().prev().find("input").val()}, function(data){
                    console.debug(data);
                    $(that).parent().prev().text(data.itemTotalPrice);
                    $("#cartTotalPrice").text(data.cartTotalPrice);
                    alert(data.message);
                },"json");
            });
        });
    </script>
    <body>
        <div class="navbar navbar-default clear-bottom">
            <div class="container">
                <!-- logo start -->
                <div class="navbar-header">
                    <a class="navbar-brand logo-style" href="/">
                        <img class="brand-img" src="../../images/com-logo1.png" alt="logo" height="70">
                    </a>
                </div>
                <!-- logo end -->
                <!-- navbar start -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="${pageContext.request.contextPath}/product/showMain">商城主页</a>
                        </li>
                        <li>
                            <a href="myOrders.jsp">我的订单</a>
                        </li>
                        <li class="active">
                            <a href="cart.jsp">购物车</a>
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
                                        <a href="#">
                                            <i class="glyphicon glyphicon-off"></i> 退出
                                        </a>
                                    </li>
                        </c:if>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- navbar end -->
            </div>
        </div>
        <!-- content start -->
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-header" style="margin-bottom: 0px;">
                        <h3>我的购物车</h3>
                    </div>
                </div>
            </div>
            <table class="table table-hover table-striped table-bordered">
                <tr>
                    <th>
                        <input type="checkbox" id="all">全选</th>
                    <th>序号</th>
                    <th>商品名称</th>
                    <th>商品图片</th>
                    <th>商品数量</th>
                    <th>商品总价</th>
                    <th>操作</th>
                </tr>

                <c:forEach items="${sessionScope.cart.items}" var="item" varStatus="status">
                    <tr>
                        <td>
                            <input type="checkbox">
                        </td>
                        <td>${status.count}</td>
                        <td>${item.product.name}</td>
                        <td> <img src="${pageContext.request.contextPath}${item.product.image}" alt="" width="60" height="60"></td>
                        <td>
                            <input type="text" value="${item.num}" size="5">
                        </td>
                        <td>${item.totalPrice}</td>
                        <td>
                            <button productId="${item.product.id}" class="btn btn-success" type="button"> <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改</button>
                            <button productId="${item.product.id}" class="btn btn-danger" type="button" >
                                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>

               

                <tr>
                    <td colspan="7" align="right">
                        <button class="btn btn-warning margin-right-15" type="button" > 删除选中项</button>
                        <button class="btn btn-warning  margin-right-15" type="button" id="clear"> 清空购物车</button>
                        <button class="btn btn-warning margin-right-15" type="button" id="continue" >继续购物</button>
                        <a href="order.jsp"><button class="btn btn-warning " type="button" > 结算</button></a>

                    </td>
                    
                </tr>
                 <tr>
                    <td colspan="7" align="right"  class="foot-msg">
                        总计： <b><span id="cartTotalPrice">${sessionScope.cart.totalPrice}</span> </b>元
                    </td>
                    
                </tr>
            </table>
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
        <!-- 登录模态框 -->
        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">登&nbsp;陆</h4>
                    </div>
                    <form action="" class="form-horizontal" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登录帐号：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">验证码：</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                                <div class="col-sm-2 input-height">
                                   <img src="${pageContext.request.contextPath}/user/generateCode" id="#code"/>
                                </div>
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
                    <form action="" class="form-horizontal" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户姓名:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登陆账号:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">登录密码:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系电话:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系地址:</label>
                                <div class="col-sm-6">
                                    <input class="form-control" type="text">
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
