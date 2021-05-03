<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.modal-header{
	 text-align:center;
	} 
	
table td{
 text-align:center;
 border:0px;
}


</style>
<title>Goods List</title>
	<!-- 分页 -->
<link href="<%=basePath%>css/mypage.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap-datetimepicker.min.css" rel="stylesheet">

</head>

<body>
	<jsp:include page="../main_top.jsp"></jsp:include>
	<jsp:include page="../main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px;margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<%=basePath%>admin/indexs" title="Home Page"
					class="tip-bottom"><i class="icon-home"></i>Home Page</a> <a title="Goods List"
					class="tip-bottom">Goods List</a>
			</div>
		</div>
		<!--End-breadcrumbs-->

		<!-- Page table -->
		<div class="container" style="width: 100%;">
			<!-- &lt;!&ndash; Marketing Icons Section &ndash;&gt;-->

			<div class="col-lg-12">
				<h2 class="page-header"
					style="margin-top:10px;text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
					Goods List</h2>
			</div>

			<!--搜索栏-->
			 <form class="form-horizontal" id="myserchform" name="myform" action="<%=basePath%>admin/searchGoods" method="post">
				<div class="form-group">
				<div  class="col-sm-8" style="text-align:center;">
					<span >ID：</span>
					<input type="number" name="id" value="${searchgoods.id}"/>
					<span >Name：</span>
					<input type="text"  name="name" value="${searchgoods.name}"/>
					<span >Status：</span>
					<select name="status" id="myselected" >
					<option value="" selected="selected">Choose goods status</option>
					<option value="1">On Sale</option>
					<option value="0">Off shelf</option>
					</select>
				</div>
					<div class="col-sm-4">
						<button class="btn btn-success btn-sm" type="submit" >look up</button>
						<button class="btn btn-danger btn-sm" type="button" id="deleteGoodsButton">delete</button>
					</div>
				</div>
			</form>
			
			<!--表格显示-->
			<table class="table table-bordered" >
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAllButton"></th>
						<th>ID</th>
						<th>Name</th>
						<th>Catelog</th>
						<th>Price</th>
						<th>Create At</th>
						<th>Status</th>
						<th>Operation</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${goodsGrid.rows}" var="item">
						<tr>
							<td ><input type="checkbox" name="itemIds" value="${item.id}"></td>
							<td>${item.id}</td>
							<td>${item.name}</td>
							<td>
					        <c:if test="${item.catelogId == 1}">  
							<span> Digital</span>
							</c:if>
							<c:if test="${item.catelogId == 2}">  
							<span>Trans </span>
							</c:if>
							<c:if test="${item.catelogId == 3}">  
							<span> Commodity  </span>
							</c:if>
							<c:if test="${item.catelogId == 4}">  
							<span> Book  </span>
							</c:if>
							<c:if test="${item.catelogId == 5}">  
							<span>Make Up </span>
							</c:if>
							<c:if test="${item.catelogId == 6}">  
							<span> Sports</span>
							</c:if>
							<c:if test="${item.catelogId == 7}">  
							<span> Others</span>
							</c:if>
							</td>
							<td>￥${item.realPrice}</td>
							<td>${item.startTime}</td>
							<td>
							<c:if test="${item.status == 1}">
							<span style="color:blue">On Sale</span>
							</c:if>
							<c:if test="${item.status == 0}">
							<span style="color:red">Off shelf</span>
							</c:if>
							</td>
							<td>
							<button type="button" class="btn btn-primary btn-sm" onclick="doView(${item.id})">查看</button>
							<button type="button" class="btn btn-info btn-sm"  onclick="doEdit(${item.id})" >修改</button>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!--分页条-->
			<div style="text-align: right">
				<div class="pagination">
					<ul>
						<li><a>Total Goods: ${goodsGrid.total }</a></li>
						<li><a>Page: ${goodsGrid.current }</a></li>
						<c:if test="${goodsGrid.current ne 1 }">
							<li><a 
								href="<%=basePath%>admin/goodsList?pageNum=${goodsGrid.current-1 }">Pre</a>
								</li>
						</c:if>

						<c:if test="${goodsGrid.current < (goodsGrid.total+9)/10-1 }">
							<li><a
								href="<%=basePath%>admin/goodsList?pageNum=${goodsGrid.current+1 }">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>

	
	<!--==================================================================================================================-->
	<jsp:include page="../main_bottom.jsp"></jsp:include>
	
