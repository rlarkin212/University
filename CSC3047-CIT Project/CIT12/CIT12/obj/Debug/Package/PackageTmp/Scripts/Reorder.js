$(function () {
    $("[id*=gvProductBacklog]").sortable({
        items: 'tr:not(tr:first-child)',
        cursor: 'pointer',
        axis: 'y',
        dropOnEmpty: false,
        start: function (e, ui) {
            ui.item.addClass("selected");
        },
        stop: function (e, ui) {
            ui.item.removeClass("selected");
        },
        receive: function (e, ui) {
            $(this).find("tbody").append(ui.item);
        }
    });
});