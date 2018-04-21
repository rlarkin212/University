<%@ Page Title="Course Class List" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCourseClassList.aspx.cs" Inherits="CIT12.Admin.AdminCourseClassList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlCourseClassList.ClientID %>')
            document.getElementById('<%= btnPrintGv.ClientID %>').hidden = true
            document.getElementById('<%= btnSendEmail.ClientID %>').hidden = true
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
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageAcademic.aspx">Manage Academic Info</a></li>
        <li class="active">Course Class List</li>
    </ul>


    <div class="row">
        <h3>Course Class List</h3>
        <small>View and print the class list for an entire course </small>
        <hr />
    </div>

    <asp:Panel ID="pnlCourseClassList" runat="server">

        <div class="container">
            <div class="row">

                <div class="col-md-4">
                    <label for="ddlCourse" class="control-label">Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"></asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <label for="ddlLevel" class="control-label">Level</label>
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                </div>
                
            </div>
        </div>

        <br />

        <div class="row">

            <asp:GridView ID="gvCourseClassList" runat="server" DataSourceID="dsAcademicCourseClassList" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Found Please Select A Course" GridLines="None" CellSpacing="-1" OnDataBound="gvCourseClassList_DataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AdminStudentResults.aspx?Id={0}" DataTextField="Number" HeaderText="Student Number" SortExpression="Number" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="StudentLevel" HeaderText="Level" ReadOnly="True" SortExpression="StudentLevel"></asp:BoundField>
                    <asp:TemplateField>
                        <HeaderTemplate>Send Email</HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbEmail" runat="server" CssClass="checkbox" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <hr />

            <div class="row">
                <div class="col-md-4">
                    <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />
                </div>

                <div class="col-md-4">
                    <asp:Button ID="btnSendEmail" runat="server" Text="Send Email" ToolTip="Send Email" CssClass="btn btn-warning btn-lg" OnClick="btnSendEmail_Click"/>
                </div>

            </div>


            <asp:SqlDataSource runat="server" ID="dsAcademicCourseClassList" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number,CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_studentUser.StudentLevel FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId INNER JOIN tbl_studentCourse ON tbl_studentUser.StudentId = tbl_studentCourse.StudentId WHERE (tbl_studentCourse.CourseId = @courseId) ORDER BY FullName" FilterExpression="StudentLevel = '{0}'">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_courseId" Name="courseId"></asp:SessionParameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="StudentLevel" ControlID="ddlLevel" Type="Int32" />
                </FilterParameters>
            </asp:SqlDataSource>


        </div>






    </asp:Panel>





</asp:Content>
