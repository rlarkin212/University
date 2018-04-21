<%@ Page Title="Personal Tutees" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicPersonalTutees.aspx.cs" Inherits="CIT12.Academic.AcademicPersonalTutees" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--print script--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= gvAcademicPersonalTutees.ClientID %>');
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
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li><a href="AcademicStudentInfo.aspx">Student Info</a></li>
        <li class="active">Personal Tutees</li>
    </ul>

    <%--page start--%>
    <div class="heading">
        <h3>Personal Tuttees</h3>
    </div>

    <%--search container--%>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <small>Filter List Via Student Number</small>
                <br />
                <br />
                <label class="control-label" for="txtStudentNumber">Student Number</label>
                <asp:TextBox ID="txtStudentNumber" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

        </div>

        <br />

        <div class="row">
            <div class="col-md-4">
                <asp:Button ID="btnFilterStudents" runat="server" Text="Search" CssClass="btn btn-primary btn-block" />
            </div>
        </div>

    </div>
    <br />

    <%--gv--%>
    <asp:GridView ID="gvAcademicPersonalTutees" runat="server" DataSourceID="dsAcademicPersonalTutees" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Do Not have Any Students Assigned To You" GridLines="None" CellSpacing="-1" OnDataBound="gvAcademicPersonalTutees_DataBound">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AcademicStudentResult.aspx?Id={0}" DataTextField="Number" HeaderText="Student Number" SortExpression="Number" />
             <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" ReadOnly="true" SortExpression="EmailAddress"></asp:BoundField>
            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
            <%--email cb --%>
            <asp:TemplateField>
                    <HeaderTemplate>Include In Email</HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbEmail" runat="server" CssClass="checkbox" />
                    </ItemTemplate>
                </asp:TemplateField>

        </Columns>
    </asp:GridView>

    <hr />
    
    <asp:Button ID="Button1" runat="server" Text="Print" ToolTip="Print Student Information" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />

    <asp:Button ID="btnEmailToArray" runat="server" Text="Send Email" ToolTip="Send an email to all students checked" CssClass="btn btn-info btn-lg" OnClick="btnEmailToArray_Click"/>
   

    <asp:SqlDataSource runat="server" ID="dsAcademicPersonalTutees" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id,tbl_user.Number,CONCAT(tbl_user.Forename,' ',tbl_user.Surname) AS FullName, tbl_user.EmailAddress FROM tbl_academicPersonalTutees INNER JOIN tbl_user ON tbl_academicPersonalTutees.StudentId = tbl_user.Id WHERE (tbl_academicPersonalTutees.AcademicId = @loggedUserId)" FilterExpression="Number LIKE '{0}%'">
        <SelectParameters>
            <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32" />
        </SelectParameters>

        <FilterParameters>
            <asp:ControlParameter Name="Number" ControlID="txtStudentNumber" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>
</asp:Content>
