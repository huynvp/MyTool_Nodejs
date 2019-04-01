function checkLogin() {
    if(localStorage.token == null)
        window.location.href = '/login.html'
}
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

function renderSelection(selector, selected_id=null) {
    $.ajax({
        url: 'http://nodejs.local.huynguyen.com.vn/api/note/show-level/',
        type: 'GET',
        dataType: 'json',
    })
    .done(function (data) {
        var xhtml = '';
        $(data.data).each(function (index, value) {
            if(value.level_id == selected_id) {
                xhtml += '<option selected value="'+ value.level_id +'">'+ value.level_name +'</option>';
            } else {
                xhtml += '<option value="'+ value.level_id +'">'+ value.level_name +'</option>';
            }
        })

        $(selector).html(xhtml);
    })
}

function loadDataAdmin(data) {
    var xhtml = '';
    $(data).each((index, val) => {
        xhtml += '<tr>';
        xhtml += '<td>'+ val.note_id +'</td>';
        xhtml += '<td><i class="fas fa-sticky-note"></i> '+ val.title +'</td>';
        xhtml += '<td><i class="fas fa-calendar-alt"></i> '+ formatDate(val.date) +'</td>';
        xhtml += '<td><i class="fas fa-calendar-alt"></i> '+ formatDate(val.created_at) +'</td>';
        xhtml += '<td><button type="button" class="btn btn-primary btn-edit" data-toggle="modal" data-target="#edit-note" data-id="'+ val.note_id +'"><i class="fas fa-edit"></i>Edit</button> ';
        xhtml += '<button type="button" class="btn btn-danger btn-delete" data-id="'+ val.note_id +'"><i class="fas fa-trash"></i> Delete</button></td>';
        xhtml += '</tr>';
    });
    $('#table-work').html(xhtml);
}

function loadData(data) {
    var xhtml = '';

    $(data).each(function(index, value) {
        var bg = 'text-white ';
        if(value.level_id == '1')
            bg += 'bg-info';
        else if(value.level_id == '2')
            bg += 'bg-success';
        else if(value.level_id == '3') 
            bg += 'bg-warning';
        else bg += 'bg-danger';

        xhtml += '<div class="col-8">';
        xhtml += '<div class="card">';
        xhtml += '<div class="card-header '+ bg +'"><b>' + value.title + '</div></b>';
        xhtml += '<div class="card-body"><p>'+ value.content + '</p>';
        xhtml += '<p><b><i>Deadline:</i></b> '+ formatDate(value.date) +'</p>';
        xhtml += '<p><b><i>Tình trạng:</i></b> '+ value.level_name +'</p></div>';
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
        loadDataAdmin(data.data);
    });
}