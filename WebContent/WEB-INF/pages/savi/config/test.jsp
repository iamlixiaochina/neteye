<%--
** Copyright (c) 2008, 2009, 2010
**      The Regents of the Tsinghua University, PRC.  All rights reserved.
**
** Redistribution and use in source and binary forms, with or without  modification, are permitted provided that the following conditions are met:
** 1. Redistributions of source code must retain the above copyright  notice, this list of conditions and the following disclaimer.
** 2. Redistributions in binary form must reproduce the above copyright  notice, this list of conditions and the following disclaimer in the  documentation and/or other materials provided with the distribution.
** 3. All advertising materials mentioning features or use of this software  must display the following acknowledgement:
**  This product includes software (iNetBoss) developed by Tsinghua University, PRC and its contributors.
** THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
** IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
** ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
** DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
** OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
** LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
** OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
** SUCH DAMAGE.
*
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN "   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta HTTP-EQUIV="refresh" Content="300">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>全局故障监控</title>
	 <link rel='StyleSheet' href="css/topoInit.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/ext-all.css"/>
	<script type="text/javascript" src="js/ext-base.js"></script>
	<script type="text/javascript" src="js/ext-all.js"></script>
	<script type="text/javascript">
		var emptyTipText = "<s:text name='tip.empty'/>";
		var waitMsgText = "<s:text name='form.waitMsg'/>";
		var displayMsgText = "<s:text name='grid.displayMsg'/>";
		var noRecordText = "<s:text name='grid.noRecord'/>";
		var noticeTitleText = "<s:text name='notice.title'/>";
		var updateFailedText = "<s:text name='notice.update.failed'/>";
		var updateSuccessText = "<s:text name='notice.update.success'/>";
		var saveOrUpdateFailedText = "<s:text name='notice.saveOrUpdate.failed'/>";
		var saveOrUpdateSuccessText = "<s:text name='notice.saveOrUpdate.success'/>";
		var saveFailedText = "<s:text name='notice.save.failed'/>";
		var saveSuccessText = "<s:text name='notice.save.success'/>";
		var deleteSuccessText = "<s:text name='notice.delete.success'/>";
		var deleteFailedText = "<s:text name='notice.delete.failed'/>";
		var deleteConfirmText = "<s:text name='notice.delete.confirm'/>";
		var loadingText = "<s:text name='combo.loadingText'/>";
		var pleaseSelectText = "<s:text name='combo.pleaseSelect'/>";
		
		var idText = "<s:text name='switchbasicinfo.id'/>";
		var nameText = "<s:text name='switchbasicinfo.name'/>";
		var equipmentTypeText = "<s:text name='switchbasicinfo.equipmentType'/>";
		var ipv4addressText = "<s:text name='switchbasicinfo.ipv4address'/>";
		var ipv6addressText = "<s:text name='switchbasicinfo.ipv6address'/>";
		var subnetNameText = "<s:text name='switchbasicinfo.subnetName'/>";
		var statusText = "<s:text name='switchbasicinfo.status'/>";
		var snmpVersionText = "<s:text name='switchbasicinfo.snmpVersion'/>";
		var readCommunityText = "<s:text name='switchbasicinfo.readCommunity'/>";
		var writeCommunityText = "<s:text name='switchbasicinfo.writeCommunity'/>";
		var authKeyText = "<s:text name='switchbasicinfo.authKey'/>";
		var privateKeyText = "<s:text name='switchbasicinfo.privateKey'/>";
		var descriptionText = "<s:text name='switchbasicinfo.description'/>";

		var switchbasicinfoText = "<s:text name='config.configSwitch.switchbasicinfo'/>";
		var batchAddSwitchText = "<s:text name='config.configSwitch.batchAddSwitch'/>";
		var addOrUpdateSwitchText = "<s:text name='config.configSwitch.addOrUpdateSwitch'/>";
		var deleteSwitchText = "<s:text name='config.configSwitch.deleteSwitch'/>";
		var saviSystemTableText = "<s:text name='config.configSwitch.saviSystemTable'/>";
		var ipErrorText = "<s:text name='config.configSwitch.ipError'/>";
		var submitButtonText = "<s:text name='config.configSwitch.button.submit'/>";
		var switchInfoText = "<s:text name='config.configSwitch.switchInfo'/>";
		var subnetListText = "<s:text name='config.configSwitch.subnetList'/>";
		var ipv4StartText = "<s:text name='config.configSwitch.ipv4Start'/>";
		var ipv4EndText = "<s:text name='config.configSwitch.ipv4End'/>";
		var ipv6StartText = "<s:text name='config.configSwitch.ipv6Start'/>";
		var ipv6EndText = "<s:text name='config.configSwitch.ipv6End'/>";
		var ipv4ErrorText = "<s:text name='config.configSwitch.ipv4Error'/>";
		var ipv6ErrorText = "<s:text name='config.configSwitch.ipv6Error'/>";
		var batchAddSwitchScriptText="<s:text name='config.configSwitch.batchAddSwitchScript'/>";
		var loseSubnetInfoText="<s:text name='config.configSwitch.loseSubnetInfo'/>";
	</script>
	
	<STYLE type="text/css">
		#viewname {
		width:800px;
			text-align:left;
			float:left;
			
		}
		#valueList li {
			float:left;
		}
		#view1{
	width:100px;
	height:20px;
	padding-right:1px;
	margin:1px;
	text-align:left; 
	float:left;
	border:1px dashed #C9C4CA;
	overflow:hidden;
}
  div#girdshow {
 text-align:left;
 width:1050px;
 margin:0 auto;
  }
	</STYLE>
	
