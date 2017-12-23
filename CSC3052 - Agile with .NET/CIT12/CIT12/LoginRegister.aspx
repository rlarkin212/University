<%@ Page Title="Login/Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginRegister.aspx.cs" Inherits="CIT12.LoginRegister" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--register panel will be shown on page load others will be hidden --%>
    <asp:Panel ID="pnlLogin" runat="server">
        <div class="container">
            <div class="panel panel-primary">

                <div class="panel-heading">
                    <h3 class="panel-title">Login</h3>
                </div>

                <%--panel body--%>
                <div class="panel-body">

                    <div class="form-group">
                        <label class="control-label" for="txtLoginEmailUsername">Email / Username </label>
                        <asp:TextBox ID="txtLoginEmailUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="control-label" for="txtLoginPassword">Password </label>
                        <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="lblLoginErrorText" runat="server" Text="" CssClass="text-danger"></asp:Label>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-success btn-lg " />
                    </div>

                    <div class="form-group">
                        <hr />
                        <label class="control-label" for="btnDontHaveAnAccount"><strong>Don't Have An Account Register Here</strong></label>
                        <asp:Button ID="btnDontHaveAnAccount" runat="server" Text="Register Here" CssClass="btn btn-block btn-primary" OnClick="btnDontHaveAnAccount_Click" />
                    </div>


                </div>

            </div>
        </div>
    </asp:Panel>




    <%--register panel--%>
    <asp:Panel ID="pnlRegister" runat="server">
        <div class="container">

            <%--email and password panel --%>
            <asp:Panel ID="pnlRegisterUserDetails" runat="server">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Register</h3>
                    </div>

                    <div class="panel-body">

                        <asp:Panel ID="pnlSuccessAlert" runat="server">
                            <div class="alert alert-success" id="success-alert" role="alert">
                                <button type="button" class="close" data-dismiss="alert">x</button>
                                <strong>Success! </strong>
                                Your Account Has Been Created. 
                            </div>
                        </asp:Panel>

                        <h3>User Details</h3>
                        <br />

                        <%--start of form grouping --%>
                        <div class="form-group">
                            <label class="control-label" for="txtRegisterForename">Forename</label>
                            <asp:TextBox ID="txtRegisterForename" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="txtRegisterSurname">Surname</label>
                            <asp:TextBox ID="txtRegisterSurname" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="txtRegisterEmailUsername">Email / Username</label>
                            <asp:TextBox ID="txtRegisterEmailUsername" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtRegisterEmailUsername"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Must Be In The Correct Format" ForeColor="Red" />
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="txtRegisterPassword">Password</label>
                            <asp:TextBox ID="txtRegisterPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="regexPassword" runat="server" ControlToValidate="txtRegisterPassword"
                                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ErrorMessage="Password must contain: Minimum 8 characters atleast 1 Alphabet and 1 Number" ForeColor="Red" />
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="txtRegisterVerifyPassword">Re-Type Password</label>
                            <asp:TextBox ID="txtRegisterVerifyPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblRegisterErrorText" runat="server" Text="" CssClass="text-danger"></asp:Label>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="fuProfilePic">Upload Profile Image</label>
                            <asp:FileUpload ID="fuProfilePic" runat="server" />
                            <asp:RequiredFieldValidator ErrorMessage="A Profile Picture Is Required" ControlToValidate="fuProfilePic"
                                runat="server" Display="Dynamic" ForeColor="Red" />

                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnRegister" runat="server" Text="Next ->" CssClass="btn btn-lg btn-success" OnClick="btnRegister_Click" />
                        </div>

                    </div>
                </div>

            </asp:Panel>


            <%--user roles register--%>
            <asp:Panel ID="pnlRegisterUserRoles" runat="server">

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Register</h3>
                    </div>



                    <div class="panel-body">

                        <asp:Panel ID="pnlUserRolesSuccessAlert" runat="server">
                            <div class="alert alert-success" id="userRole-success-alert" role="alert">
                                <button type="button" class="close" data-dismiss="alert">x</button>
                                <strong>Success! </strong>
                                The Chosen Roles Been Added To Your Account. 
                            </div>
                        </asp:Panel>


                        <h3>User Roles</h3>
                        <br />

                        <div class="container">
                            <div class="form-group">
                                <asp:CheckBox ID="cbProductOwner" runat="server" />
                                <label class="control-label" for="cbProductOwner">Product Owner</label>
                            </div>

                            <div class="form-group">
                                <asp:CheckBox ID="cbScrumMaster" runat="server" />
                                <label class="control-label" for="cbScrumMaster">Scrum Master</label>
                            </div>

                            <div class="form-group">
                                <asp:CheckBox ID="cbDeveloper" runat="server" />
                                <label class="control-label" for="cbDeveloper">Developer</label>
                            </div>

                            <div class="form-group">
                                <label class="">A Short Description Of Your Skills</label>
                                <br />
                                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>
                            </div>


                            <div class="form-group">
                                <asp:Button ID="btnRegisterUserRoles" runat="server" Text="Finish" CssClass="btn btn-success btn-success btn-lg" OnClick="btnRegisterUserRoles_Click" />
                            </div>


                        </div>



                    </div>


                </div>


            </asp:Panel>





        </div>
    </asp:Panel>




</asp:Content>
