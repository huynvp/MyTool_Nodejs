function formatDate(date) {
    if(date == null) return null;
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [day, month, year].join('-');
}

function formatDateDb(date) {
    if(date == null) return null;
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('/');
}

function loadDataAdmin(data) {
    var xhtml = '';
    $(data).each((index, val) => {
        xhtml += '<tr>';
        xhtml += '<td>'+ val.note_id +'</td>';
        xhtml += '<td>'+ val.title +'</td>';
        xhtml += '<td>'+ formatDate(val.date) +'</td>';
        xhtml += '<td>'+ formatDate(val.created_at) +'</td>';
        xhtml += '<td><button type="button" class="btn btn-primary btn-edit" data-toggle="modal" data-target="#edit-note" data-id="'+ val.note_id +'">Edit</button> ';
        xhtml += '<button type="button" class="btn btn-danger btn-delete" data-id="'+ val.note_id +'">Delete</button></td>';
        xhtml += '</tr>';
    });
    $('#table-work').html(xhtml);
}

function loadData(data) {
    var xhtml = '';

    $(data).each(function(index, value) {
        xhtml += '<div class="col-8">';
        xhtml += '<div class="card">';
        xhtml += '<div class="card-header"><b>' + value.title + '</div></b>';
        xhtml += '<div class="card-body"><p>'+ value.content + '</p>';
        xhtml += '<p><b><i>Deadline:</i></b> '+ formatDate(value.date) +'</p></div>';
        xhtml += '</div>';
        xhtml += '</div>';
    });

    $('#work-list').html(xhtml);
}

function loadAll() {
    $.ajax({
        url: 'http://nodejs.local.huynguyen.com.vn/api/note/show-all',
        type: 'GET'
    })
    .done(data => {
        loadDataAdmin(data);
    });
}