<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="euc-kr"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="goods" value="${goodsMap.goods}"/>
<c:set var="imageFileList" value="${goodsMap.imageFileList}"/>

<c:choose>
    <c:when test='${not empty goods.goodsStatus}'>
        <script>
            window.onload = function () {
                init();
            }

            function init() {
                var frm_mod_goods = document.frm_mod_goods;
                var h_goods_status = frm_mod_goods.h_goods_status;
                var goods_status = h_goods_status.value;
                var select_goods_status = frm_mod_goods.goods_status;
                select_goods_status.value = goods_status;
            }
        </script>
    </c:when>
</c:choose>
<script type="text/javascript">
    function fn_modify_goods(goodsId, attribute) {
        var frm_mod_goods = document.frm_mod_goods;
        var value = "";
        if (attribute == 'goodsSort') {
            value = frm_mod_goods.goodsSort.value;
        } else if (attribute == 'goodsTitle') {
            value = frm_mod_goods.goodsTitle.value;
        } else if (attribute == 'goodsWriter') {
            value = frm_mod_goods.goodsWriter.value;
        } else if (attribute == 'goodsPublisher') {
            value = frm_mod_goods.goodsPublisher.value;
        } else if (attribute == 'goodsPrice') {
            value = frm_mod_goods.goodsPrice.value;
        } else if (attribute == 'goodsSalesPrice') {
            value = frm_mod_goods.goodsSalesPrice.value;
        } else if (attribute == 'goodsPoint') {
            value = frm_mod_goods.goodsPoint.value;
        } else if (attribute == 'goodsPublishedDate') {
            value = frm_mod_goods.goodsPublishedDate.value;
        } else if (attribute == 'goodsPageTotal') {
            value = frm_mod_goods.goodsPageTotal.value;
        } else if (attribute == 'goodsIsbn') {
            value = frm_mod_goods.goodsIsbn.value;
        } else if (attribute == 'goodsDeliveryPrice') {
            value = frm_mod_goods.goodsDeliveryPrice.value;
        } else if (attribute == 'goodsDeliveryDate') {
            value = frm_mod_goods.goodsDeliveryDate.value;
        } else if (attribute == 'goodsStatus') {
            value = frm_mod_goods.goodsStatus.value;
        } else if (attribute == 'goodsContentsOrder') {
            value = frm_mod_goods.goodsContentsOrder.value;
        } else if (attribute == 'goodsWriterIntro') {
            value = frm_mod_goods.goodsWriterIntro.value;
        } else if (attribute == 'goodsIntro') {
            value = frm_mod_goods.goodsIntro.value;
        } else if (attribute == 'publisherComment') {
            value = frm_mod_goods.publisherComment.value;
        } else if (attribute == 'goodsRecommendation') {
            value = frm_mod_goods.goodsRecommendation.value;
        }

        $.ajax({
            type: "post",
            async: false, //false�� ��� ��������� ó���Ѵ�.
            url: "${contextPath}/admin/goods/modifyGoodsInfo.do",
            data: {
                goodsId: goodsId,
                attribute: attribute,
                value: value
            },
            success: function (data, textStatus) {
                if (data.trim() == 'modSuccess') {
                    alert("��ǰ ������ �����߽��ϴ�.");
                } else if (data.trim() == 'failed') {
                    alert("�ٽ� �õ��� �ּ���.");
                }

            },
            error: function (data, textStatus) {
                alert("������ �߻��߽��ϴ�." + data);
            },
            complete: function (data, textStatus) {
                //alert("�۾����Ϸ� �߽��ϴ�");

            }
        }); //end ajax
    }


    function readURL(input, preview) {
        //  alert(preview);
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + preview).attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    var cnt = 1;

    function fn_addFile() {
        $("#d_file").append("<br>" + "<input  type='file' name='detail_image" + cnt + "' id='detail_image" + cnt + "'  onchange=readURL(this,'previewImage" + cnt + "') />");
        $("#d_file").append("<img  id='previewImage" + cnt + "'   width=200 height=200  />");
        $("#d_file").append("<input  type='button' value='�߰�'  onClick=addNewImageFile('detail_image" + cnt + "','${imageFileList[0].goodsId}','detail_image')  />");
        cnt++;
    }

    function modifyImageFile(fileId, goods_id, image_id, fileType) {
        // alert(fileId);
        var form = $('#FILE_FORM')[0];
        var formData = new FormData(form);
        formData.append("goodsFileName", $('#' + fileId)[0].files[0]);
        formData.append("goodsId", goods_id);
        formData.append("imageId", image_id);
        formData.append("fileType", fileType);

        $.ajax({
            url: '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
            processData: false,
            contentType: false,
            data: formData,
            type: 'POST',
            success: function (result) {
                alert("�̹����� �����߽��ϴ�!");
            }
        });
    }

    function addNewImageFile(fileId, goods_id, fileType) {
        //  alert(fileId);
        var form = $('#FILE_FORM')[0];
        var formData = new FormData(form);
        formData.append("uploadFile", $('#' + fileId)[0].files[0]);
        formData.append("goodsId", goods_id);
        formData.append("fileType", fileType);

        $.ajax({
            url: '${contextPath}/admin/goods/addNewGoodsImage.do',
            processData: false,
            contentType: false,
            data: formData,
            type: 'post',
            success: function (result) {
                alert("�̹����� �����߽��ϴ�!");
            }
        });
    }

    function deleteImageFile(goods_id, image_id, imageFileName, trId) {
        var tr = document.getElementById(trId);

        $.ajax({
            type: "post",
            async: true, //false�� ��� ��������� ó���Ѵ�.
            url: "${contextPath}/admin/goods/removeGoodsImage.do",
            data: {
                goodsId: goodsId,
                imageId: imageId,
                imageFileName: imageFileName
            },
            success: function (data, textStatus) {
                alert("�̹����� �����߽��ϴ�!!");
                tr.style.display = 'none';
            },
            error: function (data, textStatus) {
                alert("������ �߻��߽��ϴ�." + textStatus);
            },
            complete: function (data, textStatus) {
                //alert("�۾����Ϸ� �߽��ϴ�");

            }
        }); //end ajax
    }
