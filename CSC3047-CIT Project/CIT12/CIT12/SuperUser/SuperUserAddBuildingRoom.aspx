<%@ Page Title="Add Building / Room" Language="C#" MasterPageFile="~/SuperUser/SuperUser.Master" AutoEventWireup="true" CodeBehind="SuperUserAddBuildingRoom.aspx.cs" Inherits="CIT12.SuperUser.SuperUserAddBuildingRoom" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="SuperUserHome.aspx">Home</a></li>
        <li class="active">Add Buildings / Rooms</li>
    </ul>

    <div class="row">
        <h3>Add Building / Room</h3>
        <small>Add a building or room for student room bookings</small>
    </div>

    <br />

    <div class="row">
        <asp:Button ID="btnBuilding" runat="server" Text="Add Building" CssClass="btn btn-lg btn-primary" OnClick="btnBuilding_Click" />
        <asp:Button ID="btnRoom" runat="server" Text="Add Room" CssClass="btn btn-lg btn-primary pull-right" OnClick="btnRoom_Click" />
        <br />
        <br />
        <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
    </div>

    <br />

    <%-- building panel--%>
    <asp:Panel ID="pnlBuilding" runat="server" Visible="false">

        <div class="container">
            <div class="row">

                <div class="col-md-4">
                    <h4>Remove Building</h4>
                    <hr />
                    <asp:GridView ID="gvBuildings" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsBuildings" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Buildings Are Found" GridLines="None" CellSpacing="-1" AllowPaging="true" PageSize="10" OnRowCommand="gvBuildings_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                            <asp:BoundField DataField="Building" HeaderText="Building" SortExpression="Building"></asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnRemoveBuilding" runat="server" Text="Remove Building" CssClass="btn btn-danger btn-block" CommandName="cmdRemoveBuilding" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource runat="server" ID="dsBuildings" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT [Id], [Building] FROM [tbl_building]"></asp:SqlDataSource>
                </div>


                <div class="col-md-4 pull-right">
                    <h4>Add Building</h4>
                    <hr />

                    <div class="form-group">
                        <label for="txtBuilding" class="control-label">Building Name</label>
                        <asp:TextBox ID="txtBuilding" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblBuildingError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="btnAddBuilding" runat="server" Text="Add Building" CssClass="btn btn-lg btn-success" OnClick="btnAddBuilding_Click" />
                    </div>
                </div>

            </div>
        </div>


    </asp:Panel>


    <%--room panel--%>
    <asp:Panel ID="pnlRoom" runat="server" Visible="false">
        <div class="container">
            <div class="row">

                <div class="col-md-4">

                    <h4>Remove Room</h4>
                    <hr />

                    <label class="control-label" for="ddlBuildings">Building</label>
                    <asp:DropDownList ID="ddlBuildingFilter" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>

                    <br />

                    <asp:GridView ID="gvRooms" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsRooms" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Rooms Are Found For This Building" GridLines="None" CellSpacing="-1" OnRowCommand="gvRooms_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                            <asp:BoundField DataField="BuildingId" HeaderText="BuildingId" SortExpression="BuildingId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                            <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room"></asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnRemoveBuilding" runat="server" Text="Remove Building" CssClass="btn btn-block btn-danger" CommandName="cmdRemoveRoom" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:SqlDataSource runat="server" ID="dsRooms" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT * FROM [tbl_rooms]" FilterExpression="BuildingId = '{0}'">
                        <FilterParameters>
                            <asp:ControlParameter Name="BuildingId" ControlID="ddlBuildingFilter" PropertyName="SelectedValue" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </div>


                <div class="col-md-4 pull-right">
                    <h4>Add Building</h4>
                    <hr />
                    <div class="form-group">
                        <label for="ddlBuilding" class="control-label">Building</label>
                        <asp:DropDownList ID="ddlBuilding" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="txtRoom" class="control-label">Room Name</label>
                        <asp:TextBox ID="txtRoom" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="lblRoomError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="btnAddRoom" runat="server" Text="Add Room" CssClass="btn btn-lg btn-success" OnClick="btnAddRoom_Click" />
                    </div>
                </div>




            </div>
        </div>
        <div class="clearfix"></div>


    </asp:Panel>





</asp:Content>
