<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  Content editor -->
<c:if test="${canEdit}">
	<jsp:directive.include file="./javascript-epiceditor.jsp" />
	<%-- Edit bar --%>
	<div class="container">
		<div class="navbar-fixed-bottom">
			<div class="navbar-inner">
				<div class="btn-group">
					<a id="btn-edit-content" class="btn btn-danger" href="#"><i class="icon-edit"></i><span id="btn-edit-content-caption"> <fmt:message bundle="${resourceBundle}" key="contentEditorEdit"/></span></a>
					<a id="btn-exitedit-content" class="btn btn-danger" style="display: none;" href="#"><i class="icon-exit"></i><span id="btn-edit-content-caption"> <fmt:message bundle="${resourceBundle}" key="contentEditorExit"/></span></a>
					<div id="buttonbar-editmode" style="display: none;">
						<a id="btn-edit-save" class="btn btn-important" href="#"><i class="icon-save"></i><span id="btn-edit-content-caption"> <fmt:message bundle="${resourceBundle}" key="contentEditorSave"/></span></a>
<%--						<a id="btn-edit-cut" class="btn btn-important" href="#"><i class="icon-cut"></i><span id="btn-edit-content-caption"> Kivágás</span></a> --%>
					</div>
				</div>
			</div>
			<div style="height: 160px;" id="markdownEditor"></div>
			<div style="display: none;" id="markdownContent">${node.properties['content']}</div>
		</div>
	</div>
	
	<fmt:message bundle="${resourceBundle}" key="communicationError" var="communicationError"/>
	<fmt:message bundle="${resourceBundle}" key="contentEditorSaveSuccesfull" var="contentEditorSaveSuccesfull"/>
	
	<script type="text/javascript">
	$(document).ready(function(){
		var opts = {
			container: 'markdownEditor',
			basePath: 'epiceditor',
			clientSideStorage: true,
			localStorageName: 'epiceditor',
			useNativeFullsreen: false,
			parser: marked,
			file: {
				name: 'markdownContent',
				defaultContent: '',
				autoSave: 1000
			},
			theme: {
				base:'/themes/base/epiceditor.css',
				preview:'/themes/preview/github.css',
				editor:'/themes/editor/epic-light.css'
			},
			focusOnLoad: false,
			shortcut: {
				modifier: 18,
				fullscreen: 70,
				preview: 80
			}
		}
		var editor = new EpicEditor(opts);
		$("#markdownEditor").hide();
		$("body").css("padding-bottom", "60px");
		
		// Edit button
		$("#btn-edit-content").click(function() {
			$("#btn-edit-content").hide();
			$("#btn-exitedit-content").show();
			$("body").css("padding-bottom", "220px");
			$("#markdownEditor").slideToggle("slow");
			$("#buttonbar-editmode").slideToggle("slow");

			editor.load(function () {
				editor.getElement("wrapper").style.height = "160px";
				editor.getElement("wrapperIframe").style.height = "160px";
				editor.getElement("editorIframe").style.height = "160px";
			});
			editor.importFile('markdownContent', $("#markdownContent").html());
			editor.on('save', function () {
				$("#indexContent").html(editor.exportFile('markdownContent', 'html'));
				$("#markdownContent").html(editor.exportFile('markdownContent'));
			}); 

		});

		$("#btn-exitedit-content").click(function() {
			$("#btn-edit-content").show();
			$("#btn-exitedit-content").hide();
			$("body").css("padding-bottom", "60px");
			$("#markdownEditor").slideToggle("slow");
			$("#buttonbar-editmode").slideToggle("slow");
			editor.unload();
		});
		
		// Save button
		$("#btn-edit-save").click(function(event) {
			event.preventDefault();
			$.ajax({
				url: "${node.path}",
				type: 'POST',
					headers: { 
					Accept : "application/json,*/*;q=0.9",
					contentType: "multipart/form-data"
				},
				data: { 
					"_charset_" : "utf-8",
					content: editor.exportFile('markdownContent') 
				}, 
				success : function(response) {
					bootbox.alert("${contentEditorSaveSuccesfull}");
				},
				error: function(jqXHR, textStatus, errorThrown){
					bootbox.alert("${communicationError}" + textStatus, errorThrown);
				}
			});
		});
	})
	</script>
</c:if>
