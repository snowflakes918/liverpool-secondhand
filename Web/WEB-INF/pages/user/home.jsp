<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.min.js"></script>
    <script type="text/javascript">

        /*function viewPersonal(id){
            $.ajax({
                url:'<%=basePath%>admin/getUser',
                type:'GET',
                data:{id:id},
                dataType:'json',
                success:function(json){
                    if(json){
                        $('#myviewform').find("input[name='id']").val(json.id);
                        $('#myviewform').find("input[name='power']").val(json.power);
                        $('#myeditform').find("input[name='goodsNum']").val(json.goodsNum);
                        $('#myviewform').find("input[name='phone']").val(json.phone);
                        $('#myviewform').find("input[name='username']").val(json.username);
                        $('#myviewform').find("input[name='qq']").val(json.qq);
                        $('#myviewform').find("input[name='createAt']").val(json.createAt);
                        if(json.status==1){
                            $('#myviewform').find("input[name='status']").val('正常');
                        }else{
                            $('#myviewform').find("input[name='status']").val('禁用');
                        }
                        $('#viewModal').modal('toggle');
                    }
                },
                error:function(){
                    alert('请求超时或系统出错!');
                    $('#viewModal').modal('hide');
                }
            });
        }*/

        function sendContext(){
            var context= $("#mycontext").text();
            $.ajax({
                url:'<%=basePath%>user/insert',
                type:'POST',
                data:{context:context},
                dataType:'json',
                success:function(json){
                    alert(json.msg);
                    location.reload();
                },
                error:function(){
                    alert('请求超时或系统出错!');
                }
            });

        }

        $(function(){
            var options={
                bootstrapMajorVersion:1,    //版本
                currentPage:1,    //当前页数
                numberOfPages:5,    //最多显示Page页
                totalPages:10,    //所有数据可以显示的页数
                onPageClicked:function(e,originalEvent,type,page){
                    console.log("e");
                    console.log(e);
                    console.log("originalEvent");
                    console.log(originalEvent);
                    console.log("type");
                    console.log(type);
                    console.log("page");
                    console.log(page);
                }
            }
            //$("#page").bootstrapPaginator(options);
        })
    </script>

