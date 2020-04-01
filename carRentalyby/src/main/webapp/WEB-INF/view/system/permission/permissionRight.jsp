<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限管理--右边列表</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="icon" href="${yby}/favicon.ico">
<link rel="stylesheet" href="${yby}/static/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${yby}/static/css/public.css" media="all" />
<link rel="stylesheet" href="${yby}/static/layui_ext/dtree/dtree.css" media="all" />
<link rel="stylesheet" href="${yby}/static/layui_ext/dtree/font/dtreefont.css" media="all" />

</head>
<body class="childrenBody">
<!-- 查询条件开始 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
  <legend>查询条件</legend>
</fieldset>
<blockquote class="layui-elem-quote">
	<form action="" method="post" id="searchFrm" lay-filter="searchFrm" class="layui-form layui-form-pane">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">权限名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="pname"  autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		       <label class="layui-form-label">权限编码</label>
		       <div class="layui-input-inline">
		        <input type="text" name="presource"  autocomplete="off" class="layui-input">
		      </div>
		      <div class="layui-input-inline">
		       	<button type="button" class="layui-btn" lay-submit="" lay-filter="doSearch"><span class="layui-icon layui-icon-search"></span>查询</button>
      			<button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>重置</button>
		      </div>
		    </div>
		  </div>
	</form>
</blockquote>
<!-- 查询条件结束-->


<!-- 数据表格开始 -->
<div>
	<table class="layui-hide" id="permissionTable" lay-filter="permissionTable"></table>
	<div id="permissionToolBar" style="display: none;">
		<button type="button" lay-event="add" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-add-1"></span>添加权限</button>
	</div>

	<div id="permissionRowBar" style="display: none;">
		<button type="button" lay-event="update" class="layui-btn layui-btn-sm"><span class="layui-icon layui-icon-edit"></span>更新</button>
		<button type="button" lay-event="delete" class="layui-btn layui-btn-sm layui-btn-danger"><span class="layui-icon layui-icon-delete"></span>删除</button>
	</div>
</div>

<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
	<form action="" method="post" class="layui-form layui-form-pane" id="dataFrm" lay-filter="dataFrm">
		<div class="layui-form-item">
		    <label class="layui-form-label">选择菜单</label>
		    <div class="layui-input-block">
		    	<input type="hidden" name="pid" id="pid" lay-verify="required">
		    	<ul id="permissionTree" class="dtree" data-id="0"></ul>
		    </div>
	 	</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">权限名称</label>
		    <div class="layui-input-block">
		      <input type="hidden" name="id">
		      <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入权限名称" class="layui-input">
		    </div>
 	   </div>
 	   <div class="layui-form-item">
		    <label class="layui-form-label">权限编码</label>
		    <div class="layui-input-block">
		      <input type="text" name="percode" autocomplete="off" placeholder="请输入权限地址" class="layui-input">
		    </div>
 	   </div>
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <label class="layui-form-label">是否展开</label>
	      <div class="layui-input-inline">
	        <input type="radio" name="open" value="1" title="展开" >
	        <input type="radio" name="open" value="0" title="不展开" checked="" >
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">是否可用</label>
	      <div class="layui-input-inline">
	        <input type="radio" name="available" value="1" title="可用" checked="">
	        <input type="radio" name="available" value="0" title="不可用" >
	      </div>
	    </div>
	  </div>
	   <div class="layui-form-item">
		    <label class="layui-form-label">排序码</label>
		    <div class="layui-input-inline">
		      <input type="text" name="ordernum" id="ordernum" lay-verify="required|number"  autocomplete="off" placeholder="请输入排序码[>0]" class="layui-input">
		    </div>
 	   </div>
 	   <div class="layui-form-item">
		    <div class="layui-input-block" style="text-align: center;">
		      	<button type="button" class="layui-btn" lay-submit="" lay-filter="doSubmit" id="doSubmit" ><span class="layui-icon layui-icon-add-1"></span>提交</button>
      			<button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>重置</button>
		     </div>
 	   </div>
	</form>
</div>
<!-- 添加和修改的弹出层结束 -->



