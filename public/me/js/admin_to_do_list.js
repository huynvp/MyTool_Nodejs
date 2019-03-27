$(document).ready( function () {
    let editor;
    loadAll();

    $('#table-work').on('click', '.btn-edit', function() {
        alert('Handle edit');
    })
    
    $('#table-work').on('click', '.btn-delete', function () {
        $.ajax({
            url: 'http://nodejs.local.huynguyen.com.vn/api/note/delete',
            type: 'DELETE',
            dataType: 'json',
            data: JSON.stringify({
                id: $(this).data("id")
            }),
            contentType: 'application/json'
        })
        .done(data => {
            console.log(data);
            loadAll();
        })
        .fail(err => {
            console.log(err)
        })
    })

    $('.datepicker').datepicker({
        format: 'yyyy/mm/dd',
    });
    
    ClassicEditor
    .create( document.querySelector( '#content' ) )
    .then( newEditor => {
        editor = newEditor;
    } )
    .catch( error => {
            console.error( error );
    } );

    $('#btn-add').on('click', () => {
        var data = {
            title: $("#title").val(),
            content: editor.getData(),
            date: $("#date").val()
        };

        $.ajax({
            url: 'http://nodejs.local.huynguyen.com.vn/api/note/add',
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json'
        })
        .done(data => {
            loadAll();

            //reset data input
            $('#title').val('');
            $('#date').val('');
            editor.setData('');
        })
        .fail(err => {
            console.log(err)
        })
    });
} );