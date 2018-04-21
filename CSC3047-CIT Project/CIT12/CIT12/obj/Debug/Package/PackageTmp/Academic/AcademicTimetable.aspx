<%@ Page Title="Timetable" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicTimetable.aspx.cs" Inherits="CIT12.Academic.AcademicTimetable" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <%--js to print module list gridview--%>
    <script>
        function printGV() {
            var prtContent = document.getElementById('<%= pnlTimetable.ClientID %>');
            prtContent.border = 0; //set no border here
            var WinPrint = window.open('', '', 'left=100,top=100,width=1000,height=1000,toolbar=0,scrollbars=1,status=0,resizable=1');
            WinPrint.document.write(prtContent.outerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

    <%--page start--%>
    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li class="active">Timetable</li>
    </ul>

    <asp:Panel ID="pnlTimetable" runat="server">
        <div class="row">
            <h3>Timetable</h3>
            <asp:Label ID="lblStaffNumber" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>

        <br />
        <div class="row">
            <asp:GridView ID="gvAcademicTimetable" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsAcademicTimetable" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Timetable Is Found For This User, Check You Have Been Assigned To All Modules You Need To " GridLines="None" CellSpacing="-1" OnRowDataBound="gvAcademicTimetable_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                    <asp:BoundField DataField="DayId" HeaderText="DayId" SortExpression="DayId"></asp:BoundField>
                    <asp:BoundField DataField="StaffId" HeaderText="StaffId" SortExpression="StaffId"></asp:BoundField>
                    <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                </Columns>
            </asp:GridView>


            <asp:Button ID="btnPrintGv" runat="server" Text="Print" ToolTip="Print Class List" CssClass="btn btn-primary btn-lg" OnClientClick="printGV()" />
        </div>

        <asp:SqlDataSource runat="server" ID="dsAcademicTimetable" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_timeTable.Id, tbl_timeTable.DayId, tbl_moduleStaff.StaffId, tbl_days.Day, tbl_modules.Title, tbl_classType.Type, tbl_timeTable.Time, tbl_timeTable.Location FROM tbl_timeTable INNER JOIN tbl_modules ON tbl_timeTable.ModuleId = tbl_modules.Id INNER JOIN tbl_moduleStaff ON tbl_modules.Id = tbl_moduleStaff.StaffId INNER JOIN tbl_days ON tbl_timeTable.DayId = tbl_days.Id INNER JOIN tbl_classType ON tbl_timeTable.ClassTypeId = tbl_classType.Id WHERE (tbl_moduleStaff.StaffId = @loggedUserId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </asp:Panel>

    <%--additional events panel--%>
    <asp:Panel ID="pnlAdditionalEvents" runat="server">

        <div class="row">
            <h3>Additional Events</h3>
            <small>Add additional events such as meetings to your timetable</small>
            <hr />
        </div>

        <div class="row">
            <div class="col-md-4">
                <asp:Button ID="btnAddAdditionalEvent" runat="server" Text="Add Event" CssClass="btn btn-primary" OnClick="btnAddAdditionalEvent_Click" />
            </div>
            <div class="col-md-4 pull-right">
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh Events" CssClass="btn btn-primary" OnClick="btnRefresh_Click" ToolTip="Removes Old Events"/>
            </div>

            <br />
            <br />
            <hr />

            <asp:GridView ID="gvAdditionalEvents" runat="server" DataSourceID="dsAdditionalEvents" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Additional Events Found" GridLines="None" CellSpacing="-1">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Event Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Description" HeaderText="Event Description" SortExpression="Description"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Event Date" SortExpression="Date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Event Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="Location" HeaderText="Event Location" SortExpression="Location"></asp:BoundField>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsAdditionalEvents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT [Id], [Title], [Description], [Date], [Time], [Location] FROM [tbl_additionalEvents] WHERE ([UserId] = @UserId) ORDER BY Date ASC">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_loggedUserId" Name="UserId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>


    </asp:Panel>

    <%--add event panel--%>
    <asp:Panel ID="pnlAddEvent" runat="server" Visible="false">

        <div class="row">
            <h3>Add Additional Event</h3>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTitle">Event Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvTitle" ControlToValidate="txtTitle" ErrorMessage="Please Enter A Title" />
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDescription">Event Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDescription" ControlToValidate="txtDescription" ErrorMessage="Please Enter A Description" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTime">Event Time</label>
                <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" Placeholder="eg. 13:00" MaxLength="5"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvTime" ControlToValidate="txtTime" ErrorMessage="Please Enter A Time" />
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtLocation">Event Location</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvLocation" ControlToValidate="txtLocation" ErrorMessage="Please Enter A Location" />
            </div>
        </div>

        <br />


        <div class="row">
            <div class="col-md-4">
                <asp:Calendar ID="calDate" runat="server" OnSelectionChanged="calDate_SelectionChanged"></asp:Calendar>
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDate">Event Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDate" ControlToValidate="txtDate" ErrorMessage="Please Enter A Date" />
            </div>

        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitEvent" runat="server" Text="Create Event" CssClass="btn btn-lg btn-success" OnClick="btnSubmitEvent_Click" />
        </div>


    </asp:Panel>










</asp:Content>
