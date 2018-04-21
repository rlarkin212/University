$(document).ready(function () {

    var d = new Date();

    var month = d.getMonth() + 1;
    var day = d.getDate();

    var currentDate = d.getFullYear() + '/' +
        (month < 10 ? '0' : '') + month + '/' +
        (day < 10 ? '0' : '') + day;

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay'
        },
        defaultDate: currentDate,
        navLinks: true, // can click day/week names to navigate views
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: [
            //november
            {
                title: 'All Day Event',
                start: '2017-11-01'
            },
            {
                title: 'Long Event',
                start: '2017-11-07',
                end: '2017-11-10'
            },
            {
                id: 999,
                title: 'CSC2012',
                start: '2017-11-09T16:00:00'
            },
            {
                id: 999,
                title: 'CSC2012',
                start: '2017-11-16T16:00:00'
            },
            {
                title: 'Conference',
                start: '2017-11-11',
                end: '2017-11-13'
            },
            {
                title: 'Meeting',
                start: '2017-11-12T10:30:00',
                end: '2017-11-12T12:30:00'
            },
            {
                title: 'Lunch',
                start: '2017-11-12T12:00:00'
            },
            {
                title: 'Meeting',
                start: '2017-11-12T14:30:00'
            },
            {
                title: 'Happy Hour',
                start: '2017-11-12T17:30:00'
            },
            {
                title: 'Dinner',
                start: '2017-11-12T20:00:00'
            },
            {
                title: 'Birthday Party',
                start: '2017-11-13T07:00:00'
            },

            //december
            {
                title: 'All Day Event',
                start: '2017-12-01'
            },
            {
                title: 'Long Event',
                start: '2017-12-07',
                end: '2017-12-10'
            },
            {
                id: 999,
                title: 'CSC2012',
                start: '2017-12-09T16:00:00'
            },
            {
                id: 999,
                title: 'CSC2012',
                start: '2017-12-16T16:00:00'
            },
            {
                title: 'Conference',
                start: '2017-12-11',
                end: '2017-12-13'
            },
            {
                title: 'Meeting',
                start: '2017-12-12T10:30:00',
                end: '2017-12-12T12:30:00'
            },
            {
                title: 'Lunch',
                start: '2017-12-12T12:00:00'
            },
            {
                title: 'Meeting',
                start: '2017-12-12T14:30:00'
            },
            {
                title: 'Happy Hour',
                start: '2017-12-12T17:30:00'
            },
            {
                title: 'Dinner',
                start: '2017-12-12T20:00:00'
            },
            {
                title: 'Birthday Party',
                start: '2017-12-13T07:00:00'
            },
        ]
    });

});