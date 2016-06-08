<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<style>
td,body,span { font-size : 9pt ; font-family: '돋움','verdana','arial', 'sans-serif'; }

a.link.kosdaq {
    COLOR: #7F7F7F; TEXT-DECORATION: underline;
}

a.active.kosdaq {
    COLOR: #7F7F7F; TEXT-DECORATION: none;
}

a.visited.kosdaq {
    COLOR: #7F7F7F; TEXT-DECORATION: underline;
}
a.hover.kosdaq {
 COLOR:#7F7F7F; TEXT-DECORATION: underline;
}
TD.title_defult {  
    background-color: #81ACC6;
}

TD.body_a {  
    background-color: #C3CACC;
}

TD.body_b {  
    background-color: #EEF9F9;
}

TD.kdaqTitle2Bg {  
    background-color: #F6F7E4;
}

TD.body_1 {  
    background-color: #EFEFEF;
    font-size: 9pt;
}

TD.body_0 {  
    background-color: #FFFFFF;
    font-size: 9pt;
}


.FONT_title_defult{
    color: #FFFFFF; 
    font-size:9pt; 
    font-family:"돋움"
}

.FONT_Title2Col{
    color: #000000; 
    font-size:9pt; 
    font-family:"돋움"
}

.FONT_body_0{
    color: #000000; 
    font-size:9pt; 
    font-family:"돋움"
}

.FONT_body_1{
    color: #000000; 
    font-size:9pt; 
    font-family:"돋움"
}
</style>
<!-- 차트를 플래쉬로 불러옴 (AutoTrustHTTP.cab 파일 필요) -->
<OBJECT id="httpObj" classid="clsid:CDF26594-A9E2-4E41-87F9-6E79DD38CFE3" codebase="/resources/AutoTrustHTTP.cab#version=1,0,1,1" width=0 height=0 align=center hspace=0 vspace=0>
	<Param name="CheckControl" value="True">
	<Param name="ASync" value="True">
	<Param name="RequestURL" value="http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code=035420">
	<Param name="HTTPMethod" value="GET">
</OBJECT>
<script src='http://asp1.krx.co.kr/inc/js/asp_chart.js'></script>
<script>
//차트 불러오는 부분
function SetFunction() {
	if (httpObj != null){
		httpObj.OnReadyStateChange = MyOnReadyStatChange;
	}
};
//xml data 요청
function SendRequest() {
	if (httpObj != null){
		httpObj.OnReadyStateChange = MyOnReadyStatChange; 
		onChart(200, 205, '035420');
	}
};
// onreadystatechange funcion 이 이function 으로 설정된 경우 작동
var dipDate;//날짜시간처리
function MyOnReadyStatChange() {
    var nReadyState = httpObj.ReadyState;
    if (4 == nReadyState){
        if (httpObj.Status != 200){
            alert("Error Code: " + httpObj.Status + "\r\n" + httpObj.StatusText);
         }
        else{
            var contentType = httpObj.getResponseHeader("Content-Type");
            if (contentType.length < 8 || contentType.substring(0, 8) != "text/xml") {
                alert("잘못된 데이터입니다. 오랫동안 사용하지 않아 세션이 종료되었거나, 서버오류입니다!");
                return;
            }
            var xmlDoc = httpObj.ResponseXML;
			var cDate =  document.getElementById("createDate")
            dipDate = xmlDoc.selectSingleNode("stockprice").getAttribute("querytime");
            setTimeout(SendRequest, 10000);
        }
	}
}


