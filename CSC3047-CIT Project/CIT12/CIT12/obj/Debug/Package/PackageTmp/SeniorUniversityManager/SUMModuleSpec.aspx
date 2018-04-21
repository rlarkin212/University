<%@ Page Title="Moduel Specification" Language="C#" MasterPageFile="~/SeniorUniversityManager/SeniorUniversityManager.Master" AutoEventWireup="true" CodeBehind="SUMModuleSpec.aspx.cs" Inherits="CIT12.SeniorUniversityManager.SUMModuleSpec" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlMoudleSpec.ClientID %>')
            document.getElementById('<%= btnPrintGv.ClientID %>').hidden = true
            document.getElementById('<%= searchBox.ClientID %>').hidden = true
            prtContent.border = 0; //set no border here
            var WinPrint = window.open('', '', 'left=100,top=100,width=1000,height=1000,toolbar=0,scrollbars=1,status=0,resizable=1');
            WinPrint.document.write(prtContent.outerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>


    <ul class="breadcrumb">
        <li><a href="SUMHome.aspx">Home</a></li>
        <li class="active">Module Specification</li>
    </ul>

    <asp:Panel ID="pnlMoudleSpec" runat="server">

        <div class="form-group">
            <div class="row">
                <h3>Module Specification</h3>
            </div>
        </div>


        <div id="searchBox" runat="server" class="form-group">
            <div class="row">
                <small>Search For A Module Via A Valid Module Code</small>
                <asp:TextBox ID="txtModuleCode" runat="server" CssClass="form-control" Placeholder="eg. CSC-3057"></asp:TextBox>
                <br />
                <asp:Button ID="btnSearchModule" runat="server" Text="Search" CssClass="btn btn-lg btn-success" />
            </div>
        </div>
        <br />

        <div class="form-group">
            <div class="row">
                <asp:GridView ID="gvModuleSpec" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsModuleSpec" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" EmptyDataText="No Modules Exist Wth This Module Code" OnRowDataBound="gvModuleSpec_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                        <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                        <asp:BoundField DataField="ModuleDescription" HeaderText="ModuleDescription" SortExpression="ModuleDescription"></asp:BoundField>
                        <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level"></asp:BoundField>
                        <asp:BoundField DataField="CatPoints" HeaderText="CAT Points" SortExpression="CatPoints"></asp:BoundField>
                        <asp:BoundField DataField="PreReqModules" HeaderText="Pre Requisite Modules" SortExpression="PreReqModules"></asp:BoundField>
                        <asp:BoundField DataField="Semester" HeaderText="Semester" SortExpression="Semester"></asp:BoundField>
                        <asp:BoundField DataField="StaffFullName" HeaderText="Staff" SortExpression="StaffFullName" ReadOnly="True"></asp:BoundField>
                    </Columns>
                </asp:GridView>

                <hr />
                <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Module Specification" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />
            </div>
        </div>


    </asp:Panel>


    <asp:SqlDataSource runat="server" ID="dsModuleSpec" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.ModuleDescription, tbl_modules.Level, tbl_modules.CatPoints, tbl_modules.PreReqModules, tbl_semester.Semester, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS StaffFullName FROM tbl_modules INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.ModuleId INNER JOIN tbl_user ON tbl_moduleStaff.StaffId = tbl_user.Id INNER JOIN tbl_semester ON tbl_modules.SemesterId = tbl_semester.Id" FilterExpression="Code LIKE '{0}%'">
        <FilterParameters>
            <asp:ControlParameter Name="Code" ControlID="txtModuleCode" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>


</asp:Content>
