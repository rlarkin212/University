<%@ Page Title=" Project Teams" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StudentTeams.aspx.cs" Inherits="CIT12.Student.StudentTeams" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <ul class="breadcrumb">
        <li><a href="StudentHome.aspx">Home</a></li>
        <li class="active">Team Management</li>
    </ul>

    <div class="row">
        <h3>Team Management</h3>
        <br />
        <small>Create A Team For An Enrolled Module, Create Meetings and Send Group Emails</small>
        <hr />
    </div>

    <%--team panel--%>
    <asp:Panel ID="pnlTeams" runat="server">
        <div class="row">
            <h4>Project Teams</h4>
            <br />
            <asp:Button ID="btnCreateNewTeam" runat="server" Text="Create Team" CssClass="btn btn-primary" OnClick="btnCreateNewTeam_Click" />
        </div>

        <br />

        <div class="row">

            <asp:GridView ID="gvTeams" runat="server" DataSourceID="dsTeams" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Are Not A Member Of Any Project Teams" GridLines="None" CellSpacing="-1" OnRowCommand="gvTeams_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Module Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="TeamName" HeaderText="Team Name" SortExpression="TeamName"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnViewTeamMembers" runat="server" Text="View Team Members" CssClass="btn btn-block btn-info" CommandName="cmdViewTeamMembers" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnLeaveTeam" runat="server" Text="Leave Team" CssClass="btn btn-block btn-danger" CommandName="cmdLeaveTeam" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


            <asp:SqlDataSource runat="server" ID="dsTeams" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_studentTeams.Id, tbl_studentTeams.TeamName, tbl_modules.Title FROM tbl_studentTeamMembers INNER JOIN tbl_studentTeams ON tbl_studentTeamMembers.TeamId = tbl_studentTeams.Id INNER JOIN tbl_modules ON tbl_studentTeams.ModuleId = tbl_modules.Id WHERE (tbl_studentTeamMembers.MemberId = @loggedUserId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>

    <%--create team panel--%>
    <asp:Panel ID="pnlCreateTeam" runat="server" Visible="false">

        <div class="row">
            <h4>Create Project Team</h4>
        </div>

        <div class="row">
            <asp:Label ID="lblCreateTeamSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvModules" runat="server" AutoGenerateColumns="False" DataSourceID="dsModules" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="You Are Not Enrolled In Any Modules" GridLines="None" CellSpacing="-1" OnRowCommand="gvModules_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ModuleId" HeaderText="ModuleId" SortExpression="ModuleId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Module Title " SortExpression="Title"></asp:BoundField>

                    <asp:TemplateField>
                        <HeaderTemplate>Team Name</HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="txtTeamName" runat="server" CssClass="form-control"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnCreateTeam" runat="server" Text="Create Team" CssClass="btn btn-block btn-success" CommandName="cmdCreateTeam" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsModules" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_studentModule.ModuleId, tbl_modules.Title FROM tbl_studentModule INNER JOIN tbl_modules ON tbl_studentModule.ModuleId = tbl_modules.Id WHERE (tbl_studentModule.StudentId = @loggedUserId) AND (tbl_studentModule.Complete = 0)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>


    </asp:Panel>


    <%--team members panel--%>
    <asp:Panel ID="pnlTeamMembers" runat="server" Visible="false">

        <div class="row">
            <label class="h4" for="lblTeamName">Team Members</label>
            <br />
            <asp:Label ID="lblTeamName" runat="server" Text="" CssClass="h5"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnAddTeamMembers" runat="server" Text="Add Team Members" CssClass="btn btn-primary" OnClick="btnAddTeamMembers_Click" />
        </div>
        <br />

        <div class="row">
            <asp:Label ID="lblTeamMembersSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvTeamMembers" runat="server" AutoGenerateColumns="False" DataSourceID="dsTeamMembers" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Members Are Found For This Team" GridLines="None" CellSpacing="-1">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <HeaderTemplate>Include</HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbInclude" runat="server" CssClass="checkbox" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsTeamMembers" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress FROM tbl_studentTeamMembers INNER JOIN tbl_user ON tbl_studentTeamMembers.MemberId = tbl_user.Id WHERE (tbl_studentTeamMembers.TeamId = @teamId)">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_teamId" Name="teamId"></asp:SessionParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div class="row">
            <div class="col-md-4">
                <asp:Button ID="btnCreateEvent" runat="server" Text="Create Event" CssClass="btn btn-primary" OnClick="btnCreateEvent_Click" />
            </div>
            <div class="col-md-4">
                <asp:Button ID="btnEmail" runat="server" Text="Send Email" CssClass="btn btn-primary" OnClick="btnEmail_Click" />
            </div>
        </div>

    </asp:Panel>

    <%--add team member panel--%>
    <asp:Panel ID="pnlAddTeamMembers" runat="server" Visible="false">

        <div class="row">
            <h3>Add Team Members</h3>
            <asp:Label ID="lblAddMembersTeamName" runat="server" Text=""></asp:Label>
            <br />
        </div>

        <div class="row">
            <asp:DropDownList ID="ddlModules" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModules_SelectedIndexChanged"></asp:DropDownList>
            <small>Select A Moudule</small>
        </div>

        <br />

        <div class="row">
            <asp:TextBox ID="txtEmailSearch" runat="server" CssClass="form-control"></asp:TextBox>
            <small>Search Via Email Address</small>
            <br />
            <br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" />
        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblAddedToTeamSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <asp:GridView ID="gvStudents" runat="server" DataSourceID="dsStudents" AutoGenerateColumns="False" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Students Are Found With This Email Address " GridLines="None" CellSpacing="-1" OnRowCommand="gvStudents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="ModuleId" HeaderText="ModuleId" ReadOnly="True" InsertVisible="False" SortExpression="ModuleId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnAddToTeam" runat="server" Text="Add To Team" CssClass="btn btn-block btn-success" CommandName="cmdAddToTeam" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_user.Id, CONCAT(tbl_user.Forename, ' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_modules.Id AS ModuleId FROM tbl_user INNER JOIN tbl_studentModule ON tbl_user.Id = tbl_studentModule.StudentId INNER JOIN tbl_modules ON tbl_studentModule.ModuleId = tbl_modules.Id WHERE(tbl_modules.Id = @ddlModuleId AND tbl_user.Id != @loggedUserId)" FilterExpression="EmailAddress LIKE '{0}%'">
                <SelectParameters>
                    <asp:SessionParameter SessionField="s_ddlModuleId" Name="ddlModuleId" Type="Int32"></asp:SessionParameter>
                      <asp:SessionParameter SessionField="s_loggedUserId" Name="loggedUserId" Type="Int32"></asp:SessionParameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="EmailAddress" ControlID="txtEmailSearch" PropertyName="text" Type="String" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>


    </asp:Panel>

    <%--create event panel--%>
    <asp:Panel ID="pnlCreateEvent" runat="server" Visible="false">
        <div class="row">
            <h4>Create Event</h4>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTitle">Event Title</label>
                <asp:TextBox ID="txtEventTitle" runat="server" CssClass="form-control"></asp:TextBox>
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

    <%--send email panel--%>
    <asp:Panel ID="pnlSendEmail" runat="server" Visible="false">
        <div class="row">
            <h4>Send Email</h4>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label class="control-label" for="txtTitle">Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="control-label" for="txtSubject">Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row col-md-4">
            <label class="control-label" for="txtBody">Body</label>
            <asp:TextBox ID="txtBody" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8"></asp:TextBox>
        </div>

        <br />
        <div class="clearfix"></div>

        <br />
        <div class="row col-md-4">
            <asp:Button ID="btnSendEmail" runat="server" Text="Send" CssClass="btn btn-lg btn-success btn-lg" OnClick="btnSendEmail_Click" />
        </div>

        <div class="clearfix"></div>

    </asp:Panel>


</asp:Content>

