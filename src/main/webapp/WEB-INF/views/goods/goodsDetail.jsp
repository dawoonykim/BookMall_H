<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="goods" value="${goodsMap.goodsVO}"/>
<c:set var="imageList" value="${goodsMap.imageList }"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
    //치환 변수 선언합니다.
    //pageContext.setAttribute("crcn", "\r\n"); //개행문자
    pageContext.setAttribute("crcn", "\n"); //Ajax로 변경 시 개행 문자
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>
<head>
    <style>
        #layer {
            z-index: 2;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
        }

        #popup {
            z-index: 3;
            position: fixed;
            text-align: center;
            left: 50%;
            top: 45%;
            width: 300px;
            height: 200px;
            background-color: #ccffff;
            border: 3px solid #87cb42;
        }

        #close {
            z-index: 4;
            float: right;
        }

        #goodsImage {
            float: left;
            width: 15%;
            clear: both;
        }

        #detail_table {
            float: right;
            width: 82%;
        }
    </style>
    <script type="text/javascript">
        var contextPath = "${contextPath}";
        function add_cart(goods_id) {
            $.ajax({
                type: "post",
                async: false, //false인 경우 동기식으로 처리한다.
                url: "${contextPath}/cart/addGoodsInCart.do",
                data: {
                    goodsId: goods_id
                },
                success: function (data, textStatus) {
                    //alert(data);
                    //	$('#message').append(data);
                    if (data.trim() == 'addSuccess') {
                        imagePopup('open', '.layer01');
                    } else if (data.trim() == 'alreadyExisted') {
                        alert("이미 카트에 등록된 상품입니다.");
                    }

                },
                error: function (data, textStatus) {
                    alert("로그인하셔야 합니다.");
                    window.location.href = "${contextPath}/member/loginForm.do";
                },
                complete: function (data, textStatus) {
                    //alert("작업을완료 했습니다");
                }
            }); //end ajax
        }

        function imagePopup(type) {
            if (type == 'open') {
                // 팝업창을 연다.
                jQuery('#layer').attr('style', 'visibility:visible');

                // 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
                jQuery('#layer').height(jQuery(document).height());
            } else if (type == 'close') {

                // 팝업창을 닫는다.
                jQuery('#layer').attr('style', 'visibility:hidden');
            }
        }

        function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
            var _isLogOn=document.getElementById("isLogOn");
            var isLogOn=_isLogOn.value;
            console.log("여기까지 도달했습니다1.")
            if(isLogOn=="false" || isLogOn=='' ){
                alert("로그인 후 주문이 가능합니다!!!");
            }
            console.log("여기까지 도달했습니다2.")

            var total_price,final_total_price;
            var order_goods_qty=document.getElementById("order_goods_qty");

            var formObj=document.createElement("form");
            var i_goods_id = document.createElement("input");
            var i_goods_title = document.createElement("input");
            var i_goods_sales_price=document.createElement("input");
            var i_fileName=document.createElement("input");
            var i_order_goods_qty=document.createElement("input");
            console.log("여기까지 도달했습니다3.")
            i_goods_id.name="goodsId";
            i_goods_title.name="goodsTitle";
            i_goods_sales_price.name="goodsSalesPrice";
            i_fileName.name="goodsFileName";
            i_order_goods_qty.name="orderGoodsQty";
            console.log("여기까지 도달했습니다4.")
            i_goods_id.value=goods_id;
            console.log("여기까지 도달했습니다5-1.")
            i_order_goods_qty.value=orderGoodsQty.value;
            console.log("여기까지 도달했습니다5-2.")
            i_goods_title.value=goods_title;
            console.log("여기까지 도달했습니다5-3.")
            i_goods_sales_price.value=goods_sales_price;
            console.log("여기까지 도달했습니다5-4.")
            i_fileName.value=fileName;
            console.log("여기까지 도달했습니다5-5.")
            formObj.appendChild(i_goods_id);
            formObj.appendChild(i_goods_title);
            formObj.appendChild(i_goods_sales_price);
            formObj.appendChild(i_fileName);
            formObj.appendChild(i_order_goods_qty);
            console.log("여기까지 도달했습니다6.")
            document.body.appendChild(formObj);
            formObj.method="post";
            formObj.action="${contextPath}/order/orderEachGoods.do";
            formObj.submit();
        }
    </script>
</head>
<body>
<hgroup>
    <h1>컴퓨터와 인터넷</h1>
    <h2>국내외 도서 &gt; 컴퓨터와 인터넷 &gt; 웹 개발</h2>
    <h3>${goods.goodsTitle }</h3>
    <h4>${goods.goodsWriter} &nbsp; 저| ${goods.goodsPublisher}</h4>
</hgroup>
<div id="goodsImage">
    <figure>
        <img alt="HTML5 &amp; CSS3"
             src="${contextPath}/thumbnails.do?goodsId=${goods.goodsId}&goodsFileName=${goods.goodsFileName}">
    </figure>
