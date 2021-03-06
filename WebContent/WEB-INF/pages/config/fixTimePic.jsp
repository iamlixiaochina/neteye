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
<%@ taglib prefix="s" uri="/struts-tags"%>

	<div id="tabDiv">
		
	</div>
	
	<div id="div1">
			<s:set name="flag" value='<s:property value="flag"/>'/>
			<s:if test="flag == 0">
				<div id="flagDiv"></div>
				<div id="imgDiv1" >
					<ul>
		    			<li>日<s:property value="type"/>协议图</li>     		
		    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_day.gif'/></li>
		    		</ul>
		    	</div>
		    	<div id="imgDiv2" >
		    		<ul>
		    			<li>周<s:property value="type"/>协议图</li>
		    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_week.gif'/></li>
		    		</ul>
		    	</div>
				<div id="imgDiv3" >
					<ul>		
		    			<li>月<s:property value="type"/>协议图</li>
		    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_month.gif'/></li>
		    		</ul>
		    	</div>
		    	<div id="imgDiv4" >
					<ul>	
		    			<li>年<s:property value="type"/>协议图</li>
		    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_year.gif'/></li>
		    		</ul>
		    	</div>
	    	</s:if> 
	    	<s:elseif test="flag == 1">
	    		<s:iterator value="urlList" status="st">	
		    		<div id="imgDiv1" >
						<ul>		 
			    			<li>日（cpu|mem|disk）利用率</li>   		
			    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_day.gif'/></li>
			    		</ul>
					</div>	
					<div id="imgDiv2" >
						<ul>		 
			    			<li>周（cpu|mem|disk）利用率</li>   		
			    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_week.gif'/></li>
			    		</ul>
					</div>	
					<div id="imgDiv3" >
						<ul>		 
			    			<li>月（cpu|mem|disk）利用率</li>   		
			    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_month.gif'/></li>
			    		</ul>
					</div>	
					<div id="imgDiv4" >
						<ul>		 
			    			<li>年（cpu|mem|disk）利用率</li>   		
			    			<li><img src='file/service/dat/timetypepic/<s:property value="url"/>_year.gif'/></li>
			    		</ul>
					</div>					
		    	</s:iterator>
	    	</s:elseif>   	
	</div>    
	
	<div id="div2">
		 	<div id="imgPanel"><span id="anypic"></span></div>
	 </div>
