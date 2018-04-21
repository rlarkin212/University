<%@ Page Title="Room Booking" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StudentRoomBooking.aspx.cs" Inherits="CIT12.Student.StudentRoomBooking" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="StudentHome.aspx">Home</a></li>
        <li class="active">Room Booking</li>
    </ul>

    <div class="row">
        <h3>Room Booking</h3>
        <asp:Label ID="lblEmailAddress" runat="server" Text="" CssClass="hidden"></asp:Label>
        <hr />
    </div>

    <%--date panel--%>
    <asp:Panel ID="pnlDate" runat="server">
        <div class="row">
            <div class="col-md-4">
                <asp:Calendar ID="calDate" runat="server" OnSelectionChanged="calDate_SelectionChanged"></asp:Calendar>
            </div>

            <div class="col-md-4">
                <label class="control-label" for="txtDate">Event Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvDate" ControlToValidate="txtDate" ErrorMessage="Please Enter A Date" />
                <br />
                <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            </div>

        </div>
    </asp:Panel>

    <br />

    <%--bookings panel--%>
    <asp:Panel ID="pnlBookings" runat="server">

        <div class="row">
            <asp:Label ID="lblDate" runat="server" Text="" CssClass="h4"></asp:Label>
        </div>

        <div class="row">
            <label for="ddlBuildingFilter" class="control-label">Building</label>
            <asp:DropDownList ID="ddlBuildingFilter" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
        </div>

        <div class="row">
            <asp:Label ID="lblsuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" DataSourceID="dsBookings" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Bookings Are Found For This Date" GridLines="None" CellSpacing="-1">
                <Columns>
                    <asp:BoundField DataField="Building" HeaderText="Building" SortExpression="Building"></asp:BoundField>
                    <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room"></asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="BuildingId" HeaderText="BuildingId" SortExpression="BuildingId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                </Columns>
            </asp:GridView>

            <hr />
            <asp:Button ID="btnCreateBooking" runat="server" Text="Create Booking" CssClass="btn btn-lg btn-primary" OnClick="btnCreateBooking_Click" />



            <asp:SqlDataSource runat="server" ID="dsBookings" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_building.Building, tbl_rooms.Room, tbl_roomBooking.Date, tbl_times.Time, tbl_rooms.BuildingId FROM tbl_roomBooking INNER JOIN tbl_rooms ON tbl_roomBooking.RoomId = tbl_rooms.Id INNER JOIN tbl_times ON tbl_roomBooking.TimeId = tbl_times.Id INNER JOIN tbl_building ON tbl_rooms.BuildingId = tbl_building.Id WHERE (tbl_roomBooking.Date = @date) ORDER BY tbl_roomBooking.TimeId ASC" FilterExpression="BuildingId = '{0}'">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_date" Name="date" Type="DateTime"></asp:SessionParameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="BuildingId" ControlID="ddlBuildingFilter" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>



    </asp:Panel>

    <%--create booking panel--%>
    <asp:Panel ID="pnlCreateBooking" runat="server" Visible="false">


        <div class="row">
            <h4>Create Booking</h4>
            <label for="lblDateToBook" class="control-label">Booking Date : </label>
            <asp:Label ID="lblDateToBook" runat="server" Text=""></asp:Label>
        </div>
        <br />

        <div class="row">
            <div class="form-group">
                <label for="ddlBuilding" class="control-label">Building</label>
                <asp:DropDownList ID="ddlBuilding" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlBuilding_SelectedIndexChanged"></asp:DropDownList>
            </div>
             <div class="form-group">
                <label for="ddlRoom" class="control-label">Room</label>
                <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
             <div class="form-group">
                <label for="ddlTime" class="control-label">Time</label>
                <asp:DropDownList ID="ddlTime" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Label ID="lblClashes" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <br />
                <br />
                <asp:Button ID="btnSubmitBooking" runat="server" Text="Make Booking" CssClass="btn btn-success btn-lg" OnClick="btnSubmitBooking_Click" />
            </div>

        </div>



    </asp:Panel>




</asp:Content>