<script type="text/javascript" src="${yby}/static/layui/layui.js"></script>
<script type="text/javascript">
var tableIns;
layui.extend({
    dtree: '${yby}/static/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
  }).use(['jquery','form','table','layer','dtree'],function(){
		var $=layui.jquery;
		var form=layui.form;
		var table=layui.table;
		var layer=layui.layer;
		var dtree=layui.dtree;
		//加载 数据
		 tableIns=table.render({
			 elem: '#permissionTable'
		    ,url:'${yby}/permission/loadAllPermission'
		    ,toolbar: '#permissionToolBar' //开启头部工具栏，并为其绑定左侧模板
		    ,title: '权限数据表'
		    ,height:'full-220'
		    ,page: true
		    ,cols: [ [
		      {field:'pid', title:'ID',align:'center'}
		      ,{field:'pname', title:'权限名称',align:'center'}
		      ,{field:'presource', title:'权限编码',align:'center'}
		      ,{fixed: 'right', title:'操作', toolbar: '#permissionRowBar',align:'center',width:'200'}
		    ] ]
		      ,done: function(res, curr, count){ //处理删除某一页最后一条数据的BUG
			        if(res.data.length==0&&curr!=1){
			        	tableIns.reload({
			        		page:{
			        			curr:(curr-1)
			        		}
			        	});
			        }
			    }
		});

		//模糊查询
		form.on("submit(doSearch)",function(data){
			tableIns.reload({
				where:data.field,
				page:{
					curr:1
				}
			});
			return false;
		});

		//监听工具条的事件
		table.on("toolbar(permissionTable)",function(obj){
			 switch(obj.event){
			    case 'add':
			     openAddLayer();
			    break;
			  };
		});

		//监听行工具条的事件
		table.on("tool(permissionTable)",function(obj){
			  var data = obj.data; //获得当前行数据
			 switch(obj.event){
			    case 'update':
			   		openUpdatePermissionLayer(data);
			    break;
			    case 'delete':
			   		deletePermission(data);
			    break;
			  };
		});

		var mainIndex;
		var url;
		//打开添加的弹出层
		function openAddLayer(){
			mainIndex=layer.open({
				type:1,
				content:$("#addOrUpdateDiv"),
				area:['800px','600px'],
				title:'添加权限',
				success:function(){
					$("#dataFrm")[0].reset();
					$("#pid").val("");
					url="${yby}/permission/addPermission";
					//初始化排序码
					$.get("${yby}/permission/loadPermissionMaxOrderNum",function(res){
						$("#ordernum").val(res.value);
					});
					selectTree.setSelectValue("");
				}
			});
		}

		//打开修改的弹出层
		function openUpdatePermissionLayer(data){
			mainIndex=layer.open({
				type:1,
				content:$("#addOrUpdateDiv"),
				area:['800px','600px'],
				title:'修改权限',
				success:function(){
					$("#dataFrm")[0].reset();
					//装载新的数据
					form.val("dataFrm",data);
					//选中之前父级的权限  nodeId=data.pid;
					dtree.dataInit("permissionTree", data.pid);
   					dtree.setSelectValue("permissionTree");
					url="${yby}/permission/updatePermission";
				}
			});
		}

		form.on("submit(doSubmit)",function(data){
			  $.post(url,data.field,function(res){
					if(res.code==200){
						tableIns.reload();
					}
						layer.msg(res.msg);
						layer.close(mainIndex);
					})
			return false;
		})
		//删除
		function deletePermission(data){
			layer.confirm('你确定要删除【'+data.title+'】这条权限吗?', {icon: 3, title:'提示'}, function(index){
				$.post("${yby}/permission/deletePermission",{id:data.id},function(res){
					if(res.code==200){
						tableIns.reload();
					}
					layer.msg(res.msg);
				})
			   layer.close(index);
			});
		}

		//初始化下拉树
		var selectTree=dtree.renderSelect({
			  elem: "#permissionTree",
			  width: "100%", // 可以在这里指定树的宽度来填满div
			  dataStyle: "layuiStyle",  //使用layui风格的数据格式
		      dataFormat: "list",  //配置data的风格为list
		      response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
		      url: "${yby}/menu/loadMenuManagerLeftTreeJson?spread=1" // 使用url加载（可与data加载同时存在）
			});
		//监听点击的方法
		dtree.on("node(permissionTree)" ,function(obj){
			$("#pid").val(obj.param.nodeId);
			  console.log(obj.param.nodeId); // 点击当前节点传递的参数
		});
	});

	/*//给其它页面刷新当前页面数据表格的方法
	function reloadTable(id){
		tableIns.reload({
			where:{
				mid:id
			},
			page:{
				curr:1
			}
		});
	}*/
</script>

</body>
</html>