</head>
<body>
<div class="pre-2" id="big_img">
    <img src="<%=basePath%>img/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <div class="logo">MYSIS</div>
            </a>
            <div class="myheader">Second Hand Goods Information</div>
            <a href="<%=basePath%>user/home">
                <div class="home"></div>
            </a>
        </div>
        <!--

            描述：左侧个人中心栏
        -->
        <div id="user_nav">
            <div class="user_info">
                <div class="head_img">
                    <img src="<%=basePath%>img/photo5.jpg">
                </div>
                <span class="name">${cur_user.username}</span>

            </div>
            <div class="home_nav">
                <ul>
                    <a href="<%=basePath%>user/home">
                        <li class="notice">
                            <div></div>
                            <span>Order</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allFocus">
                        <li class="fri">
                            <div></div>
                            <span>Favourites</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>goods/publishGoods">
                        <li class="store">
                            <div></div>
                            <span>Upload</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allGoods">
                        <li class="second">
                            <div></div>
                            <span>My idle</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/basic">
                        <li class="set">
                            <div></div>
                            <span>Settings</span>
                            <strong></strong>
                        </li>
                    </a>
                </ul>
            </div>
        </div>
        <!--

            描述：右侧内容区域
        -->
        <div id="user_content">
            <div class="share">
                <!--
            <img src="<%=basePath%>img/Advertisement.png">
          -->
                <div class="publish">
                    <form role="form" id="contextForm">
                        <div class="pub_content">
                            <div class="text_pub lead emoji-picker-container">
                                <input type="text" name="context" data-emojiable="converted"  class="form-control" data-type="original-input" style="display: none;"/>
                                <div class="emoji-wysiwyg-editor form-control" data-type="input" id="mycontext" contenteditable="true"></div>
                                <!-- <i class="emoji-picker-icon emoji-picker face" data-type="picker" style="top: 153px;"></i> -->
                                <div class="tag"></div>
                            </div>
                            <div class="img_pub">
                                <ul></ul>
                            </div>
                        </div>
                    </form>
                    <div class="button">
                        <!--
                        	<span class="fa fa-image">
                            ::before
                            <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png" multiple/>
                        </span>
                         -->
                        <div class="checkbox" style="width:135px;">
                            <button onclick="sendContext()">UPLOAD</button>
                        </div>
                    </div>

                </div>
                <!--

                    描述：闲置商品展示
                -->
                <div class="share_content">
                    <c:if test="${notice==null}">
                        <div class="no_share">
                            <span>NOTHING HERE！</span>
                        </div>
                    </c:if>
                    <c:if test="${notice!=null}">
                        <div class="yes_share">
                            <h1 style="text-align: center;">Check what everyone wants</h1><hr>
                            <c:forEach items="${notice}" var="item" varStatus="status">
                                <button type="button" class="btn btn-info" onclick="viewPersonal(${item.user.id})" style="background-color: #c6f5f4;border:0px;outline:none;">${item.user.username}</button>
                                <span >说：&nbsp;&nbsp;&nbsp;&nbsp;${item.context}</span><br>
                                <p style="text-align:right;color:#4fbef6;">time：${item.createAt}</p>
                                <hr><br>
                            </c:forEach>
                            <div id="page" style=":center"></div>
                            <!--  <h1> 1 2 3 4 5 下一页 上一页</h1> -->
                        </div>
                    </c:if>
                </div>
            </div>
            <!--

                描述：最右侧，可能认识的人

            <div class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class="change">换一组</span>
                    <span class="underline"></span>
                </div>
                <ul>
                <c:forEach items="${users}" var="item" varStatus="status">
                	<li>
                        <a href="#" class="head_img">
                            <img src="<%=basePath%>img/photo${status.index + 1}.jpg">
                        </a>
                        <span>${item.username}</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                  </c:forEach>
                    <%-- <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>Brudce</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>Graham</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>hly</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>Danger-XFH</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>Keithw</span>
                        <div class="fa fa-plus-square"></div>
                    </li> --%>
                </ul>
            </div>
            -->
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" >查看用户信息</h4>
            </div>
            <div class="modal-body" style="height:300px; ">
                <form class="form-horizontal" id="myviewform" name="myform">
                    <input type="hidden" id="id" name="id" value=""/>
                    <input type="hidden" id="power" name="power" value=""/>
                    <input type="hidden" id="goodsNum" name="goodsNum" value=""/>
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >手机号:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_phone" name="phone" readonly style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >昵称:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_username" name="username" readonly style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >QQ:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_qq" name="qq" readonly style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >创建时间:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_createAt" name="createAt" readonly style="margin-top: 8px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label" >状态:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="my_status" name="status" readonly style="margin-top: 8px;"/>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
<script>
    function viewPersonal(id){
        $.ajax({
            url:'<%=basePath%>admin/getUser',
            type:'GET',
            data:{id:id},
            dataType:'json',
            success:function(json){
                if(json){
                    $('#myviewform').find("input[name='id']").val(json.id);
                    // $('#myviewform').find("input[name='power']").val(json.power);
                    // $('#myeditform').find("input[name='goodsNum']").val(json.goodsNum);
                    $('#myviewform').find("input[name='phone']").val(json.phone);
                    $('#myviewform').find("input[name='username']").val(json.username);
                    $('#myviewform').find("input[name='qq']").val(json.qq);
                    // $('#myviewform').find("input[name='createAt']").val(json.createAt);
                    // if(json.status==1){
                    //     $('#myviewform').find("input[name='status']").val('正常');
                    // }else{
                    //     $('#myviewform').find("input[name='status']").val('禁用');
                    // }
                    $('#viewModal').modal('toggle');
                }
            },
            error:function(){
                alert('请求超时或系统出错!');
                // $('#viewModal').modal('hide');
            }
        });
    }
</script>

</html>