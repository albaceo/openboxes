<%@ page import="org.pih.warehouse.core.RoleType" %>
<!-- Only allow the originating warehouse to edit the shipment -->
<div id="shipment-action-menu" class="action-menu">
    <button class="action-btn">
        <img src="${resource(dir: 'images/icons/silk', file: 'bullet_arrow_down.png')}"/>
    </button>

    <div class="actions">
        <g:if test="${shipmentInstance?.destination?.id == session.warehouse.id}">
            <div class="action-menu-item">
                <g:link controller="shipment" action="list" params="[type: 'incoming']">
                    <img src="${createLinkTo(dir: 'images/icons', file: 'indent.gif')}" class="middle"/>&nbsp;
                    <warehouse:message code="shipping.listIncoming.label"/>
                </g:link>
            </div>
        </g:if>
        <g:else>
            <div class="action-menu-item">
                <g:link controller="shipment" action="list">
                    <img src="${createLinkTo(dir: 'images/icons', file: 'indent.gif')}" class="middle"/>&nbsp;
                    <warehouse:message code="shipping.listOutgoing.label"/>
                </g:link>
            </div>
        </g:else>
    <%--
            <div class="action-menu-item">
                <g:link controller="inventory" action="browse" params="['shipment.id':shipmentInstance?.id]">
                    <img src="${createLinkTo(dir: 'images/icons/silk', file: 'database.png')}" class="middle"/>&nbsp;
                    <warehouse:message code="shipping.viewInInventoryBrowser.label" default="View in inventory browser"/>
                </g:link>
            </div>
    --%>
        <div class="action-menu-item">
            <hr/>
        </div>
        <g:if test="${actionName != 'showDetails'}">
            <div class="action-menu-item">
                <g:link controller="shipment" action="showDetails" id="${shipmentInstance.id}">
                    <img src="${createLinkTo(dir: 'images/icons/silk', file: 'zoom.png')}" class="middle"/>&nbsp;
                    <g:if test="${request.request.requestURL.toString().contains('showDetails')}"><warehouse:message
                            code="shipping.showDetails.label"/></g:if>
                    <g:else><warehouse:message code="shipping.showDetails.label"/></g:else>
                </g:link>
            </div>
        </g:if>

        <g:if test="${shipmentInstance.hasShipped()}">
            <g:isUserInRole roles="[org.pih.warehouse.core.RoleType.ROLE_ADMIN]">
                <div class="action-menu-item">
                    <g:link controller="createShipmentWorkflow" action="createShipment" id="${shipmentInstance.id}">
                        <img src="${createLinkTo(dir: 'images/icons/silk', file: 'pencil.png')}" class="middle"/>&nbsp;
                        <g:if test="${request.request.requestURL.toString().contains('createShipment')}">
                            <warehouse:message code="shipping.editShipment.label"/>
                        </g:if>
                        <g:else><warehouse:message code="shipping.editShipment.label"/></g:else>
                    </g:link>
                </div>
            </g:isUserInRole>
        </g:if>

        <g:if test="${!shipmentInstance.hasShipped()}">
            <!-- you can only edit a shipment or its packing list if you are at the origin warehouse, or if the origin is not a warehouse, and you are at the destination warehouse -->
            <g:if test="${shipmentInstance?.origin?.id == session?.warehouse?.id || shipmentInstance?.destination?.id == session?.warehouse?.id}">
                <div class="action-menu-item">
                    <g:link controller="createShipmentWorkflow" action="createShipment" id="${shipmentInstance.id}">
                        <img src="${createLinkTo(dir: 'images/icons/silk', file: 'pencil.png')}" class="middle"/>&nbsp;
                        <g:if test="${request.request.requestURL.toString().contains('createShipment')}"><warehouse:message
                                code="shipping.editShipment.label"/></g:if>
                        <g:else><warehouse:message code="shipping.editShipment.label"/></g:else>
                    </g:link>
                </div>

                <div class="action-menu-item">
                    <g:link controller="createShipmentWorkflow" action="createShipment" event="enterTrackingDetails"
                            id="${shipmentInstance.id}">
                        <img src="${createLinkTo(dir: 'images/icons/silk', file: 'map.png')}" class="middle"/>&nbsp;
                        <warehouse:message code="shipping.enterTrackingDetails.label"/>
                    </g:link>
                </div>

                <div class="action-menu-item">
                    <g:link controller="createShipmentWorkflow" action="createShipment" event="enterContainerDetails"
                            id="${shipmentInstance?.id}" params="[skipTo: 'Packing']">
                        <img src="${createLinkTo(dir: 'images/icons/silk', file: 'package_add.png')}"
                             class="middle"/>&nbsp;
                        <warehouse:message code="shipping.editPackingList.label"/></g:link>
                </div>
            </g:if>
        </g:if>
        <div class="action-menu-item">
            <g:link controller="shipment" action="addDocument" id="${shipmentInstance.id}">
                <img src="${createLinkTo(dir: 'images/icons/silk', file: 'page_add.png')}"
                     class="middle"/>&nbsp;<warehouse:message code="shipping.uploadADocument.label"/></g:link>
        </div>

        <div class="action-menu-item">
            <g:link controller="shipment" action="addComment" id="${shipmentInstance.id}">
                <img src="${createLinkTo(dir: 'images/icons/silk', file: 'note_add.png')}"
                     class="middle"/>&nbsp;<warehouse:message code="shipping.addNote.label"/></g:link>
        </div>

        <div class="action-menu-item">
            <hr/>
        </div>

        <div class="action-menu-item">
            <g:link target="_blank" controller="report" action="printShippingReport"
                    params="['shipment.id': shipmentInstance?.id]">
                <img src="${createLinkTo(dir: 'images/icons', file: 'pdf.png')}" class="middle"/>&nbsp;
                <warehouse:message code="shipping.downloadPackingList.label"/>
                <span class="fade">(.pdf)</span>
            </g:link>
        </div>

        <div class="action-menu-item">
            <g:link target="_blank" controller="report" action="printPaginatedPackingListReport"
                    params="['shipment.id': shipmentInstance?.id]">
                <img src="${createLinkTo(dir: 'images/icons/silk', file: 'page_break.png')}" class="middle"/>&nbsp;
                <warehouse:message code="shipping.downloadPackingList.label"/>
                <span class="fade">(.pdf)</span>
            </g:link>
        </div>

        <div class="action-menu-item">
            <g:link controller="doc4j" action="downloadPackingList" id="${shipmentInstance?.id}">
                <img src="${createLinkTo(dir: 'images/icons/silk', file: 'page_white_excel.png')}"
                     class="middle"/>&nbsp;
                <warehouse:message code="shipping.downloadPackingList.label"/> <span class="fade">(.xls)</span>
            </g:link>
        </div>

        <div class="action-menu-item">
            <g:link controller="doc4j" action="downloadLetter" id="${shipmentInstance?.id}">
                <img src="${createLinkTo(dir: 'images/icons/silk', file: 'page_white_word.png')}" class="middle"/>&nbsp;
                <warehouse:message code="shipping.downloadLetter.label"/> <span class="fade">(.docx)</span>
            </g:link>
        </div>

        <g:isUserManager>
            <g:if test="${shipmentInstance?.origin?.id == session?.warehouse?.id || shipmentInstance?.destination?.id == session?.warehouse?.id}">
                <div class="action-menu-item">
                    <hr/>
                </div>

                <div class="action-menu-item">
                    <g:if test="${shipmentInstance?.isSendAllowed()}">
                        <g:link controller="createShipmentWorkflow" action="createShipment" event="sendShipment"
                                id="${shipmentInstance.id}" params="[skipTo: 'Sending']">
                            <img src="${createLinkTo(dir: 'images/icons', file: 'truck.png')}" class="middle"/>&nbsp;
                            <warehouse:message code="shipping.sendShipment.label"/>
                        </g:link>
                    <%-- old link
                    <g:link controller="shipment" action="sendShipment" id="${shipmentInstance.id}">
                      <img src="${createLinkTo(dir:'images/icons',file:'truck.png')}" class="middle" />&nbsp;
                      <warehouse:message code="shipping.sendShipment.label"/>
                    </g:link>
                    --%>
                    </g:if>
                    <g:else>
                        <g:set var="message" value="Shipment cannot be sent yet"/>
                        <g:if test="${shipmentInstance?.hasShipped()}">
                            <g:set var="message" value="Shipment has already been shipped!"/>
                        </g:if>
                        <g:elseif test="${shipmentInstance?.wasReceived()}">
                            <g:set var="message" value="Shipment has already been received!"/>
                        </g:elseif>

                        <a href="javascript:void(0);" onclick="alert('${message}')">
                            <img src="${createLinkTo(dir: 'images/icons/silk', file: 'lorry.png')}"
                                 class="middle"/>&nbsp;
                            <span class="fade">
                                <warehouse:message code="shipping.sendShipment.label"/>
                            </span>
                        </a>
                    </g:else>
                </div>
            </g:if>

            <g:if test="${shipmentInstance?.origin?.id == session?.warehouse?.id || shipmentInstance?.destination?.id == session?.warehouse?.id}">
                <div class="action-menu-item">
                    <g:if test="${shipmentInstance?.isReceiveAllowed()}">
                        <g:link controller="shipment" action="receiveShipment" id="${shipmentInstance.id}"
                                name="receiveShipmentLink">
                            <img src="${createLinkTo(dir: 'images/icons/silk', file: 'box.png')}" alt="Receive Shipment"
                                 class="middle"/>&nbsp;
                            <warehouse:message code="shipping.receiveShipment.label"/>
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:set var="message" value="Shipment cannot be received yet"/>
                        <g:if test="${!shipmentInstance?.hasShipped()}">
                            <g:set var="message" value="Shipment has not been shipped!"/>
                        </g:if>
                        <g:elseif test="${shipmentInstance?.wasReceived()}">
                            <g:set var="message" value="Shipment was already received!"/>
                        </g:elseif>
                        <a href="javascript:void(0);" onclick="alert('${message}')">
                            <img src="${createLinkTo(dir: 'images/icons', file: 'handtruck.png')}"
                                 alt="Receive Shipment" class="middle"/>&nbsp;
                            <span class="fade"><warehouse:message code="shipping.receiveShipment.label"/></span>
                        </a>
                    </g:else>
                </div>
            </g:if>
        </g:isUserManager>
        <g:if test="${shipmentInstance?.origin?.id == session?.warehouse?.id || shipmentInstance?.destination?.id == session?.warehouse?.id}">
            <g:isUserInRole roles="[RoleType.ROLE_ADMIN]">
                <div class="action-menu-item">
                    <g:link controller="shipment" action="rollbackLastEvent" id="${shipmentInstance?.id}">
                        <img src="${createLinkTo(dir: 'images/icons/silk', file: 'arrow_undo.png')}"
                             alt="Rollback Last Event" class="middle"/>&nbsp;
                        <warehouse:message code="shipping.rollbackLastEvent.label"/></g:link>
                </div>
            </g:isUserInRole>
        </g:if>
        <g:if test="${(!shipmentInstance?.hasShipped()) && (shipmentInstance?.origin?.id == session?.warehouse?.id || shipmentInstance?.destination?.id == session?.warehouse?.id)}">
            <div class="action-menu-item">
                <g:link controller="shipment" action="deleteShipment" id="${shipmentInstance.id}"><img
                        src="${createLinkTo(dir: 'images/icons', file: 'trash.png')}"
                        alt="Delete Shipment" class="middle"/>&nbsp;
                    <g:if test="${request.request.requestURL.toString().contains('deleteShipment')}"><warehouse:message
                            code="shipping.deleteShipment.label"/></g:if>
                    <g:else><warehouse:message code="shipping.deleteShipment.label"/></g:else>
                </g:link>
            </div>
        </g:if>
    </div>
</div>
