<%@ Page Title="Your Room Booking" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StudentYourRoomBookings.aspx.cs" Inherits="CIT12.Student.StudentYourRoomBookings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="StudentHome.aspx">Home</a></li>
        <li class="active">View Bookings</li>
    </ul>

    <div class="row">
        <h3>Your Room Bookings</h3>
    </div>

    <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvYourBookings" runat="server" AutoGenerateColumns="False" DataSourceID="dsYourBookings" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Have No Forthcoming Room Bookings" GridLines="None" CellSpacing="-1" OnRowCommand="gvYourBookings_RowCommand">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
            <asp:BoundField DataField="Building" HeaderText="Building" SortExpression="Building"></asp:BoundField>
            <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room"></asp:BoundField>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date"></asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnRemoveBooking" runat="server" Text="Cancel Booking" CssClass="btn btn-block btn-danger" CommandName="cmdCancelBooking" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>


    <asp:SqlDataSource runat="server" ID="dsYourBookings" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_roomBooking.Id, tbl_building.Building, tbl_rooms.Room, tbl_roomBooking.Date, tbl_times.Time FROM tbl_roomBooking INNER JOIN tbl_rooms ON tbl_roomBooking.RoomId = tbl_rooms.Id INNER JOIN tbl_building ON tbl_rooms.BuildingId = tbl_building.Id INNER JOIN tbl_times ON tbl_roomBooking.TimeId = tbl_times.Id WHERE (tbl_roomBooking.StudentId = @loggedUserId) AND (tbl_roomBooking.Date >= @date)
ORDER BY tbl_roomBooking.Date ASC">
        <SelectParameters>
            <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
            <asp:SessionParameter SessionField="s_date" Name="date"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
