<%@ Page Title="Student Details" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminStudentDetails.aspx.cs" Inherits="CIT12.Admin.AdminStudentDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <h3>Student Details</h3>
        <small>View and edit the details for a student</small>
        <hr />
    </div>

    <%--student panel--%>
    <asp:Panel ID="pnlStudents" runat="server">

        <div class="row">
            <asp:TextBox ID="txtNumberSearch" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
            <small>Filter Via Student Number</small>
            <br />
            <asp:Button ID="btnNumberSearch" runat="server" Text="Search" CssClass="btn btn-primary" />
        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsStudents" CssClass="table table-responsive table-striped table-condensed table-hover" GridLines="None" CellSpacing="-1" EmptyDataText="No Students Exist With With This Student Number" AllowPaging="true" PageSize="10" OnRowCommand="gvStudents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Student Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnViewDetails" runat="server" Text="View / Edit Details" CssClass="btn btn-block btn-info" CommandName="cmdViewDetails" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT Id, CONCAT(Forename, ' ', Surname) AS FullName, Number, EmailAddress FROM tbl_user WHERE (Role = @Role)" FilterExpression="Number LIKE '{0}%'">
                <SelectParameters>
                    <asp:Parameter DefaultValue="10" Name="Role" Type="Int32"></asp:Parameter>
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter Name="Number" ControlID="txtNumberSearch" Type="Int32" PropertyName="Text" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>

    </asp:Panel>


    <%--details panel--%>
    <asp:Panel ID="pnlDetails" runat="server" Visible="false">

        <div class="container">
            <h4>Student Details </h4>

            <div class="row">
                <%--personal details --%>
                <h5 class="text-success"><strong><u>Personal Details</u></strong></h5>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalStudentNumber" class="control-label">Student Number</label>
                    <asp:TextBox ID="txtPersonalStudentNumber" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalEmail" class="control-label">Email</label>
                    <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regPersonalEmail" runat="server" ControlToValidate="txtPersonalEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Must Be In The Correct Format" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalForename" class="control-label">Forename</label>
                    <asp:TextBox ID="txtPersonalForename" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPersonalForename" ControlToValidate="txtPersonalForename" ErrorMessage="Please Enter Your Forename" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalSurname" class="control-label">Surname</label>
                    <asp:TextBox ID="txtPersonalSurname" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPersonalSurname" ControlToValidate="txtPersonalSurname" ErrorMessage="Please Enter Your Surname" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalPhoneNumber" class="control-label">Phone Number</label>
                    <asp:TextBox ID="txtPersonalPhoneNumber" runat="server" CssClass="form-control" MaxLength="11"></asp:TextBox>
                </div>



                <%--home address--%>
                <div class="clearfix"></div>

                <h5 class="text-success"><strong><u>Home Address</u></strong></h5>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtHomeAddressNo" class="control-label">House Number</label>
                    <asp:TextBox ID="txtHomeAddressNo" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvHomeNo" ControlToValidate="txtHomeAddressNo" ErrorMessage="Please Enter Your House Number" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtHomeAddressStreet" class="control-label">Street</label>
                    <asp:TextBox ID="txtHomeAddressStreet" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvHomeStreet" ControlToValidate="txtHomeAddressStreet" ErrorMessage="Please Enter Your Street Name" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtHomeAddressTown_City" class="control-label">Town / City</label>
                    <asp:TextBox ID="txtHomeAddressTown_City" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvHomeTown" ControlToValidate="txtHomeAddressTown_City" ErrorMessage="Please Enter Your Town / City" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtHomeAddressCountry" class="control-label">Country</label>
                    <asp:TextBox ID="txtHomeAddressCountry" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvHomeCountry" ControlToValidate="txtHomeAddressCountry" ErrorMessage="Please Enter Your Country" ForeColor="Red" />
                </div>

                <%--term address--%>
                <div class="clearfix"></div>

                <h5 class="text-success"><strong><u>Term Time Address</u></strong></h5>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtTermAddressHouseNo" class="control-label">House Number</label>
                    <asp:TextBox ID="txtTermAddressHouseNo" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTermNo" ControlToValidate="txtTermAddressHouseNo" ErrorMessage="Please Enter Your House Number" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtTermAddressStreet" class="control-label">Term Address Street</label>
                    <asp:TextBox ID="txtTermAddressStreet" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTermStreet" ControlToValidate="txtTermAddressStreet" ErrorMessage="Please Enter Your Street Name" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtTermAddressTown" class="control-label">Term Address Town / City</label>
                    <asp:TextBox ID="txtTermAddressTown" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTermTown" ControlToValidate="txtTermAddressTown" ErrorMessage="Please Enter Your Town / City" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtTermAddressCountry" class="control-label">Term Address Country</label>
                    <asp:TextBox ID="txtTermAddressCountry" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvTermCountry" ControlToValidate="txtTermAddressCountry" ErrorMessage="Please Enter Your Country" ForeColor="Red" />
                </div>

                <%--next of kin--%>
                <div class="clearfix"></div>

                <h5 class="text-success"><strong><u>Next Of Kin Details</u></strong></h5>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinForename" class="control-label">Forename</label>
                    <asp:TextBox ID="txtNextOfKinForename" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinForename" ControlToValidate="txtNextOfKinForename" ErrorMessage="Please Enter Your Forename" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinSurname" class="control-label">Surname</label>
                    <asp:TextBox ID="txtNextOfKinSurname" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinSurname" ControlToValidate="txtNextOfKinSurname" ErrorMessage="Please Enter Your Surname" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinAddressHouseNo" class="control-label">House Number</label>
                    <asp:TextBox ID="txtNextOfKinAddressHouseNo" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinHouseNo" ControlToValidate="txtNextOfKinAddressHouseNo" ErrorMessage="Please Enter Your House Number" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinAddressStreet" class="control-label">Street</label>
                    <asp:TextBox ID="txtNextOfKinAddressStreet" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinStreet" ControlToValidate="txtNextOfKinAddressStreet" ErrorMessage="Please Enter Your Street Name" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinAddressTown" class="control-label">Town / City</label>
                    <asp:TextBox ID="txtNextOfKinAddressTown" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinTown" ControlToValidate="txtNextOfKinAddressTown" ErrorMessage="Please Enter Your Town / City" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinAddressCountry" class="control-label">Country</label>
                    <asp:TextBox ID="txtNextOfKinAddressCountry" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfvKinCountry" ControlToValidate="txtNextOfKinAddressCountry" ErrorMessage="Please Enter Your Country" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinEmail" class="control-label">Email</label>
                    <asp:TextBox ID="txtNextOfKinEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtNextOfKinEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Email Must Be In The Correct Format" ForeColor="Red" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtNextOfKinPhoneNumber" class="control-label">Phone Number</label>
                    <asp:TextBox ID="txtNextOfKinPhoneNumber" runat="server" CssClass="form-control" MaxLength="11"></asp:TextBox>
                </div>


            </div>

        </div>

        <div class="clearfix"></div>
        <asp:Button ID="btnSubmitDetails" runat="server" Text="Submit Details" CssClass="btn btn-lg btn-block btn-success" OnClick="btnSubmitDetails_Click"/>


    </asp:Panel>



</asp:Content>
