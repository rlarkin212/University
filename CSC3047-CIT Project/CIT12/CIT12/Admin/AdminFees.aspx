<%@ Page Title="Student Fees" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminFees.aspx.cs" Inherits="CIT12.Admin.AdminFees" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <ul class="breadcrumb">
        <li><a href="AdminHome.aspx">Home</a></li>
        <li><a href="AdminManageStudent.aspx">Manage Student Info</a></li>
        <li class="active">Student Fee Status</li>
    </ul>


    <div class="row">
        <h3>Student Fees</h3>
        <hr />
    </div>

    <%--student list panel--%>
    <asp:Panel ID="pnlStudentList" runat="server">

        <div class="row">

            <label for="ddlFeeTypes" class="control-label">Fee Status</label>
            <asp:DropDownList ID="ddlFeeTypes" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>

        </div>

        <br />

        <div class="row">
            <asp:Label ID="lblSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="dsStudents" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Academic Program Mangers Are Found For This Number" GridLines="None" CellSpacing="-1" OnRowDataBound="gvStudents_RowDataBound" OnRowCommand="gvStudents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Number" HeaderText="Student Number" SortExpression="Number"></asp:BoundField>
                    <asp:BoundField DataField="FullName" HeaderText="Student Name" ReadOnly="True" SortExpression="FullName"></asp:BoundField>
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress"></asp:BoundField>
                    <asp:BoundField DataField="Type" HeaderText="Fee Type" SortExpression="Type"></asp:BoundField>
                    <asp:BoundField DataField="FeesPaid" HeaderText="Fee Status" SortExpression="FeesPaid"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnUpdateFees" runat="server" Text="Update Fees" CssClass="btn btn-block btn-info" CommandName="cmdUpdateFees" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsStudents" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_user.Id, tbl_user.Number, CONCAT(tbl_user.Forename,' ', tbl_user.Surname) AS FullName, tbl_user.EmailAddress, tbl_feesType.Type, tbl_studentUser.FeesPaid FROM tbl_user INNER JOIN tbl_studentUser ON tbl_user.Id = tbl_studentUser.StudentId INNER JOIN tbl_feesType ON tbl_studentUser.Id = tbl_feesType.Id" FilterExpression="FeesPaid = '{0}'">
                <FilterParameters>
                    <asp:ControlParameter Name="FeesPaid" ControlID="ddlFeeTypes" Type="Int32" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>
        </div>




    </asp:Panel>

    <%--make payment--%>
    <asp:Panel ID="pnlPayment" runat="server" Visible="false">

        <div class="row">
            <h4>Update Fees</h4>
        </div>

        <br />

        <div class="row">
            <label for="lblStudent" class="control-label">Student - </label>
            <asp:Label ID="lblStudent" runat="server" Text="" CssClass="h5"></asp:Label>
        </div>

        <br />

        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Payment Details</h3>
                            <br />
                            <label class="control-label" for="lblOutstandingFees">Outstanding Fees : £ </label>
                            <asp:Label ID="lblOutstandingFees" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="panel-body">

                            <div class="form-group">
                                <label for="txtAmountToPay" class="control-label">Amount Paying</label>
                                <asp:TextBox ID="txtAmountToPay" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <hr />
                            <div class="form-group">
                                <label for="txtCardNumber">CARD NUMBER</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="Valid card Number" MaxLength="16"></asp:TextBox>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span></span>
                                </div>
                                <asp:RequiredFieldValidator runat="server" ID="rfvCard" ControlToValidate="txtCardNumber" ErrorMessage="Please Enter A Valid Card Number" ForeColor="Red" />
                            </div>
                            <div class="row">
                                <div class="col-xs-7 col-md-7">
                                    <label for="txtExpiryMonth">EXPIRY DATE</label>
                                    <div class="form-group">
                                        <div class="col-xs-6 col-lg-6 pl-ziro">
                                            <asp:TextBox ID="txtExpiryMonth" runat="server" CssClass="form-control" placeholder="MM" MaxLength="2"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvMonth" ControlToValidate="txtExpiryMonth" ErrorMessage="Please Enter An Expiry Month" ForeColor="Red" />
                                        </div>
                                        <div class="col-xs-6 col-lg-6 pl-ziro">
                                            <asp:TextBox ID="txtExpiryYear" runat="server" CssClass="form-control" placeholder="YY" MaxLength="2"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="txtExpiryYear" ErrorMessage="Please Enter An Expiry Year" ForeColor="Red" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-5 col-md-5 pull-right">
                                    <div class="form-group">
                                        <label for="txtCvCode">CVV CODE</label>
                                        <asp:TextBox ID="txtCvCode" runat="server" CssClass="form-control" MaxLength="3"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvCvCode" ControlToValidate="txtCvCode" ErrorMessage="Please Enter A CVV Code" ForeColor="Red" />
                                    </div>
                                </div>
                            </div>
                            <asp:Label ID="lblPaymentError" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </div>
                    </div>

                    <br />

                    <asp:Button ID="btnSubmitPrivatePayment" runat="server" Text="Pay" CssClass="btn btn-success btn-lg btn-block" OnClick="btnSubmitPrivatePayment_Click" />
                </div>
            </div>
        </div>




    </asp:Panel>












</asp:Content>