<!--修改  模态框（Modal） -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" >修改商品信息</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
            <form class="form-horizontal" id="myeditform" name="myform">
             <input type="hidden" id="id" name="id" value=""/>
            	<div class="form-group">
					 <label class="col-sm-4 control-label" >Name:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_name" name="name" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Catelog:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_catelogId" readonly name="catelogId" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >原价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_price" name="price" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >售价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_realPrice" name="realPrice" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >创建时间:</label>
					<div class="col-sm-8">
						 <input  type="text" id="my_startTime" name="startTime" class="form-control form_datetime" style="margin-top: 8px;">
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >描述:</label>
					<div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" style="margin-top: 8px;width:365px">
					</textarea>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Status:</label>
					<div class="col-sm-8">
						<select name="status" style="margin-top: 8px;width: 372px;height: 27px;">
						<option value="0" selected="selected">下架</option>
						<option value="1">上架</option>
						</select>
					</div>
				</div>
			  </form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="doSave()">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 查看 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" >Goods Info</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
            <form class="form-horizontal" id="myviewform" name="myform">
             <input type="hidden" id="id" name="id" value=""/>
            	<div class="form-group">
					 <label class="col-sm-4 control-label" >Name:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_name" name="name" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Catelog:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_catelogId" name="catelogId" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Original Price:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_price" name="price" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Selling Prince:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_realPrice" name="realPrice" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Create At:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_startTime" name="startTime" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Description:</label>
					<div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" readonly style="margin-top: 8px;width:365px">
					</textarea>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >Status:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_form" name="status" readonly style="margin-top: 8px;"/>
					</div>
				</div>
			  </form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>

<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript"src="<%=basePath%>js/custom/base.js"></script>

<script type="text/javascript">
		//初始化时间
		$(".form_datetime").datetimepicker({  
			format:'yyyy-mm-dd',
	    	todayHighlight: true,
	    	language:'zh-CN',
	    	minView: "month", 
	      	autoclose: true
		});  
		

		/* 查看 */
		function doView(id){
			$.ajax({
				url:'<%=basePath%>admin/getGoods',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myviewform').find("input[name='id']").val(json.id);
						$('#myviewform').find("input[name='name']").val(json.name);
						$('#myviewform').find("input[name='catelogId']").val(json.catelogId);
						$('#myviewform').find("input[name='price']").val(json.price);
						$('#myviewform').find("input[name='realPrice']").val(json.realPrice);
						$('#myviewform').find("input[name='startTime']").val(json.startTime);
						$('#myviewform').find("textarea[name='describle']").val(json.describle);
						if(json.status==1){
							$('#myviewform').find("input[name='status']").val('On Sale');
						}else{
							$('#myviewform').find("input[name='status']").val('Off shelf');
						}
						$('#viewModal').modal('toggle');
					}
				},
				error:function(){
					alert('System error!');
					$('#viewModal').modal('hide');
				}
			});
		}
		
		/* 修改 */
		function doEdit(id){
			$.ajax({
				url:'<%=basePath%>admin/getGoods',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myeditform').find("input[name='id']").val(json.id);
						$('#myeditform').find("input[name='name']").val(json.name);
						$('#myeditform').find("input[name='catelogId']").val(json.catelogId);
						$('#myeditform').find("input[name='price']").val(json.price);
						$('#myeditform').find("input[name='realPrice']").val(json.realPrice);
						$('#myeditform').find("input[name='startTime']").val(json.startTime);
						$('#myeditform').find("textarea[name='describle']").val(json.describle);
						$('#myeditform').find("select[name='status']").val(json.status);
						$('#editModal').modal('toggle');
					}
				},
				error:function(){
					alert('System error!');
					$('#viewModal').modal('hide');
				}
			});
				
		}
		
		/* 保存 */
		function doSave(){
			$.ajax({
				url:'<%=basePath%>admin/updateGoods',
				type:'POST',
				data:$('#myeditform').serialize(),// 序列化表单值  
				dataType:'json',
				success:function(json){
					alert(json.msg);
					$('#editModal').modal('toggle');
					location.reload();
				},
				error:function(){
					alert('System error!');
					$('#editModal').modal('toggle');
				}
			});
				
		}
		
	//根据值 动态选中
	$("#myselected option[value='${searchgoods.status}']").attr("selected","selected"); 
	
</script>

</html>