</head>
<body>

<br>
<CENTER>

<br>
<br>
	  <div id="girdshow"></div>	

	<SCRIPT type="text/javascript">
	var submitView="1";
		Ext.onReady(function(){
	var reader = new Ext.data.JsonReader( {
		
		root : "acApLists",
		totalProperty : 'count',
		fields : ['id', 'name', 'filtercount', 'nodecount','aplist' ]
	});

	var proxy = new Ext.data.HttpProxy( {
		url : "json/apaclists.do"
	});
	
	 store = new Ext.data.Store( {
		proxy : proxy,
		reader : reader
	});
	
	store.load( {
		/**
		params: {
			submitView:submitView
		}
		**/
	});
	//store.setDefaultSort('name','ASC');   
	   var bindingTableColm = new Ext.grid.ColumnModel( 
		[
			{header : "id",dataIndex : 'id',sortable : false,width:50	},
			
			//{header : "AC",dataIndex : 'name',sortable : false,width:90,renderer: stuasnodes},
			{header : "设备名",dataIndex : 'name',sortable : false,width:90,renderer: stuasnodes},
			
			//{header: "过滤报文数",dataIndex : 'filtercount',sortable : true,width:110}, 
			{header: "ipv4",dataIndex : 'filtercount',sortable : true,width:110}, 
	             
			//{header : "用户数",dataIndex : 'nodecount',sortable : false,width:100	},
	             
			{id:"apid",	header : "用户名",dataIndex : 'aplist',sortable : false,renderer: listfaults},
			//{id:"apid",	header : "AP",dataIndex : 'aplist',sortable : false,renderer: listfaults}
		]);
	   
		var grid = new Ext.grid.GridPanel( {
		title: "设备",
		store : store,
		//height : document.body.clientHeight - 37,
		//height :1000,
		autoHeight: true,
		
		width : 1000,
		autoExpandColumn: 'apid',
		cm :bindingTableColm,
	   
	 tbar : [ '->','-','->', {
			id : "basic",
			text : "添加新设备",
			handler:addOrUpdateSubnet
			}
		],
		autoScroll : true,
		renderTo : 'girdshow'
	
	});
		
		function addOrUpdateSubnet(){
			
			var addSubnet = new Ext.FormPanel( {
				labelWidth : 113,
				frame : true,
				title : '',
				bodyStyle : 'padding:5px 5px 0',
				width : 420,
				defaults : {
					width : 230
				},
				labelAlign: 'left',
				defaultType : 'textfield',
				items : [ 
							{
								fieldLabel : '设备名',
								name : 'deviceinfo.name',
								blankText:emptyTipText,
								allowBlank:false
							}, {
								name:"deviceinfo.equipmentType",
								//fieldLabel : equipmentTypeText,
								fieldLabel : '用户名',
								allowBlank : true
							},{
								fieldLabel : '密码',
								//fieldLabel : 'ipv4',
								name : 'deviceinfo.ipv4address',
								blankText:emptyTipText,
								allowBlank:false
							}, {
								fieldLabel : 'ipv4',
								//fieldLabel : 'ipv6',
								name : 'deviceinfo.ipv6address',
								blankText:emptyTipText,
								allowBlank:false
							}, {
								name:"deviceinfo.readCommunity",
								fieldLabel : '端口号',
								//fieldLabel : readCommunityText,
								allowBlank : true
								
							}
					],
				buttons : [ {
							text : '提交',
							handler : function() {
								addSubnet.getForm().submit({
									url:"config/saveDeviceinfo.do",
									waitMsg: waitMsgText,
									success:function(form, action){
										addSubnetWin.close();
										store.reload();
												Ext.Msg.show({   
					                                title:noticeTitleText,   
					                                msg:saveOrUpdateSuccessText,   
					                                icon:Ext.MessageBox.INFO,   
					                                buttons:Ext.MessageBox.OK   
		                                                            }); 
									},
									failure:function(from, action){
										var errMsg = Ext.decode(action.response.responseText).errMsg;
										Ext.Msg.alert(noticeTitleText, saveOrUpdateFailedText + errMsg);
									}
								});
							}
				}]
			});
			var addSubnetWin = new Ext.Window( {
				width : 440,
				height : 320,
				layout : 'fit',
				plain : true,
				frame : true,
				title : '添加新设备',
				bodyStyle : 'padding:5px 5px 0',
				buttonAlign : 'center',
				items : [addSubnet]
				});
			addSubnetWin.show();
		}


		
		function stuasnodes(val){
		
		var routerstutas ="images/yellow_color.gif";
    	html= '<img src='+routerstutas+' width="50" height="50"><br>'+val;
		return html;
		
		};
		function listfaults(val){
	
		//var html = '';
		var html = '<table width="100%">';
		var loop=0;
		var routerstutas ="images/yellow_color.gif";
		var GlobalViewList = val;
		for(var i = 0; i < GlobalViewList.length; i++ ){
			/***
		html += ' <div id="view1">'+
		       		'<img src='+routerstutas+' width="20" height="20">'+
		            '<a>'+GlobalViewList[i].usernum+'</a>'+
								        '</div>'
***/
			if(loop == 0){
				html += '<tr>';
			}
			loop++;	

			modeString = 'default';
			if(status=='0'){
				modeString = 'default';

			}else{
				modeString = 'slaac';
				
			}
			html += '<td width="16.66%" height="25px"><table>';
			if(modeString == 'unkown') 
				html += 'UNKOWN';
			else {
				html += '<tr><td width="30px" height="10px">' +	
				'<a href="showPADetails.do?switchbasicinfoId=' +  GlobalViewList[i].apid + '" target="_blank">' +

				
						'<img src="images/common/_blank.gif" style= "width:30px;height:10px;background:' +
						'url(images/switch/small/' + modeString + '_switch.jpg) no-repeat scroll 0 0;">' + 
						'</a></td><td>'+GlobalViewList[i].apname+'</td></tr>';
						
				html += '<tr><td width="30px" height="15px" style="font:11px arial,tahoma,helvetica,sans-serif">' + 
							'<img src="images/common/_blank.gif" style= "width:8px;height:8px;background:' +
							'url(images/common/face.jpg) no-repeat scroll 0 0;">&nbsp;&nbsp;' + GlobalViewList[i].usernum +
							'</td></tr>';
				html += '</table></td>';
			}
			if(loop > 4){
				loop = 0;
				html += '</tr>';
			}
		           
		}
		for(var i = loop; i < 5 && loop > 0; i++){
			html += '<td width="16.66%" height="25px"></td>';
			if(i == 4) html +='</tr>';
		}
			
		html += '</table>';
		
		return html;
		
		}
     	grid.addListener('rowdblclick', rowClickFn);
     	
	    function rowClickFn(grid, rowIndex) {
		var ts = grid.getStore();
		var ttps = ts.getAt(rowIndex);
		var ttid = ttps.get("id");
		var ttname = ttps.get("name");
		// document.location.href ="portListAll.do?deviceId="+ttid
		window.open('huaSanSubnetDetails.do?subnetId=' + ttid,"_blank");
		 
	}
		
		var panel = new Ext.Panel({
			title:"故障监控",
			width:840,
			items:[
			{
				width:840,
				height:document.body.clientHeight*0.95 - 20,
				autoScroll:true,
				contentEl:"eventListDiv"
			}]
		});
			
		});

		
	</SCRIPT>
	
</body>
</html>