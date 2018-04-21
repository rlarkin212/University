<%@ Page Title="Enrolement Help Requets" Language="C#" MasterPageFile="~/Academic/Academic.Master" AutoEventWireup="true" CodeBehind="AcademicProgramManagerEnrolementHelp.aspx.cs" Inherits="CIT12.Academic.AcademicProgramManagerEnrolementHelp" %>

<asp:Content ID="bidyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="AcademicHome.aspx">Home</a></li>
        <li class="active">Respond To Enrolemnent Help Requests</li>
    </ul>


    <div class="row">
        <h3>Enrolement Help Response</h3>
        <small>Respond to student looking help with enrolement</small>
        <hr />
    </div>


    <asp:Panel ID="pnlRequsts" runat="server">

        <div class="row">
            <asp:GridView ID="gvHelpRequests" runat="server" DataSourceID="dsHelpRequests" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Have No Enrolemnt Help Requests" GridLines="None" CellSpacing="-1" OnRowCommand="gvHelpRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Help Table Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="RequestDate" HeaderText="Email RequestDate" SortExpression="RequestDate" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Student Name" SortExpression="FullName" ReadOnly="True"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="StudentId" HeaderText="StudentId" SortExpression="StudentId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnRespond" runat="server" Text="Respond" CssClass="btn btn-primary btn-block" CommandName="cmdRespond" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsHelpRequests" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_advisorEnrolementHelp.Id,CONCAT(tbl_user.Forename,'',tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_advisorEnrolementHelp.RequestDate, tbl_advisorEnrolementHelp.StudentId FROM tbl_advisorEnrolementHelp INNER JOIN tbl_user ON tbl_advisorEnrolementHelp.StudentId = tbl_user.Id WHERE (tbl_advisorEnrolementHelp.AdvisorId = @advisorId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_loggedUserId" Name="advisorId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

    </asp:Panel>

    <%--response panel--%>
    <asp:Panel ID="pnlResponse" runat="server" Visible="false">

        <div class="container">

            <div class="row">
                <h4>Create A Meeting Request</h4>
                <small>The meeting will be added to yours and the students additional events timetable</small>
                <hr />
            </div>

            <div class="row col-md-4">
                <label class="control-label" for="txtEmailAddressToSend">Email Address</label>
                <asp:TextBox ID="txtEmailAddressToSend" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvEmailAddress" ControlToValidate="txtEmailAddressToSend" ErrorMessage="Please Enter An Email Address" />
            </div>
            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-4">
                    <label class="control-label" for="txtTitle">Meeting Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTitle" ControlToValidate="txtTitle" ErrorMessage="Please Enter A Title" />
                </div>

                <div class="col-md-4">
                    <label class="control-label" for="txtDescription">Meeting Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvDescription" ControlToValidate="txtDescription" ErrorMessage="Please Enter A Description" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <label class="control-label" for="txtTime">Meeting Time</label>
                    <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" Placeholder="eg. 13:00" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTime" ControlToValidate="txtTime" ErrorMessage="Please Enter A Time" />
                </div>

                <div class="col-md-4">
                    <label class="control-label" for="txtLocation">Meeting Location</label>
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
                    <label class="control-label" for="txtDate">Meeting Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvDate" ControlToValidate="txtDate" ErrorMessage="Please Enter A Date" />
                </div>

            </div>

            <br />

            <div class="row">
                <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                <br />
                <asp:Button ID="btnSubmitEvent" runat="server" Text="Create Meeting" CssClass="btn btn-lg btn-success" OnClick="btnSubmitEvent_Click" />
            </div>

        </div>




    </asp:Panel>











</asp:Content>
