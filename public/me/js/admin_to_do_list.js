$(document).ready( function () {
    let editor;
    let editor_edit;
    loadAll();

    $('#table-work').on('click', '.btn-edit', function() {
        $.ajax({
            url: 'http://nodejs.local.huynguyen.com.vn/api/note/show/' + $(this).data("id"),
            type: 'GET',
            dataType: 'json',
        })
        .done(data => {
            console.log(data)

            $('#id-edit').val(data[0]['note_id'])
            $('#title-edit').val(data[0]['title'])
            $('#date-edit').val(formatDateDb(data[0]['date']))
            editor_edit.setData(data[0]['content'])
        })
        .fail(err => {
            console.log(err)
        })
    })

    $('#btn-edit').on('click', function() {
        var data = {
            id: $("#id-edit").val(),
            title: $("#title-edit").val(),
            content: editor_edit.getData(),
            date: $("#date-edit").val()
        };

        $.ajax({
            url: 'http://nodejs.local.huynguyen.com.vn/api/note/update',
            type: 'PUT',
            dataType: 'json',
            data: JSON.stringify(data),
            contentType: 'application/json'
        })
        .done(data => {
            Swal.fire(
                'Thành công!',
                'Cập nhật ghi chú thành công.',
                'success'
            )
            loadAll();
        })
        .fail(err => {
            console.log(err)
        })
    })
    
    $('#table-work').on('click', '.btn-delete', function () {
        Swal.fire({
            title: 'Bạn có chắc?',
            text: "Bạn có muốn xóa ghi chú này không?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Đồng ý!'
          }).then((result) => {
            if (result.value) {
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
                    Swal.fire(
                        'Đã xóa!',
                        'Xóa thành công ghi chú này.',
                        'success'
                    )
                    loadAll();
                })
                .fail(err => {
                    console.log(err)
                })
            }
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

    ClassicEditor
    .create( document.querySelector( '#content-edit' ) )
    .then( newEditor => {
        editor_edit = newEditor;
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
            Swal.fire(
                'Thành công!',
                'Thêm ghi chú thành công.',
                'success'
            )
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