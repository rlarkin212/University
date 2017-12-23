<%@ Page Title="CreateAProject" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateProject.aspx.cs" Inherits="CIT12.CreateProject" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="breadcrumb">
        <li><a href="Home.aspx">Home</a></li>
        <li class="active">Create A Project</li>
    </ul>

    <asp:Panel ID="pnlEnterProjectDetails" runat="server">

        <div class="container">

            <div class="heading">
                <h3>Create A Project</h3>
            </div>

            <div class="col-lg-8">

                <div id="successAlertMessage" runat="server" visible="false">
                    <div class="alert alert-success alert-dismissable">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Success!</strong> Your Project Has Been Created And You Are Project Manager
                    </div>
                </div>


                <div class="form-group">
                    <label for="txtProjectTitle" class="control-label">Project Title</label>
                    <asp:TextBox ID="txtProjectTitle" runat="server" CssClass="form-control"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvProjectTitle" runat="server" ControlToValidate="txtProjectTitle" ErrorMessage="Project Title is a required field." ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="txtProjectDetails" class="control-label">Project Details</label>
                    <asp:TextBox ID="txtProjectDetails" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="rfvProjectDetails" runat="server" ControlToValidate="txtProjectDetails" ErrorMessage="Project Details is a required field." ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnCreateProject" runat="server" Text="Create Project" CssClass="btn btn-success btn-lg" OnClick="btnCreateProject_Click" />
                </div>

            </div>


        </div>
    </asp:Panel>

    <div id="msgAddedUserSuccess" runat="server" visible="false">
        <div class="alert alert-success alert-dismissable">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Success!</strong> You Have Added Personnel To Your Project
        </div>
    </div>

    <asp:Panel ID="pnlProjectPersonnel" runat="server" Visible="false">

        <h3>Personel</h3>
        <small>Use The Filters Below To Search For Personnel</small>

        <br />
        <br />

        <div class="container">

            <div class="container">
                <div class="row">

                    <div class="col-md-4">
                        <label class="control-label" for="txtUserEmail">Email</label>
                        <asp:TextBox ID="txtUserEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                </div>

                <br />

                <div class="row">
                    <div class="col-md-4">
                        <asp:Button ID="btnFilterUser" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="btnFilterUser_Click" />
                    </div>
                </div>

            </div>

            <br />
            <hr />
            <br />

            <div class="container">

                <h3>Personnel</h3>

                <asp:GridView ID="gvPersonnel" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsPersonnel" CssClass="table table-striped table-bordered table-condensed table-hover" AllowPaging="true" OnRowCommand="gvPersonnel_RowCommand" EmptyDataText="Please Search For A User By Email">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                        <asp:BoundField DataField="Forename" HeaderText="Forename" SortExpression="Forename"></asp:BoundField>
                        <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname"></asp:BoundField>
                        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role"></asp:BoundField>
                        <asp:BoundField DataField="UserRoleCode" HeaderText="UserRoleCode" SortExpression="UserRoleCode" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                        <asp:BoundField DataField="Description" HeaderText="Skill Description" SortExpression="Description" />

                        <asp:TemplateField>
                            <ItemTemplate>

                                <asp:Image ID="itemPic" runat="server" CssClass="img-responsive img-circle" ImageUrl='<%# "files/" + Eval("ProfilePic") %>' Width="150px" Height="150px" BorderWidth="0px" />


                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField>
                            <HeaderTemplate>
                                Add Personnel
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnAddPersonnel" runat="server" Text="Add" CssClass="btn btn-block btn-success" CommandName="Add" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="dsPersonnel" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT [Id],[Email], [Forename], [Surname], [Role], [UserRoleCode], [ProfilePic], [Description] FROM [vwUsersAndRoles] WHERE (([UserRoleCode] <> @UserRoleCode) AND ([Email] LIKE '%' + @Email + '%'))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="10" Name="UserRoleCode" Type="String"></asp:Parameter>
                        <asp:SessionParameter SessionField="s_searchEmail" Name="Email" Type="String"></asp:SessionParameter>
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>


        </div>



    </asp:Panel>













</asp:Content>
