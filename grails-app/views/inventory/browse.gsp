<%@ page import="org.pih.warehouse.core.Location" %>
<%@ page import="org.pih.warehouse.product.Product" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${warehouse.message(code: 'inventory.label', default: 'Inventory')}" />
        <title><warehouse:message code="inventory.browse.label" default="Browse inventory"/></title>
    </head>
    <body>
    
    	
        <div class="body">
            <g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${commandInstance}">
	            <div class="errors">
	                <g:renderErrors bean="${commandInstance}" as="list" />
	            </div>
            </g:hasErrors>   
            
            
			<div>
				<!-- Inventory Browser -->
	        	<g:set var="varStatus" value="${0}"/>
	        	<g:set var="totalProducts" value="${0}"/> 							        	
        	
	            <div class="yui-gf">
					<div class="yui-u first">
	       				<g:render template="filters" model="[commandInstance:commandInstance, quickCategories:quickCategories]"/>						

					</div>
					<div class="yui-u">
									
						<g:set var="showQuantity" value="${(params.max as int) <= 25}"/>	

						<g:if test="${!showQuantity }">
							<div class="notice">
								<warehouse:message code="inventory.tooManyProducts.message"></warehouse:message>
							</div>
						</g:if>
						<div class="box">
                            <h2>
                                <a href="#tabs-1">
                                    <g:set var="rangeBegin" value="${Integer.valueOf(params.offset)+1 }"/>
                                    <g:set var="rangeEnd" value="${(Integer.valueOf(params.max) + Integer.valueOf(params.offset))}"/>
                                    <g:set var="totalResults" value="${numProducts }"/>

                                    <g:if test="${totalResults < rangeEnd || rangeEnd < 0}">
                                        <g:set var="rangeEnd" value="${totalResults }"/>
                                    </g:if>
                                    <g:if test="${totalResults > 0 }">
                                        <warehouse:message code="inventory.browseTab.label" args="[rangeBegin, rangeEnd, totalResults]"/>
                                    </g:if>
                                    <g:else>
                                        <warehouse:message code="inventory.showingNoResults.label" default="Showing 0 results"/>
                                    </g:else>
                                    <g:if test="${commandInstance?.searchTerms}">
                                        "${commandInstance.searchTerms }"
                                    </g:if>
                                </a>
                            </h2>
							<div id="tabs-1" style="padding: 0px;">
					            <form id="inventoryActionForm" name="inventoryActionForm" action="createTransaction" method="POST">
					                <table id="inventory-browser-table" border="0"> 
										<thead> 
				           					<tr>
				           						<th>
				           						
				           						</th>
				           						<td class="middle">
					           						<g:render template="./actions" model="[]"/>
				           						</td>
												<th class="center middle" style="width: 1%">
													<input type="checkbox" id="toggleCheckbox">	
												</th>
												<th class="middle" style="width: 1%">
													<warehouse:message code="product.productCode.label"/>
												</th>
												<th class="middle">
													<warehouse:message code="product.name.label"/>
												</th>
												<th class="middle">
													<warehouse:message code="product.manufacturer.label"/>
												</th>
												<th class="middle">
													<warehouse:message code="product.brandName.label"/>
												</th>
												<th class="middle">
													<warehouse:message code="product.manufacturerCode.label"/>
												</th>
												<th class="center" style="width: 7%;">
													<warehouse:message code="inventory.qtyin.label"/>
												</th>
												<th class="center" style="width: 7%;">
													<warehouse:message code="inventory.qtyout.label"/>
												</th>
												<th class="center middle" style="width: 7%;">
													<warehouse:message code="default.qty.label"/>
												</th>
				           					</tr>
										</thead>
                                        <tbody>
                                            <g:if test="${commandInstance?.categoryToProductMap}">
                                                <g:each var="entry" in="${commandInstance?.categoryToProductMap}" status="i">
                                                   <g:set var="category" value="${entry.key }"/>
                                                   <g:set var="categoryInventoryItems" value="${commandInstance?.categoryToProductMap[entry.key]}"/>
                                                   <tr class="category-header">
                                                       <td colspan="11" style="padding:0; margin:0;">
                                                           <span class="fade">
                                                               <h2 style="border-top: 2px solid lightgrey;">
                                                                   <%--
                                                                   <g:checkBox id="${category?.id }" name="category.id"
                                                                       class="checkbox" style="top:0em;" checked="${false }"
                                                                           value="${category?.id }" />
                                                                   &nbsp;
                                                                   --%>
                                                                   <format:category category="${category }"/>
                                                                   (${categoryInventoryItems.size() })

                                                               </h2>
                                                           </span>

                                                       </td>
                                                   </tr>
                                                   <g:set var="counter" value="${0 }"/>
                                                   <g:each var="inventoryItem" in="${categoryInventoryItems}" status="status">
                                                       <g:if test="${inventoryItem.product }">
                                                           <%--<cache:render cachekey="${inventoryItem?.product?.id}" template="browseProduct" model="[counter:counter,inventoryItem:inventoryItem,cssClass:'product',showQuantity:showQuantity]" />--%>
                                                            <g:render template="browseProduct" model="[counter:counter,inventoryItem:inventoryItem,cssClass:'product',showQuantity:showQuantity]" />
                                                       </g:if>
                                                       <%--
                                                       <g:elseif test="${inventoryItem.productGroup }">
                                                           <g:render template="browseProductGroup" model="[counter:counter,inventoryItem:inventoryItem,cssClass:'productGroup']"/>
                                                       </g:elseif>
                                                       --%>
                                                       <g:set var="counter" value="${counter+1 }"/>

                                                   </g:each>
                                                </g:each>
										    </g:if>

                                            <g:if test="${numProducts == 0}">
												<tr>
													<td colspan="11" class="even center">
														<div class="fade empty">

                                                            <warehouse:message code="inventory.searchNoMatch.message" args="[commandInstance?.searchTerms?:'',format.metadata(obj:commandInstance?.categoryInstance)]"/>
														</div>
													</td>
												</tr>
                                            </g:if>
                                        </tbody>
									</table>

								</form>		
							</div>

						</div>
                        <div class="paginateButtons">
                            <g:paginate total="${numProducts}"
                                        action="browse" max="${params.max}" params="${[tag: params.tag, searchTerms: params.searchTerms, subcategoryId: params.subcategoryId].findAll {it.value}}"/>

                            <div class="right">
                                <warehouse:message code="inventory.browseResultsPerPage.label"/>:
                                <g:if test="${params.max != '10'}"><g:link action="browse" params="[max:10]">10</g:link></g:if><g:else><span class="currentStep">10</span></g:else>
                                <g:if test="${params.max != '25'}"><g:link action="browse" params="[max:25]">25</g:link></g:if><g:else><span class="currentStep">25</span></g:else>
                                <g:if test="${params.max != '50'}"><g:link action="browse" params="[max:50]">50</g:link></g:if><g:else><span class="currentStep">50</span></g:else>
                                <g:if test="${params.max != '100'}"><g:link action="browse" params="[max:100]">100</g:link></g:if><g:else><span class="currentStep">100</span></g:else>
                                <g:if test="${params.max != '-1'}"><g:link action="browse" params="[max:-1]">${warehouse.message(code:'default.all.label') }</g:link></g:if><g:else><span class="currentStep">${warehouse.message(code:'default.all.label') }</span></g:else>
                            </div>
                        </div>
					</div>
				</div>    	
			</div>
		</div>
        <script src="${createLinkTo(dir:'js/jquery.nailthumb', file:'jquery.nailthumb.1.1.js')}" type="text/javascript" ></script>
        <script src="${createLinkTo(dir:'js/jquery.tagcloud', file:'jquery.tagcloud.js')}" type="text/javascript" ></script>
		<script>
			$(document).ready(function() {
				$(".checkable a").click(function(event) {
					event.stopPropagation();
				});
				$('.checkable').toggle(
					function(event) {
						$(this).parent().find('input').click();
						//$(this).parent().addClass('checked');
						return false;
					},
					function(event) {
						$(this).parent().find('input').click();
						//$(this).parent().removeClass('checked');
						return false;
					}
				);

				
				//$(".megamenu").megamenu();
				
				$("#toggleCheckbox").click(function(event) {
                    var checked = ($(this).attr("checked") == 'checked');
		            $(".checkbox").attr("checked", checked);
				});


		    	//$(".tabs").tabs(
	    		//	{
	    		//		cookie: {
	    		//			// store cookie for a day, without, it would be a session cookie
	    		//			expires: 1
	    		//		}
	    		//	}
				//);


		    	$(".isRelated").hide();
		    	$(".expandable").click(function(event) {
			    	//$("#productGroup-"+event.target.id).css('background-color', '#E5ECF9');
			    	var isVisible = $(".productGroup-"+event.target.id).is(":visible");
			    	if (isVisible) { 
				    	$("#productGroup-"+event.target.id).removeClass("showRelated");
				    	$("#productGroup-"+event.target.id).addClass("hideRelated");
				    }
			    	else { 
				    	$("#productGroup-"+event.target.id).addClass("showRelated");
				    	$("#productGroup-"+event.target.id).removeClass("hideRelated");
			    	}
			    	//$("#productGroup-"+event.target.id).removeClass("hideRelated");
		    		$(".productGroup-"+event.target.id).toggle();
					
		    	});

		    	$('.nailthumb-container').nailthumb({ width : 20, height : 20 });
		    	$('.nailthumb-container-100').nailthumb({ width : 100, height : 100 });

                $("#tagcloud a").tagcloud({
                    size: {
                        start: 10,
                        end: 25,
                        unit: 'px'
                    },
                    color: {
                        start: "#CDE",
                        end: "#FS2"
                    }
                });

		    	function refreshQuantity() {
			    	$.each($(".quantityOnHand"), function(index, value) {
						//$(this).html('Loading ...');
						var productId = $(this).attr("data-product-id");
						$(this).load('${request.contextPath}/json/getQuantityOnHand?product.id='+productId+'&location.id=${session.warehouse.id}');									    		  
			    	});

			    	$.each($(".quantityToShip"), function(index, value) {
						//$(this).html('Loading ...');
						var productId = $(this).attr("data-product-id");
						$(this).load('${request.contextPath}/json/getQuantityToShip?product.id='+productId+'&location.id=${session.warehouse.id}');									    		  
			    	});

			    	$.each($(".quantityToReceive"), function(index, value) {
						//$(this).html('Loading ...');
						var productId = $(this).attr("data-product-id");
						$(this).load('${request.contextPath}/json/getQuantityToReceive?product.id='+productId+'&location.id=${session.warehouse.id}');									    		  
			    	});			    	
		    	}
				<g:if test="${showQuantity}">
					refreshQuantity();
				</g:if>
			    
			});	
		</script>
    </body>
</html>
