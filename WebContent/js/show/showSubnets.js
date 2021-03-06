Ext.namespace("savi");

var store = "";

Ext.onReady( function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget='qtip';  
	
	var switchBindingTypeHeader = bindingHeader+'&nbsp;&nbsp;' + 
		'(&nbsp;&nbsp;<span>DISABLE&nbsp;&nbsp;</span>' + 
		'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:url(images/switch/small/disable_switch.jpg) no-repeat scroll 0 0;">' +
		'&nbsp;&nbsp;&nbsp;&nbsp;<span>DEFAULT&nbsp;&nbsp;</span>' + 
		'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:url(images/switch/small/default_switch.jpg) no-repeat scroll 0 0;">' +
		'&nbsp;&nbsp;&nbsp;&nbsp;<span>SLAAC&nbsp;&nbsp;</span>' + 
		'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:url(images/switch/small/slaac_switch.jpg) no-repeat scroll 0 0;">' +
		'&nbsp;&nbsp;&nbsp;&nbsp;<span>DHCP&nbsp;&nbsp;</span>' + 
		'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:url(images/switch/small/dhcp_switch.jpg) no-repeat scroll 0 0;">' +
		'&nbsp;&nbsp;&nbsp;&nbsp;<span>MIX&nbsp;&nbsp;</span>' + 
		'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:url(images/switch/small/mix_switch.jpg) no-repeat scroll 0 0;">&nbsp;&nbsp;)';
	
	var Record = new Ext.data.Record.create( [ 
	{
		name : "id",
		mapping : "id"
	}, {
		name : "name",
		mapping : "name"
	}, {
		name : "switchNumber",
		mapping : "switchNum"
	}, {
		name : "switchBindingType",
		mapping : "switchForGlobalViewList"
	}, {
		name : "userNumber",
		mapping : "userNum"
	},{name:'cz'},{name:'dd'},{name:'cc'} ]);

	var reader = new Ext.data.JsonReader( {
		root : "subnetList",
		totalProperty : 'totalCount'
	}, Record);

	var proxy = new Ext.data.HttpProxy( {
		url : "show/listShowSubnets.do"
	});
	var colm = new Ext.grid.ColumnModel( [ {
		header : subnetID,	
		hidden: true,
		dataIndex : "id",
		sortable : true
	}, {
		header: subnetName,
		dataIndex : "name",
		sortable : true,
		width:110
	}, {
		header : switchNumber,
		dataIndex : "switchNumber",
		sortable : false,
		width:70
		//renderer: renderSwitchNumber
	},{
		id:"switchBindingType",
		header : switchBindingTypeHeader,
		dataIndex : "switchBindingType",
		sortable : false,
		renderer: renderSwitchBindingType
	}, {
		header : userNumber,
		dataIndex : "userNumber",
		sortable : false,
		width:70
		//renderer: renderUserNumber
	}]);
	/*
	function renderSwitchNumber(val){
		var switchNum = 0;
		for(var i = 0; i < val.length; i++ ){
			if(val[i].isDelete==0){
				switchNum += val[i].switchcurs.length;
			}
		}
		return switchNum;
	}
	*/
	function orderById(values){
		for(var j=1;j<values.length; j++){
			var key=values[j];
			i=j-1;
			while(i>=0&&values[i].switchBasicInfoId>key.switchBasicInfoId){
				values[i+1]=values[i];
				i--;
			}
			values[i+1]=key;
		}
	}
	/*
	function orderByName(values){
		for(var j=1;j<values.length; j++){
			var key=values[j];
			i=j-1;
			while(i>=0&&values[i].name>key.name){
				values[i+1]=values[i];
				i--;
			}
			values[i+1]=key;
		}
	}
	*/
	/*
	function renderSwitchBindingType(val){
		var count=0;
		var flag=1;
		var html = '<table>';
		var switchbasicinfos = val;
		orderByName(switchbasicinfos);
		for(var i = 0; i < switchbasicinfos.length; i++ ){
			if(switchbasicinfos[i].isDelete==1){
				continue;
			}
			var switchbasicinfoId = switchbasicinfos[i].id;
			var switchcurs=switchbasicinfos[i].switchcurs;
			orderById(switchcurs);
			for(var j = 0; j < switchcurs.length; j++){
				if(count%25==0){
					if(flag==1){
						html+='<tr>';
						flag=0;
					}
					else html+='</tr><tr>';					
				}
				count++;
				var userNum = 0;
				userNum += switchcurs[j].staticNum;
				userNum += switchcurs[j].slaacNum;
				userNum += switchcurs[j].dhcpNum;
				
				var switchcurId = switchcurs[j].id;
				var ipVersion = switchcurs[j].ipVersion;
				var systemMode =switchcurs[j].systemMode;
				var modeString = '';
				
				if(systemMode == '1') modeString = 'disable';
				else if(systemMode == '2') modeString = 'default';
				else if(systemMode == '3') modeString = 'dhcp';
				else if(systemMode == '4') modeString = 'slaac';
				else if(systemMode == '5') modeString = 'mix';
				else modeString = 'unkown';
				
				html += '<td width="36px" height="25px"><table>';
				if(modeString == 'unkown') html += 'UNKOWN';
				else html += '<tr><td width="36px" height="10px">' +
						'<a href="showSwitchDetails.do?ipVersion=' + ipVersion + "&switchbasicinfoId=" + switchbasicinfoId +'" target="_blank">' +
						'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:' +
						'url(images/switch/small/' + modeString + '_switch.jpg) no-repeat scroll 0 0;">' + 
						'</a></td></tr>';
				html += '<tr><td width="36px" height="15px">' + 
						'<img src="images/common/_blank.gif" style= "width:8px;height:8px;background:' +
						'url(images/common/face.jpg) no-repeat scroll 0 0;">&nbsp;' + userNum +
						'</td></tr>';
				html += '</table></td>';
			}
		}
		html += '</tr></table>';
		return html;
	}
	*/
	function renderSwitchBindingType(val){
		var count=0;
		var flag=1;
		var html = '<table>';
		var switchForGlobalViewList = val;
		orderById(switchForGlobalViewList);
		for(var i = 0; i < switchForGlobalViewList.length; i++ ){
			var switchbasicinfoId = switchForGlobalViewList[i].switchBasicInfoId;
			if(count%25==0){
				if(flag==1){
					html+='<tr>';
					flag=0;
				}
				else html+='</tr><tr>';					
			}
			count++;			
			var ipVersion = switchForGlobalViewList[i].ipVersion;
			var systemMode =switchForGlobalViewList[i].systemMode;
			var userNum = switchForGlobalViewList[i].userNum;
			var modeString = '';	
			if(systemMode == '1') modeString = 'disable';
			else if(systemMode == '2') modeString = 'default';
			else if(systemMode == '3') modeString = 'dhcp';
			else if(systemMode == '4') modeString = 'slaac';
			else if(systemMode == '5') modeString = 'mix';
			else modeString = 'unkown';
			html += '<td width="36px" height="25px"><table>';
			if(modeString == 'unkown') html += 'UNKOWN';
			else html += '<tr><td width="36px" height="10px">' +
						'<a href="showSwitchDetails.do?ipVersion=' + ipVersion + "&switchbasicinfoId=" + switchbasicinfoId +'" target="_blank">' +
						'<img src="images/common/_blank.gif" style= "width:25px;height:10px;background:' +
						'url(images/switch/small/' + modeString + '_switch.jpg) no-repeat scroll 0 0;">' + 
						'</a></td></tr>';
			html += '<tr><td width="36px" height="15px">' + 
						'<img src="images/common/_blank.gif" style= "width:8px;height:8px;background:' +
						'url(images/common/face.jpg) no-repeat scroll 0 0;">&nbsp;' + userNum +
						'</td></tr>';
			html += '</table></td>';
		}
		html += '</tr></table>';
		return html;
	}
	/*
	function renderUserNumber(val){
		var userNum = 0;
		var switchbasicinfos = val;
		for(var i = 0; i < switchbasicinfos.length; i++ ){
			if(switchbasicinfos[i].isDelete==0){
				for(var j = 0; j < switchbasicinfos[i].switchcurs.length; j++){
					userNum += switchbasicinfos[i].switchcurs[j].staticNum;
					userNum += switchbasicinfos[i].switchcurs[j].slaacNum;
					userNum += switchbasicinfos[i].switchcurs[j].dhcpNum;
				}
			}
		}
		return userNum;
	}
	*/
	store = new Ext.data.Store( {
		proxy : proxy,
		reader : reader
	});
	
	store.load( {
		params : {
			start : 0,
			limit : 22
		}
	});
	
	var grid = new Ext.grid.GridPanel( {
		title: title,
		store : store,
		height : document.body.clientHeight - 37,
		autoExpandColumn: 'switchBindingType',
		width : document.body.clientWidth < 1024? 960:1220,
		cm : colm,
		autoScroll : true,
		renderTo : "showDiv",
		bbar : new Ext.PagingToolbar( {
			pageSize : 22,
			store : store,
			displayInfo : true,
			displayMsg : displayMsgText,
			emptyMsg : noRecordText
		}),
		tbar : [ '->','-','->', {
			id : "switch_basic_information",
			text : barText,
			handler: function(){
				document.location.href = 'showSwitches.do?ids=';
			}},'->','-','->', {
			text : saviText,
			handler: function(){
				document.location.href = 'showSaviSystemTable.do?ids=';
			}},'->','-'
		]
	});
	
	function rowdblclickFn(grid, rowIndex, e){//双击事件
		 var row = grid.store.getById(grid.store.data.items[rowIndex].id);
		 //document.location.href = 'showSubnetDetails.do?subnetId=' + row.get("id");
		 window.open('showSubnetDetails.do?subnetId=' + row.get("id"),"_blank");
	}
	
	grid.addListener('rowdblclick', rowdblclickFn);//添加双击事件
});