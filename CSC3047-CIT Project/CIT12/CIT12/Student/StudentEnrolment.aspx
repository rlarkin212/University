<%@ Page Title="Registration / Enrollement" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StudentEnrolment.aspx.cs" Inherits="CIT12.Student.StudentEnrollement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" type="text/css" href="../Content/modal.css" />

    <ul class="breadcrumb">
        <li><a href="StudentHome.aspx">Home</a></li>
        <li class="active">Registration / Enrolment</li>
    </ul>

    <div class="heading">
        <h3>Registration / Enrolment</h3>
    </div>

    <small>Progress</small>
    <div class="progress progress-striped active">
        <div class="progress-bar" style="width: 0%" id="progressBar" runat="server"></div>
    </div>

    <%--step 1--%>
    <asp:Panel ID="pnlStep1" runat="server">

        <div class="container">
            <h4>Step 1 - Personal Details </h4>

            <div class="row">
                <%--personal details --%>
                <h5 class="text-success"><strong><u>Personal Details</u></strong></h5>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalStudentNumber" class="control-label">Student Number</label>
                    <asp:TextBox ID="txtPersonalStudentNumber" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <label for="txtPersonalEmail" class="control-label">Email</label>
                    <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
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
                    <asp:TextBox ID="txtPersonalPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
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
                    <asp:TextBox ID="txtNextOfKinPhoneNumber" runat="server" CssClass="form-control"></asp:TextBox>
                </div>


            </div>

        </div>

        <br />
        <div class="clearfix"></div>
        <asp:Button ID="btnSubmitStep1" runat="server" Text="Proceed" CssClass="btn btn-lg btn-block btn-success" OnClick="btnSubmitStep1_Click" />


    </asp:Panel>

    <%----------------------step 2 modules-----------------%>
    <asp:Panel ID="pnlStep2" runat="server" Visible="false">
        <div class="container">

            <h4>Step 2 - Modules </h4>
            <small>All Modules Picked Must Add Up To 120 CAT Points</small>

            <asp:GridView ID="gvModulesToEnrollIn" runat="server" DataSourceID="dsModulesToEnrollIn" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Modules Are Found For This User" GridLines="None" CellSpacing="-1" Visible="false">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"></asp:BoundField>
                    <asp:BoundField DataField="CatPoints" HeaderText="CatPoints" SortExpression="CatPoints"></asp:BoundField>
                    <asp:BoundField DataField="PreReqModules" HeaderText="PreReqModules" SortExpression="PreReqModules"></asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnViewClassTime" runat="server" Text="View Class Times" CssClass="btn btn-sm btn-info" OnClick="btnViewClassTime_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <br />
            <br />

            <%--view class time modal--%>
            <div class="modal fade modal-allow-overflow" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">
                                <asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label></h4>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblModalBody" runat="server" Text=""></asp:Label>

                            <asp:ListView ID="lvModalBody" runat="server" DataSourceID="dsModalClassTime">
                                <ItemTemplate>
                                    <strong>
                                        <asp:Label ID="lblDay" runat="server" Text='<%# Eval("Day") %>'></asp:Label></strong>
                                    <asp:Label ID="lblTime" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                                    <div class="clearfix"></div>
                                </ItemTemplate>
                            </asp:ListView>

                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--modules lv--%>
        <asp:ListView ID="lvModules" runat="server" DataSourceID="dsModulesToEnrollIn">

            <ItemTemplate>

                <div class="container">
                    <div class="row">

                        <asp:Label ID="lblModuleId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <u>
                                <asp:Label ID="lblModuleTitle" runat="server" Text='<%# Eval("Title") %>' CssClass="h4"></asp:Label></u>
                        </div>
                        <div class="clearfix"></div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <strong>
                                <label for="lblModuleCode" class="control-label">Code : </label>
                            </strong>
                            <asp:Label ID="lblModuleCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                        </div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <strong>
                                <label for="lblCatPoints" class="control-label">CAT Points : </label>
                            </strong>
                            <asp:Label ID="lblCatPoints" runat="server" Text='<%# Eval("CatPoints") %>'></asp:Label>
                        </div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <strong>
                                <label for="lblPreReq" class="control-label">Pre Requisites : </label>
                            </strong>
                            <asp:Label ID="lblPreReq" runat="server" Text='<%# Eval("PreReqModules") %>'></asp:Label>
                        </div>

                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4">
                            <asp:Button ID="btnViewClassTime" runat="server" Text="View Class Times" CssClass="btn btn-sm btn-info" OnClick="btnViewClassTime_Click" />
                        </div>

                        <div class="clearfix"></div>
                        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4 pull-left">
                            <strong>
                                <asp:CheckBox ID="cbPickModule" runat="server" CssClass="checkbox control-label" Text="Enroll In Module" />
                            </strong>

                        </div>

                    </div>


                </div>

                <hr />
            </ItemTemplate>
        </asp:ListView>

        <asp:Label ID="lblStep2Error" runat="server" Text="" CssClass="text-danger"></asp:Label>

        <br />
        <br />
        <div class="row">
            <asp:Button ID="btnSubmitModules" runat="server" Text="Submit Modules" CssClass="btn btn-lg btn-primary pull-left" OnClick="btnSubmitModules_Click" />
            <asp:Button ID="btnManualEnrolement" runat="server" Text="Manual Enrolement" CssClass="btn btn-lg btn-danger pull-right" OnClick="btnManualEnrolement_Click" />
        </div>



        <%--modules datasource --%>
        <asp:SqlDataSource runat="server" ID="dsModulesToEnrollIn" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_modules.Id, tbl_modules.Title, tbl_modules.Code, tbl_modules.CatPoints, tbl_modules.PreReqModules FROM tbl_modules INNER JOIN tbl_studentCourse ON tbl_modules.CourseId = tbl_studentCourse.CourseId WHERE (tbl_modules.Level = @studentLevel) AND (tbl_studentCourse.StudentId = @studentId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_studentLevel" Name="studentLevel" Type="Int32"></asp:SessionParameter>
                <asp:SessionParameter SessionField="s_loggedUserId" Name="studentId"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

        <%--timetable modal datasource--%>
        <asp:SqlDataSource ID="dsModalClassTime" runat="server" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT tbl_days.Day, tbl_timeTable.Time FROM tbl_days INNER JOIN tbl_timeTable ON tbl_days.Id = tbl_timeTable.DayId WHERE (tbl_timeTable.ModuleId = @moduleId)">
            <SelectParameters>
                <asp:SessionParameter SessionField="s_moduleIdForTimetable" Name="moduleId" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>

    </asp:Panel>

    <%---------------------step 3 fees---------------------%>
    <asp:Panel ID="pnlStep3" runat="server" Visible="false">
        <div class="container">
            <h4>Step 3 - Fees </h4>

            <%--student finance div--%>
            <div class="row" id="FeesDiv" runat="server">

                <h5>Your fees are £
                    <asp:Label ID="lblStudentFinanceCost" runat="server" Text=""></asp:Label>
                    . How will you decide to pay ?</h5>
                <asp:Button ID="btnContinuePayment" runat="server" Text="Continue To Payment" CssClass="btn btn-primary btn-lg" OnClick="btnContinuePayment_Click" />
            </div>

            <%--button div--%>
            <div class="row" id="PayOptionsButtonsDiv" runat="server" visible="false">

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <h5><strong>How will you be paying for your fees ?</strong></h5>
                    <br />
                </div>

                <div class="clearfix"></div>

                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <asp:Button ID="btnStudentFinanceOption" runat="server" Text="Student Finance" CssClass="btn btn-primary btn-lg" OnClick="btnStudentFinanceOption_Click" />
                </div>
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    <asp:Button ID="btnPrivateFinanceOption" runat="server" Text="Private Finance" CssClass="btn btn-primary btn-lg" OnClick="btnPrivateFinanceOption_Click" />
                </div>
            </div>

            <%--studentFinanceOptionDiv--%>
            <div class="container" id="StudentFinanceOptionDiv" runat="server" visible="false">

                <div class="row">
                    <div class="col-xs-12 col-md-4">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Student Finance Payment</h3>
                                <br />
                                <label class="control-label" for="lblOutstandingFees">Outstanding Fees : £ </label>
                                <asp:Label ID="lblStudnetFinanceOutstandingFees" runat="server" Text="" CssClass="h5"></asp:Label>
                            </div>

                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="txtCardNumber">Confirm Payment</label>
                                    <div class="input-group">
                                        <label class="h5">Please Confirm That The Student Finance Company Will Be Paying Your Outstanding Fees</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:Button ID="btnSubmitStudentFinancePayment" runat="server" Text="Pay" CssClass="btn btn-success btn-lg btn-block" OnClick="btnSubmitStudentFinancePayment_Click" />
                    </div>


                </div>

            </div>

            <%--privateFinanceOptionDiv--%>
            <div class="container" id="PrivateFinanceOptionDiv" runat="server" visible="false">

                <div class="row">
                    <div class="col-xs-12 col-md-4">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Payment Details</h3>
                                <br />
                                <label class="control-label" for="lblOutstandingFees">Outstanding Fees : £ </label>
                                <asp:Label ID="lblPrivateFinanceOutstandignFees" runat="server" Text="" CssClass="h5"></asp:Label>
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
                                         <label for="expityMonth">EXPIRY DATE</label>
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

                        <asp:Label ID="lblProvatePaymentError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                        <br />

                        <asp:Button ID="btnSubmitPrivatePayment" runat="server" Text="Pay" CssClass="btn btn-success btn-lg btn-block" OnClick="btnSubmitPrivatePayment_Click" />
                    </div>
                </div>

            </div>

            <%--step 3 container end--%>
        </div>
    </asp:Panel>

    <%---------------------Success---------------------%>
    <asp:Panel ID="pnlSuccess" runat="server" Visible="false">

        <div class="heading">
            <h1 class="text-success">Success</h1>
        </div>

        <div>
            <h3>You have successfully been registered and enrolled ! </h3>
        </div>

        <div>
            <h4>Time Table</h4>
            <asp:GridView ID="gvStudentTimetable" runat="server" DataSourceID="dsStudentTimetable" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-responsive table-striped table-condensed table-hover" EmptyDataText="No Timetable Is Found For This User, Check You Have Been Enrolled Correctly" GridLines="None" CellSpacing="-1">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day"></asp:BoundField>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"></asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time"></asp:BoundField>
                    <asp:BoundField DataField="StudentId" HeaderText="StudentId" SortExpression="StudentId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                    <asp:BoundField DataField="DayId" HeaderText="DayId" SortExpression="DayId" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsStudentTimetable" ConnectionString='<%$ ConnectionStrings:ApplicationConnection %>' SelectCommand="SELECT DISTINCT tbl_timeTable.Id, tbl_days.Day, tbl_modules.Title, tbl_classType.Type, tbl_timeTable.Time, tbl_studentModule.StudentId, tbl_timeTable.DayId FROM tbl_timeTable INNER JOIN tbl_days ON tbl_timeTable.DayId = tbl_days.Id INNER JOIN tbl_modules ON tbl_timeTable.ModuleId = tbl_modules.Id INNER JOIN tbl_classType ON tbl_timeTable.ClassTypeId = tbl_classType.Id INNER JOIN tbl_studentModule ON tbl_timeTable.ModuleId = tbl_studentModule.ModuleId WHERE (tbl_studentModule.StudentId = @loggedUserId AND tbl_studentModule.Complete = @complete) ORDER BY tbl_timeTable.DayId ASC">
                <SelectParameters>
                    <asp:SessionParameter Name="loggedUserId" SessionField="s_loggedUserId" Type="Int32"></asp:SessionParameter>
                    <asp:Parameter DefaultValue="0" Name="complete"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>






    </asp:Panel>

    <%---------------------Manual Enrolement---------------------%>
    <asp:Panel ID="pnlManualEnrolement" runat="server" Visible="false">

        <div class="heading">
            <h1>Manual Enrolement Request</h1>
        </div>
        <br />

        <div>
            <h4>You have requested to be submitted for manual enrolement</h4>
            <h6>A request will be sent to your advisor of studies and a meeting will be made to get you enrolled </h6>


            <asp:Label ID="lblManualEnrolementSuccess" runat="server" Text="" CssClass="text-success"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnSubmitManualEnrolement" runat="server" Text="Submit Request" CssClass="btn btn-lg btn-danger" OnClick="btnSubmitManualEnrolement_Click" />
            <a href="StudentHome.aspx" class="btn btn-lg btn-success" runat="server" id="btnReturnHome" visible="false">Return To Student Dashboard</a>

        </div>

    </asp:Panel>


</asp:Content>