</div>

<div id="detail_table">
    <table>
        <tbody>
        <tr>
            <td class="fixed">정가</td>
            <td class="active"><span>
					   <fmt:formatNumber value="${goods.goodsPrice}" type="number" var="goods_price"/>
				         ${goods_price}원
					</span></td>
        </tr>
        <tr class="dot_line">
            <td class="fixed">판매가</td>
            <td class="active"><span>
					   <fmt:formatNumber value="${goods.goodsPrice*0.9}" type="number" var="discounted_price"/>
				         ${discounted_price}원(10%할인)</span></td>
        </tr>
        <tr>
            <td class="fixed">포인트적립</td>
            <td class="active">${goods.goodsPoint}P(10%적립)</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed">포인트 추가적립</td>
            <td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P추가적립 편의점 배송 이용시 300P 추가적립</td>
        </tr>
        <tr>
            <td class="fixed">발행일</td>
            <td class="fixed">
                <c:set var="pub_date" value="${goods.goodsPublishedDate}"/>
                <c:set var="arr" value="${fn:split(pub_date,' ')}"/>
                <c:out value="${arr[0]}"/>
            </td>
        </tr>
        <tr>
            <td class="fixed">페이지 수</td>
            <td class="fixed">${goods.goodsTotalPage}쪽</td>
        </tr>
        <tr class="dot_line">
            <td class="fixed">ISBN</td>
            <td class="fixed">${goods.goodsIsbn}</td>
        </tr>
        <tr>
            <td class="fixed">배송료</td>
            <td class="fixed"><strong>${goods.goodsDeliveryPrice}</strong></td>
        </tr>
        <tr>
            <td class="fixed">배송안내</td>
            <td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br> <strong>[휴일배송]</strong>
                휴일에도 배송받는 Bookshop
            </TD>
        </tr>
        <tr>
            <td class="fixed">도착예정일</td>
            <td class="fixed">지금 주문 시 내일 도착 예정</td>
        </tr>
        <tr>
            <td class="fixed">수량</td>
            <td class="fixed">
                <select style="width: 60px;" id="orderGoodsQty">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                </select>
            </td>
        </tr>
        </tbody>
    </table>
    <ul>
        <li><a class="buy"
               href="javascript:fn_order_each_goods('${goods.goodsId }','${goods.goodsTitle }','${goods.goodsSalesPrice}','${goods.goodsFileName}');">구매하기 </a>
        </li>
        <li><a class="cart" href="javascript:add_cart('${goods.goodsId }')">장바구니</a></li>

    </ul>
</div>
<div class="clear"></div>
<!-- 내용 들어 가는 곳 -->
<div id="container">
    <ul class="tabs">
        <li><a href="#tab1">책소개</a></li>
        <li><a href="#tab2">저자소개</a></li>
        <li><a href="#tab3">책목차</a></li>
        <li><a href="#tab4">출판사서평</a></li>
        <li><a href="#tab5">추천사</a></li>
        <li><a href="#tab6">리뷰</a></li>
    </ul>
    <div class="tab_container">
        <div class="tab_content" id="tab1">
            <h4>책소개</h4>
            <p>${fn:replace(goods.goodsIntro,crcn,br)}</p>
            <c:forEach var="image" items="${imageList }">
                <img
                        src="${contextPath}/download.do?goodsId=${goods.goodsId}&goodsFileName=${image.fileName}">
            </c:forEach>
        </div>
        <div class="tab_content" id="tab2">
            <h4>저자소개</h4>
            <p>
            <div class="writer">저자 : ${goods.goodsWriter}</div>
            <p>${fn:replace(goods.goodsWriter,crcn,br) }</p>

        </div>
        <div class="tab_content" id="tab3">
            <h4>책목차</h4>
            <p>${fn:replace(goods.goodsContentsOrder,crcn,br)}</p>
        </div>
        <div class="tab_content" id="tab4">
            <h4>출판사서평</h4>
            <p>${fn:replace(goods.goodsPublisherComment ,crcn,br)}</p>
        </div>
        <div class="tab_content" id="tab5">
            <h4>추천사</h4>
            <p>${fn:replace(goods.goodsRecommendation,crcn,br) }</p>
        </div>
        <div class="tab_content" id="tab6">
            <h4>리뷰</h4>
        </div>
    </div>
</div>
<div class="clear"></div>
<div id="layer" style="visibility: hidden">
    <!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
    <div id="popup">
        <!-- 팝업창 닫기 버튼 -->
        <a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"> <img
                src="${contextPath}/resources/image/close.png" id="close"/>
        </a> <br/> <font size="12" id="contents">장바구니에 담았습니다.</font><br>
        <form action='${contextPath}/cart/myCartList.do'>
            <input type="submit" value="장바구니 보기">
        </form>
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>