var preSval = 1; //깜박임을 줄이기 위해
function change_id(sval) {
    if (preSval != sval) {
        if (sval == 1) {            
                a.innerHTML = "<IMG SRC='http://asp1.krx.co.kr/reference/images/tap_01_on.gif' BORDER='0' onClick='change_id(1);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_02_off.gif' BORDER='0' onClick='change_id(2);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_03_off.gif' BORDER='0' onClick='change_id(3);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_04_off.gif' BORDER='0' onClick='change_id(4);' style='cursor:hand;'>";
                timeByConclude.style.visibility = "hidden";
                dailyStock.style.visibility = "hidden";
                askPrice.style.visibility = "visible";
                coTrade.style.visibility = "hidden";
        
        }else if (sval == 2){
            a.innerHTML = "<IMG SRC='http://asp1.krx.co.kr/reference/images/tap_01_off.gif' BORDER='0' onClick='change_id(1);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_02_on.gif' BORDER='0' onClick='change_id(2);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_03_off.gif' BORDER='0' onClick='change_id(3);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_04_off.gif' BORDER='0' onClick='change_id(4);' style='cursor:hand;'>";
            timeByConclude.style.visibility = "visible";
            dailyStock.style.visibility = "hidden";
            askPrice.style.visibility = "hidden";
            coTrade.style.visibility = "hidden";
        }else if (sval == 3){
            a.innerHTML = "<IMG SRC='http://asp1.krx.co.kr/reference/images/tap_01_off.gif' BORDER='0' onClick='change_id(1);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_02_off.gif' BORDER='0' onClick='change_id(2);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_03_on.gif' BORDER='0' onClick='change_id(3);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_04_off.gif' BORDER='0' onClick='change_id(4);' style='cursor:hand;'>";
            timeByConclude.style.visibility = "hidden";
            dailyStock.style.visibility = "hidden";
            askPrice.style.visibility = "hidden";
            coTrade.style.visibility = "visible";
        }else{
            a.innerHTML = "<IMG SRC='http://asp1.krx.co.kr/reference/images/tap_01_off.gif' BORDER='0' onClick='change_id(1);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_02_off.gif' BORDER='0' onClick='change_id(2);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_03_off.gif' BORDER='0' onClick='change_id(3);' style='cursor:hand;'><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_04_on.gif' BORDER='0' onClick='change_id(4);' style='cursor:hand;'>";
            timeByConclude.style.visibility = "hidden";
            dailyStock.style.visibility = "visible";
            askPrice.style.visibility = "hidden";
            coTrade.style.visibility = "hidden";
        }
        preSval = sval;
    }
}
</script>

