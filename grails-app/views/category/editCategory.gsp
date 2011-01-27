
<%@ page import="org.pih.warehouse.product.Category" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <!-- Specify content to overload like global navigation links, page titles, etc. -->
		<content tag="pageTitle"><g:message code="default.list.label" args="[entityName]" /></content>
    </head>
    <body>
        <div class="body">
			<div class="nav">            	
				<g:render template="nav"/>
           	</div>
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">        
            <%-- 
				<div>            	
	            	<span class="menuButton">
	            		<g:link class="new" action="create"><g:message code="default.add.label" args="['category']"/></g:link>
	            	</span>
	           	</div>
	           	--%>
	           	<table>
	           		<tr>
		           		<td valign="top">
			           		<g:form action="saveCategory">
			           			<fieldset>
			           				<legend>Edit category</legend>
			           				<table>
			           					<tr class="prop">
			           						<td class="name">
			           							<label>ID</label>
			           						</td>
			           						<td class="value">
						           				<g:hiddenField name="id" value="${categoryInstance?.id }"/>
						           				${categoryInstance?.id }
			           						</td>
			           					</tr>
			           					<tr class="prop">
			           						<td class="name">
			           							<label>Parent</label>
			           						</td>
			           						<td class="value">
		           								<select name="parentCategory.id">
		           									<option value="0">no parent</option>
		           									<g:render template="selectOptions" model="[category:rootCategory, selected:categoryInstance?.parentCategory, level: 1]"/>
		           								</select>
			           						</td>
			           					</tr>
			           					<tr class="prop">
			           						<td class="name">
			           							<label>Name</label>
			           						</td>
			           						<td class="value">
						           				<g:textField name="name" value="${categoryInstance?.name }"/>
			           						</td>
			           					</tr>
			           					<tr class="prop">
			           						<td class="name">
			           							<label>Children</label>
			           						</td>
			           						<td class="value">
			           							<table>			           							
				           							<g:each var="child" in="${categoryInstance?.categories }" status="status">
				           								<tr>
							           						<td>${child?.name }</td>
				           								</tr>
							           				</g:each>
						           				</table>
			           						</td>
			           					</tr>
			           					<tr class="prop">
			           						<td class="name">
	
			           						</td>
			           						<td class="value">
												
												<g:submitButton name="submit" value="Submit"/>
												
												&nbsp;
												
												<g:link action="tree">cancel</g:link>
												
			           						</td>
			           					</tr>
	
			           				</table>
			           			</fieldset>
	           				</g:form>
		           		</td>
	           		</tr>
	           	</table>
				
				
				<%-- 
	           	<table>
		           	<g:set var="counter" value="${1 }" /> 
					<g:each var="category" in="${org.pih.warehouse.product.Category.list().sort() { it?.categories?.size() }.reverse() }" status="status">
						<g:if test="${!category.parentCategory }">
							<tr>
								<td>
									<div style="padding-left: 25px;">
										<img src="${createLinkTo(dir:'images/icons/silk',file:'bullet_white.png')}" alt="Bullet" /> &nbsp;										 
										<g:if test="${!category.parentCategory }"><b>${category.name }</b></g:if> 
										<g:else>${category.name }</g:else>
										<g:link class="new" action="create" params="['parentCategory.id':category.id]"><g:message code="default.add.label" args="['category']"/></g:link>
										| 
										<g:link class="new" action="delete" params="['category.id':category.id]"><g:message code="default.delete.label" args="['category']"/></g:link>
									</div>
								</td>
							</tr>
							<g:each var="childCategory" in="${category.categories}">
								<tr>
									<td>							
										<div style="padding-left: 50px;">
											<img src="${createLinkTo(dir:'images/icons/silk',file:'bullet_white.png')}" alt="Bullet" /> &nbsp;
											
											<g:if test="${!childCategory.parentCategory }">
												<b>${childCategory.name }</b>
											</g:if>
											<g:else>
												${childCategory.name }
											</g:else>
											<g:link class="new" action="create" params="['parentCategory.id':childCategory.id]"><g:message code="default.add.label" args="['category']"/></g:link>
											| 
											<g:link class="new" action="delete" params="['category.id':childCategory.id]"><g:message code="default.delete.label" args="['category']"/></g:link>
											
											
										</div>
									</td>
								</tr>						
							</g:each>
						</g:if>
					</g:each>
				</table>
					--%>
			</div>         
        </div>
    </body>
</html>