<%--
  - request-free-acess.jsp
  -
  - Version: $Revision: 1.0 $
  -
  - Date: $Date: 2004/12/29 19:51:49 $
  -
  - Copyright (c) 2004, University of Minho
  -   All rights reserved.
  -
  - Redistribution and use in source and binary forms, with or without
  - modification, are permitted provided that the following conditions are
  - met:
  -
  - - Redistributions of source code must retain the above copyright
  - notice, this list of conditions and the following disclaimer.
  -
  - - Redistributions in binary form must reproduce the above copyright
  - notice, this list of conditions and the following disclaimer in the
  - documentation and/or other materials provided with the distribution.
  -
  - - Neither the name of the Hewlett-Packard Company nor the name of the
  - Massachusetts Institute of Technology nor the names of their
  - contributors may be used to endorse or promote products derived from
  - this software without specific prior written permission.
  -
  - THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  - ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  - LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  - A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  - HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  - INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
  - BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
  - OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  - ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
  - TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
  - USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
  - DAMAGE.
  --%>

<%--
  - request-free-acess JSP
  -
  - Attributes:
  -    token  - token from the request item
  -    title - 
  -    handle - URL of handle item
  -    
  --%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="org.dspace.app.webui.servlet.RequestItemServlet"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%
    String token = request.getParameter("token");

    String handle = (String) request.getAttribute("handle");
    if (handle == null)
        handle = "";
	
    String title = (String) request.getAttribute("title");
    if (title == null)
        title = "";
%>

<dspace:layout locbar="off" navbar="off" titlekey="jsp.request.item.request-free-acess.title" >

<br/>
    <p><fmt:message key="jsp.request.item.request-free-acess.info1"/>
    <a class="style1" href="" onClick="window.close();"><fmt:message key="jsp.request.item.request-free-acess.close"/></a>
    </p>


<p><b><fmt:message key="jsp.request.item.request-free-acess.info2">
<fmt:param><a href="<%=request.getContextPath()%>/handle/<%=handle %>"><%=title %></a></fmt:param>
</fmt:message> 
</b></p>

    <form name="form1" action="<%= request.getContextPath() %>/request-item" method="POST">
        <input type="HIDDEN" name="token" value='<%= token %>'>
        <input type="HIDDEN" name="step" value='<%=RequestItemServlet.RESUME_FREEACESS %>'>
        <center>
            <table>
                <tr>
                    <td class="submitFormLabel"><fmt:message key="jsp.request.item.request-free-acess.name"/></td>
                    <td><input type="TEXT" name="name" size="50" value=""></td>
                </tr>
                <tr>
                    <td class="submitFormLabel"><fmt:message key="jsp.request.item.request-free-acess.email"/></td>
                    <td><input type="TEXT" name="email" size="50" value=""></td>
                </tr>
                <tr>
                    <td align="center" colspan="2"><p>
                    <input type="SUBMIT" name="submit_free" value="<fmt:message key="jsp.request.item.request-free-acess.free"/>" >
                    </p></td>
                </tr>                    
            </table>
        </center>
    </form>

</dspace:layout>