function printGV(gvname) {
    var prtContent = document.getElementById('<%= ' + gvname + '.ClientID %>');
    prtContent.border = 0; //set no border here
    var WinPrint = window.open('', '', 'left=200,top=200,width=1000,height=1000,toolbar=0,scrollbars=1,status=0,resizable=1');
    WinPrint.document.write(prtContent.outerHTML);
    WinPrint.document.close();
    WinPrint.focus();
    WinPrint.print();
    WinPrint.close();
}