</script>

</HEAD>
<BODY>
<form name="frm_mod_goods" method=post>
    <DIV class="clear"></DIV>
    <!-- ���� ��� ���� �� -->
    <DIV id="container">
        <UL class="tabs">
            <li><A href="#tab1">��ǰ����</A></li>
            <li><A href="#tab2">��ǰ����</A></li>
            <li><A href="#tab3">��ǰ���ڼҰ�</A></li>
            <li><A href="#tab4">��ǰ�Ұ�</A></li>
            <li><A href="#tab5">���ǻ� ��ǰ ��</A></li>
            <li><A href="#tab6">��õ��</A></li>
            <li><A href="#tab7">��ǰ�̹���</A></li>
        </UL>
        <DIV class="tab_container">
            <DIV class="tab_content" id="tab1">
                <table>
                    <tr>
                        <td width=200>��ǰ�з�</td>
                        <td width=500>
                            <select name="goodsSort">
                                <c:choose>
                                    <c:when test="${goods.goodsSort=='��ǻ�Ϳ� ���ͳ�' }">
                                        <option value="��ǻ�Ϳ� ���ͳ�" selected>��ǻ�Ϳ� ���ͳ�</option>
                                        <option value="������ ���">������ ���</option>
                                    </c:when>
                                    <c:when test="${goods.goodsSort=='������ ���' }">
                                        <option value="��ǻ�Ϳ� ���ͳ�">��ǻ�Ϳ� ���ͳ�</option>
                                        <option value="������ ���" selected>������ ���</option>
                                    </c:when>
                                </c:choose>
                            </select>
                        </td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsSort')"/>
                        </td>
                    </tr>
                    <tr>
                        <td>��ǰ�̸�</td>
                        <td><input name="goodsTitle" type="text" size="40" value="${goods.goodsTitle }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsTitle')"/>
                        </td>
                    </tr>

                    <tr>
                        <td>����</td>
                        <td><input name="goodsWriter" type="text" size="40" value="${goods.goodsWriter }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsWriter')"/>
                        </td>

                    </tr>
                    <tr>
                        <td>���ǻ�</td>
                        <td><input name="goodsPublisher" type="text" size="40" value="${goods.goodsPublisher }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsPublisher')"/>
                        </td>

                    </tr>
                    <tr>
                        <td>��ǰ����</td>
                        <td><input name="goodsPrice" type="text" size="40" value="${goods.goodsPrice }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsPrice')"/>
                        </td>

                    </tr>

                    <tr>
                        <td>��ǰ�ǸŰ���</td>
                        <td><input name="goodsSalesPrice" type="text" size="40" value="${goods.goodsSalesPrice }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsSalesPrice')"/>
                        </td>

                    </tr>


                    <tr>
                        <td>��ǰ ���� ����Ʈ</td>
                        <td><input name="goodsPoint" type="text" size="40" value="${goods.goodsPoint }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsPoint')"/>
                        </td>

                    </tr>

                    <tr>
                        <td>��ǰ������</td>
                        <td>
                            <input name="goodsPublishedDate" type="date" value="${goods.goodsPublishedDate }"/>
                        </td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsPublishedDate')"/>
                        </td>

                    </tr>

                    <tr>
                        <td>��ǰ �� ��������</td>
                        <td><input name="goodsTotalPage" type="text" size="40" value="${goods.goodsTotalPage }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsTotalPage')"/>
                        </td>

                    </tr>

                    <tr>
                        <td>ISBN</td>
                        <td><input name="goodsIsbn" type="text" size="40" value="${goods.goodsIsbn }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsIsbn')"/>
                        </td>

                    </tr>
                    <tr>
                        <td>��ǰ ��ۺ�</td>
                        <td><input name="goodsDeliveryPrice" type="text" size="40"
                                   value="${goods.goodsDeliveryPrice }"/></td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsDeliveryPrice')"/>
                        </td>

                    </tr>
                    <tr>
                        <td>��ǰ ���� ������</td>
                        <td>
                            <input name="goodsDeliveryDate" type="date" value="${goods.goodsDeliveryDate }"/>
                        </td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsDeliveryDate')"/>
                        </td>

                    </tr>

                    <tr>
                        <td>��ǰ����</td>
                        <td>
                            <select name="goodsStatus">
                                <option value="bestseller">����Ʈ����</option>
                                <option value="steadyseller">���׵𼿷�</option>
                                <option value="newbook">�Ű�</option>
                                <option value="on_sale">�Ǹ���</option>
                                <option value="buy_out" selected>ǰ��</option>
                                <option value="out_of_print">����</option>
                            </select>
                            <input type="hidden" name="h_goods_status" value="${goods.goodsStatus }"/>
                        </td>
                        <td>
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsStatus')"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=3>
                            <br>
                        </td>
                    </tr>
                </table>
            </DIV>
            <DIV class="tab_content" id="tab2">
                <h4>å����</h4>
                <table>
                    <tr>
                        <td>��ǰ����</td>
                        <td><textarea rows="100" cols="80" name="goodsContentsOrder">
                            ${goods.goodsContentsOrder }
                        </textarea>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsContentsOrder')"/>
                        </td>
                    </tr>
                </table>
            </DIV>
            <DIV class="tab_content" id="tab3">
                <H4>��ǰ ���� �Ұ�</H4>
                <P>
                <table>
                    <tr>
                        <td>��ǰ ���� �Ұ�</td>
                        <td><textarea rows="100" cols="80" name="goodsWriterIntro">
                            ${goods.goodsWriterIntro }
                        </textarea>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsWriterIntro')"/>
                        </td>
                    </tr>
                </table>
                </P>
            </DIV>
            <DIV class="tab_content" id="tab4">
                <H4>��ǰ�Ұ�</H4>
                <P>
                <table>
                    <tr>
                        <td>��ǰ�Ұ�</td>
                        <td><textarea rows="100" cols="80" name="goodsIntro">
                            ${goods.goodsIntro }
                        </textarea>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsIntro')"/>
                        </td>
                    </tr>
                </table>
                </P>
            </DIV>
            <DIV class="tab_content" id="tab5">
                <H4>���ǻ� ��ǰ ��</H4>
                <P>
                <table>
                    <tr>
                        <td><textarea rows="100" cols="80" name="goodsPublisherComment">
                            ${goods.goodsPublisherComment }
                        </textarea>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsPublisherComment')"/>
                        </td>
                    </tr>
                </table>
                </P>
            </DIV>
            <DIV class="tab_content" id="tab6">
                <H4>��õ��</H4>
                <table>
                    <tr>
                        <td>��õ��</td>
                        <td><textarea rows="100" cols="80" name="goodsRecommendation">
                            ${goods.goodsRecommendation }
                        </textarea>
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="�����ݿ�"
                                   onClick="fn_modify_goods('${goods.goodsId }','goodsRecommendation')"/>
                        </td>
                    </tr>
                </table>
            </DIV>
            <DIV class="tab_content" id="tab7">
                <form id="FILE_FORM" method="post" enctype="multipart/form-data">
                    <h4>��ǰ�̹���</h4>
                    <table>
                        <tr>
                            <c:forEach var="item" items="${imageFileList }" varStatus="itemNum">
                            <c:choose>
                            <c:when test="${item.fileType=='main_image' }">
                        <tr>
                            <td>���� �̹���</td>
                            <td>
                                <input type="file" id="main_image" name="main_image"
                                       onchange="readURL(this,'preview${itemNum.count}');"/>
                                    <%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
                                <input type="hidden" name="goodsId" value="${item.goodsId}"/>
                                <br>
                            </td>
                            <td>
                                <img id="preview${itemNum.count }" width=200 height=200
                                     src="${contextPath}/download.do?goodsId=${item.goodsId}&goodsFileName=${item.fileName}"/>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                <input type="button" value="����"
                                       onClick="modifyImageFile('main_image','${item.goodsId}','${item.goodsId}','${item.fileType}')"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br>
                            </td>
                        </tr>
                        </c:when>
                        <c:otherwise>
                            <tr id="${itemNum.count-1}">
                                <td>�� �̹���${itemNum.count-1 }</td>
                                <td>
                                    <input type="file" name="detail_image" id="detail_image"
                                           onchange="readURL(this,'preview${itemNum.count}');"/>
                                        <%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
                                    <input type="hidden" name="goodsId" value="${item.goodsId }"/>
                                    <br>
                                </td>
                                <td>
                                    <img id="preview${itemNum.count }" width=200 height=200
                                         src="${contextPath}/download.do?goodsId=${item.goodsId}&goodsFileName=${item.fileName}">
                                </td>
                                <td>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <input type="button" value="����"
                                           onClick="modifyImageFile('detail_image','${item.goodsId}','${item.goodsId}','${item.fileType}')"/>
                                    <input type="button" value="����"
                                           onClick="deleteImageFile('${item.goodsId}','${item.goodsId}','${item.fileName}','${itemNum.count-1}')"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br>
                                </td>
                            </tr>
                        </c:otherwise>
                        </c:choose>
                        </c:forEach>
                        <tr align="center">
                            <td colspan="3">
                                <div id="d_file">
                                    <%-- <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align=center colspan=2>

                                <input type="button" value="�̹��������߰��ϱ�" onClick="fn_addFile()"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </DIV>
            <DIV class="clear"></DIV>
        </DIV>
    </DIV>

</form>