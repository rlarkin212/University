$(document).ready(function () {

    $('<%=StudentFinanceDiv.ClientID%>').hide();


    //student finance btn click
    function studentFinanceClick() {
        $(document.getElementById('<%=StudentFinanceDiv.ClientID%>')).show();
        $document.getElementById('<%=PayOptionsButtons.ClientID%>').hide();
    }









});