</head>
<body onload="SetFunction();SendRequest()">
	<table width="620" border="0" cellspacing="0" cellpadding="0">
		<tr> 
			<td width="215" height= "252" align="center" background="http://asp1.krx.co.kr/reference/images/graph_bg.gif" id="gpDisp"> 
				&nbsp;
			</td>
			<td width="405" align ="right" id=juka valign="top">
				<table width=390 border=0 cellspacing=0 cellpadding=0 bgcolor="EEF9F9">
					<tr>
						<td height='2' bgColor='E4D3C9'></td>
					</tr>
					<tr>
						<td height='2'></td>
					</tr>
					<tr>
						<td align="center" valign="center" height="210">
							<table width=380 border=0 cellspacing=1 cellpadding=1 id=stockInfo>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">종목명</font></td>
									<td width='30%' height= 22 align=center class="body_a">${map.stockprice.TBL_StockInfo.JongName }</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">현재가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.CurJuka}</td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">전일대비</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.Debi}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">전일종가</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.PrevJuka}</td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">거래량</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.Volume}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">거래대금</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.Money}</td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">시가</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.StartJuka}</td>
									<td colspan="2" width='50%' height= 22 align=right class="body_b"></td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">고가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.HighJuka}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">저가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.LowJuka}</td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">52주 최고</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.High52}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">52주 최저</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.Low52}</td></tr>
									<tr><td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">상한가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.UpJuka}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">하한가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.DownJuka}</td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">PER</font></td>
									<td width='30%' height= 22 align=right class="body_b">${map.stockprice.TBL_StockInfo.Per}</td>
									<td colspan="2" width='50%' height= 22 align=right class="body_b"></td>
								</tr>
								<tr>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">상장주식수</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.Amount}</td>
									<td width='20%' height= 22 align=center class="title_defult"><font class="FONT_title_defult">액면가</font></td>
									<td width='30%' height= 22 align=right class="body_a">${map.stockprice.TBL_StockInfo.FaceJuka}</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height='20' id=timezone align=right></td>
					</tr>
				</table>          
			</td>
			</tr>
	<tr> 
		<td width="615" align="right" colspan="2">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td width="100%" id="a">
						<IMG SRC='http://asp1.krx.co.kr/reference/images/tap_01_on.gif' BORDER='0' onClick='change_id(1);' style="cursor:hand;"><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_02_off.gif' BORDER='0' onClick='change_id(2);' style="cursor:hand;"><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_03_off.gif' BORDER='0' onClick='change_id(3);' style="cursor:hand;"><IMG SRC='http://asp1.krx.co.kr/reference/images/tap_04_off.gif' BORDER='0' onClick='change_id(4);' style="cursor:hand;">
					</td>
				</tr>
				<tr> 
					<td width="100%" height="340" align="center" valign="top">
						<table width="100%" height="100%" cellspacing="0" cellpadding="0" style="border-left:1px solid CCCCCC;border-right:1px solid CCCCCC;border-bottom:1px solid CCCCCC;">
							<tr> 
								<td width="100%" align="center">
								<!-- 코스닥 작업시작-->
									<div id="timeByConclude" style="position:absolute; left:2px; top:285px; width:600px; height:310px; z-index:1;visibility:hidden">
									<table cellspacing='0' cellpadding='0' width='600' align=center>
										<tr>
											<td>
												<table width='610' border='0' cellspacing='1' cellpadding='2' align=center id=TBL_TimeConclude>
													<tr>
														<td height='1' bgColor='81ACC6' colspan='10'></td>
													</tr>
													<tr height='23'>
														<td class="title_defult" align="center"><font class="FONT_title_defult">시간</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">체결가</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">전일대비</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매도호가</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매수호가</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">체결량</font></td>
													</tr>
													<c:forEach items="${map.stockprice.TBL_TimeConclude.TBL_TimeConclude }" var="list" varStatus="count">
														<tr height='23'>
														<td class="body_${count.count%2 }" align='center'><font class="FONT_body_0">${list.time}</font></td>
														<td class="body_${count.count%2 }" align='right'><font class="FONT_body_0">${list.negoprice}</font>&nbsp;&nbsp</td>
														<td class="body_${count.count%2 }" align='right'>
															<table cellspacing='0' cellpadding='0' width='100%'>
															<tr>
																<c:if test="${list.Dungrak == 1}"><c:set var="debi_color" value="red" /><c:set var="debi_direct" value="↑" /></c:if>
																<c:if test="${list.Dungrak == 2}"><c:set var="debi_color" value="red" /><c:set var="debi_direct" value="▲" /></c:if>
																<c:if test="${list.Dungrak == 3}"><c:set var="debi_color" value="black" /><c:set var="debi_direct" value="" /></c:if>
																<c:if test="${list.Dungrak == 4}"><c:set var="debi_color" value="blue" /><c:set var="debi_direct" value="↓" /></c:if>
																<c:if test="${list.Dungrak == 5}"><c:set var="debi_color" value="blue" /><c:set var="debi_direct" value="▼" /></c:if>
																<td ALIGN=LEFT WIDTH=20></td>
																<td ALIGN=RIGHT ><font class="FONT_body_0"><font color="${debi_color }">${debi_direct } ${list.Debi }</font></font>&nbsp;&nbsp;</td>
															</tr>
															</table>
														</td>
														<td class="body_${count.count%2 }" align='right'><font class="FONT_body_0">${list.sellprice}</font>&nbsp;&nbsp</td>
														<td class="body_${count.count%2 }" align='right'><font class="FONT_body_0">${list.buyprice}</font>&nbsp;&nbsp</td>
														<td class="body_${count.count%2 }" align='right'><font class="FONT_body_0">${list.amount}</font>&nbsp;&nbsp</td>
													</tr>
													</c:forEach>
													<tr>
														<td colspan="10" height='1' bgcolor="D0D0D0"></td>
													</tr>
		
												</table>
											</td>
										</tr>
										<tr>
											<td height="60" valign="center" align="center" background="">
												<table width="90" height="20" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="center"><a href="http://km.krx.co.kr" target="_blank" class="kosdaq">코스닥시장 제공</a></td>
													</tr>
												</table>    
											</td>
										</tr>
									</table>
									</div>
		
									<div id="dailyStock" style="position:absolute; left:3px; top:290px; width:468px; height:155px; z-index:1;visibility:hidden">
									<table border="0" cellspacing="0" cellpadding="0" width='610'>
										<tr>
											<td>
												<table width="610" height="265" border="0" cellspacing="1" cellpadding="2" align=center id=TBL_DailyStock>
												<tr>
													<td height="1" class="title_defult" colspan="8"></td>
											  </tr> 
											   <tr>
													<td class="title_defult" align="center" height="22"><font class="FONT_title_defult">일자</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">종가</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">전일대비</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">시가</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">고가</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">저가</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">거래량</font></td>
													<td class="title_defult" align="center"><font class="FONT_title_defult">거래대금</font></td>
												</tr>
												<c:forEach items="${map.stockprice.TBL_DailyStock.DailyStock }" var="list" varStatus="count">
													<tr>
														<td class="body_${count.count%2 }" align="center"><font class="FONT_body_1">${list.day_Date }</font></td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_EndPrice }</font></td>
														<td class="body_${count.count%2 }" align="right">
															<table cellspacing="0" cellpadding="0" width="100%">
															<tr>
																<c:if test="${list.day_Dungrak == 1}"><c:set var="day_debi_color" value="red" /><c:set var="day_debi_direct" value="↑" /></c:if>
																<c:if test="${list.day_Dungrak == 2}"><c:set var="day_debi_color" value="red" /><c:set var="day_debi_direct" value="▲" /></c:if>
																<c:if test="${list.day_Dungrak == 3}"><c:set var="day_debi_color" value="black" /><c:set var="day_debi_direct" value="" /></c:if>
																<c:if test="${list.day_Dungrak == 4}"><c:set var="day_debi_color" value="blue" /><c:set var="day_debi_direct" value="↓" /></c:if>
																<c:if test="${list.day_Dungrak == 5}"><c:set var="day_debi_color" value="blue" /><c:set var="day_debi_direct" value="▼" /></c:if>
																<td ALIGN="LEFT" WIDTH="20">&nbsp;</td>
																<td ALIGN="RIGHT"><font class="FONT_body_${count.count%2 }"><font color="${day_debi_color}">${day_debi_direct} ${list.day_getDebi }</font></font>&nbsp;&nbsp;</td>
															</tr>
															</table>
														</td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_Start}</font></td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_High}</font></td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_Low}</font></td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_Volume}</font></td>
														<td class="body_${count.count%2 }" align="right"><font class="FONT_body_1">${list.day_getAmount }</font></td>
													</tr>
												</c:forEach>
												<tr>
													<td colspan="8" height='1' bgcolor="D0D0D0"></td>
												</tr>
		
											</table>
											</td>
										</tr>
										<tr>
											<td height="60" valign="center" align="center" background="">
												<table width="90" height="20" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="center"><a href="http://km.krx.co.kr" target="_blank" class="kosdaq">코스닥시장 제공</a></td>
													</tr>
												</table>    
											</td>
										</tr>
									</table>
									</div>
		
									<div id="askPrice" style="position:absolute; left:2px; top:295px; width:468px; height:155px; z-index:1">
									<table border="0" cellspacing="0" cellpadding="0" width="612" height="321" background="http://asp1.krx.co.kr/reference/images/table_01_bg.jpg">
										<tr>
											<td valign="top" align="center">
												<table width="335"  border="0" cellspacing="1" cellpadding="2" id=TBL_Hoga>
													<tr>
														<td colspan="4" height='1' class="title_defult"></td>
													</tr>
													<tr>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매도잔량</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매도호가</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매수호가</font></td>
														<td class="title_defult" align="center"><font class="FONT_title_defult">매수잔량</font></td>
													</tr>
													<tr>
														<td class="body_1" align="center"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTd2Col">${map.stockprice.TBL_Hoga.medoJan0 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.medoHoka0 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.mesuHoka0 }</font></td>
														<td class="body_1" align="right">${map.stockprice.TBL_Hoga.mesuJan0 }</td>
													</tr>
													<tr>
														<td class="body_0" align="center"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTd2Col">${map.stockprice.TBL_Hoga.medoJan1 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.medoHoka1 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.mesuHoka1 }</font></td>
														<td class="body_0" align="right">${map.stockprice.TBL_Hoga.mesuJan1 }</td>
													</tr>
													<tr>
														<td class="body_1" align="center"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTd2Col">${map.stockprice.TBL_Hoga.medoJan2 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.medoHoka2 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.mesuHoka2 }</font></td>
														<td class="body_1" align="right">${map.stockprice.TBL_Hoga.mesuJan2 }</td>
													</tr>
													<tr>
														<td class="body_0" align="center"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTd2Col">${map.stockprice.TBL_Hoga.medoJan3 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.medoHoka3 }</font></td>
														<td class="kdaqTitle2Bg" align="center" height="19"><font color="#404040" face="돋움" style="font-size:9pt;"  class="kdaqTitle2Col">${map.stockprice.TBL_Hoga.mesuHoka3 }</font></td>
														<td class="body_0" align="right">${map.stockprice.TBL_Hoga.mesuJan3 }</td>
													</tr>
													<tr>
														<td colspan="5" height='1' bgcolor="D0D0D0"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									</div>
									<div id="coTrade" style="position:absolute; left:0px; top:295px; width:615px; height:310px; z-index:1;visibility:hidden">
									<table border="0" cellspacing="0" cellpadding="0" width="613" height="321" background="">
										<tr>
											<td height="50">&nbsp;</td>
										</tr>
										<tr>
											<td valign="center" align="center">
												<table width="300"  border="0" cellspacing="1" cellpadding="2" id=TBL_AskPrice>
													<tr>
														<td colspan="4" height='1' class="title_defult"></td>
													</tr>
													<tr>
														<td colspan="2" class="title_defult" align="center" height="22"><font class="FONT_title_defult">매도 상위</font></td>
														<td colspan="2" class="title_defult" align="center"><font class="FONT_title_defult">매수 상위</font></td>
													</tr>
													<tr>
														<td class="kdaqTitle2Bg" align="center" height="22"><font class="FONT_Title2Col">증권사</font></td>
														<td class="kdaqTitle2Bg" align="center"><font class="FONT_Title2Col">거래량</font></td>
														<td class="kdaqTitle2Bg" align="center"><font class="FONT_Title2Col">증권사</font></td>
														<td class="kdaqTitle2Bg" align="center"><font class="FONT_Title2Col">거래량</font></td>
													</tr>
													<c:forEach items="${map.stockprice.TBL_AskPrice.AskPrice }" var="list" varStatus="count">
														<tr>
															<td class="body_${count.count%2 }"  align="center" height="19"><font color="#404040" face="굴림" style="font-size:9pt;"  class="kdaqTd2Col">${list.member_memdoMem }</font></td>
															<td class="body_${count.count%2 }"  align="right"><font color="#404040" face="굴림" style="font-size:9pt;"  class="kdaqTd2Col">&nbsp;</font>${list.member_memdoVol }</td>
															<td class="body_${count.count%2 }"  align="center" height="19"><font color="#404040" face="굴림" style="font-size:9pt;"  class="kdaqTd2Col">${list.member_memsoMem }</font></td>
															<td class="body_${count.count%2 }"  align="right"><font color="#404040" face="굴림" style="font-size:9pt;"  class="kdaqTd2Col">&nbsp;</font>${list.member_mesuoVol }</td>
														</tr>
													</c:forEach>
		
													<tr>
														<td colspan="4" height='1' bgcolor="D0D0D0"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="50" valign="center" align="center">
												<table width="90" height="20" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="center"><a href="http://km.krx.co.kr" target="_blank" class="kosdaq">코스닥시장 제공</a></td>
													</tr>
												</table>    
											</td>
										</tr>
									</table>
									</div>
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>
	</tr>
</table>	
</body>
</html>