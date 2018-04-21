<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewSwitcher.ascx.cs" Inherits="CIT12.ViewSwitcher" %>
<div id="viewSwitcher">
    <%: CurrentView %> view | <a href="<%: SwitchUrl %>" data-ajax="false">Switch to <%: AlternateView %></a>
</div>